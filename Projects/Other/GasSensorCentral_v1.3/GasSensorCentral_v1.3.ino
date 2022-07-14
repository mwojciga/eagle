/*
CU: Maciej Wójciga
CD: 20150907
MD: 20160306
HW: GasSensorModule_v3.0
Desc: Gas central unit software.

CHANGELOG
20150908: Initial software.
20160306: Code copied from GasSensorModule_v1.00

SENSOR PINS:
PB2: DHT
PD6: PIR
A0: LIGHT
A1: GAS

BUTTON PINS:
PD2: BUTTON1
PD3: BUTTON2
PD4: BUTTON3
PD5: BUTTON4

LED PINS:
A0: LED1
A2: LED2
PD6: LED3
PB2: LED4 - digital pin 10

TODO:
If button pressed, send SMS with the module code and pressed button number. Appropriate LED starts to blink.
If second button pressed, send SMS with the module code and pressed button number. Additional LED should turn on, which will indicate a queue.
If an SMS from AT with appropriate code is received, turn the relevant LED off.
Receiving SMS from AT should result in one of the following:
- module reset;
- sending SMS with info like uptime, signal strength, etc.
- get module parameters;
- set module parameters (heart beat frequency, life check, AT central number, etc)
- module deactivation;
- module activation;
Once a day, the module should send an info SMS to AT.

CENTRAL MODULE:
1. Listens for messages from sensors.
2. Analyzes the messages and sends info through GSM.

EEPROM:
0-6: customerID
7-9: sensorID

Notes:
Max 32 characters can be sent at one time.
S PL1234 12 23 123 40 1 00 E
Start[1], customerID[6], sensorID[2], OT[2], LT[3], GZ[3], HO[2], PR[1], statusCode[2], End[1]

SENSOR:
1. Gets info from all of the sensors every x seconds.
2. Listens for requests from centralModule and answers.
3. Every sensor should have a treshold (max and sometimes min) value. If passed, send info to centralModule.
4.

EEPROM:
0-6: customerID
7-9: sensorID

*/


#include <SoftwareSerial.h>
#include <EEPROM.h>
#include <dht.h>
#include <nRF24L01.h>
#include <RF24.h>
#include <RF24_config.h>
#include <SPI.h>
#include "printf.h"

RF24 radio(8, 7);
//SoftwareSerial GPRS(7, 8);
dht DHT11;

// Define constraints.
#define BUTTON1 2
#define BUTTON2 3
#define BUTTON3 4
#define BUTTON4 5

#define LED1 A0
#define LED2 A2
#define LED3 6
#define LED4 10

#define DHT 10
#define PIR 6
#define LIGHT A0
#define GAS A1

// Define global variables.
boolean button1State;
boolean button2State;
boolean button3State;
boolean button4State;

// Mode: 0 receive, 1 transmit.
boolean mode = 0;

// String to send.
char toSend[32];

boolean debug = 1; // Debug mode.
char customerID[7] = "PL0001"; // Put the default ID here. It can be always changed using writeToEEPROM function.
int customerIdArraySize = sizeof(customerID); // Must be the exact length of customerID[7] array (the array size is 7 because of the null character at the end of the string).
char sensorID[3] = "00";// Put the default ID here. It can be always changed using writeToEEPROM function.
int sensorIdArraySize = sizeof(sensorID); // Must be the exact length of customerID[7] array (the array size is 7 because of the null character at the end of the string).

boolean dataError = 0;
int timeout = 1000;
char statusCode[3] = "00";

// Data, error and pins.
int dataOT = 0;
boolean errorOT = 0;
int dataLT = 0;
boolean errorLT = 0;
int dataGZ = 0;
boolean errorGZ = 0;
int dataHO = 0;
boolean errorHO = 0;
int dataPR = 0;
boolean errorPR = 0;

String dataStr = "";

// Thresholds.
int maxOT = 50;
int minOT = 10;
int maxLT = 500;
int minLT = 0;
int maxGZ = 100;
int minGZ = 0;
int maxHO = 70;
int minHO = 0;
int maxPR = 1;
int minPR = 0;

void setup() {
  //GPRS.begin(19200); // In v2.4 board version, we communicate using RXTX ports, not Software Serial.
  Serial.begin(19200);
  pinMode(BUTTON1, INPUT);
  pinMode(BUTTON2, INPUT);
  pinMode(BUTTON3, INPUT);
  pinMode(BUTTON4, INPUT);
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
  pinMode(LED4, OUTPUT);
  printf_begin();
  /*// Radio.
  printf_begin(); // It must be here!
  radio.begin();
  radio.setRetries(15, 15); // optionally, increase the delay between retries & # of retries
  radio.openWritingPipe(pipes[0]);
  radio.openReadingPipe(1, pipes[1]);
  radio.startListening();
  if (debug) radio.printDetails();*/
  // Write IDs.
  //writeCustomerIDToEEPROM(customerID);
  //writeSensorIDToEEPROM(sensorID);
  // Read IDs.
  readCustomerIDFromEEPROM();
  readSensorIDFromEEPROM();
  if (debug) printf("customerID: %s\nsensorID: %s\n", customerID, sensorID);
}

void loop() {
  // Get data form sensors.
  getAllSensorData();
  // Analyze the data.
  dataError = analyzeData();
  // Check if any button is pressed. If yes, send SMS.
  checkButtonStates();
  // Check connection with sensors.
  checkConnectionWithSensors();
  if (dataError) {
    // Send a message with all data to the CM.
    mode = 1;
    prepareStringToSend();
  }
  /*if (!mode) {
    // RECEIVE.
    if (radio.available()) {
      // Dump the payloads until we've gotten everything
      char gotText[32] = {0};
      bool done = false;
      while (!done) {
        done = radio.read(&gotText, sizeof(gotText)); // Fetch the payload, and see if this was the last one.
        if (debug) printf("Received message: %s\n", gotText);
        analyzeReceivedText(gotText); // Do something with the received text.
        //delay(20); // Delay just a little bit to let the other unit make the transition to receiver.
      }
    }
  }
  if (mode) {
    // TRANSMIT.
    radio.stopListening(); // First, stop listening so that we can talk.
    bool sentSuccessfully = radio.write(&toSend, sizeof(toSend));
    if (sentSuccessfully) {
      if (debug) printf("Message sent: %s\n", toSend);
      mode = 0; // Go into receive mode.
    } else {
      if (debug) printf("Couldn't send the message!\n");
    }
    radio.startListening(); // Continue listening
  }*/
  delay(timeout);
}

void getAllSensorData() {
  // Get data from all sensors and put it to global variables.
  getTempAndHumidity();
  getLightValue();
  getGasValue();
  getPIRValue();
  if (debug) printf("DataOT: %i\nDataLT: %i\nDataGZ: %i\nDataHO: %i\nDataPR: %i\n", dataOT, dataLT, dataGZ, dataHO, dataPR);
}

void getTempAndHumidity() {
  // TEMPERATURE.
  DHT11.read11(DHT);
  dataOT = DHT11.temperature, 1;
  dataHO = DHT11.humidity, 1;
}

void getLightValue() {
  // LIGHT.
  dataLT = analogRead(LIGHT);
}

void getGasValue() {
  // GAS.
  dataGZ = analogRead(GAS);
}

void getPIRValue() {
  // PIR.
  dataPR = digitalRead(PIR);
}

void checkNRF24L01() {
  //radio.printDetails();
}

boolean checkConnectionWithSensors() {
  // TODO
  // Sent a specific message, and measure the time.
  return 1;
}

boolean analyzeData() {
  // Analyze data from all sensors. If any of the tresholds are passed, return true.
  if (dataOT < minOT || dataOT > maxOT) {
    errorOT = 1;
  }
  if (dataLT < minLT || dataLT > maxLT) {
    errorLT = 1;
  }
  if (dataGZ < minGZ || dataGZ > maxGZ) {
    errorGZ = 1;
  }
  if (dataHO < minHO || dataHO > maxHO) {
    errorHO = 1;
  }
  if (dataPR < minPR || dataPR > maxPR) {
    errorPR = 1;
  }
  if (debug) printf("ErrorOT: %i\nErrorLT: %i\nErrorGZ: %i\nErrorHO: %i\nErrorPR: %i\n", errorOT, errorLT, errorGZ, errorHO, errorPR);
  if (errorOT || errorLT || errorGZ || errorHO || errorPR) {
    setStatusCode(0, 2);
    return 1;
  } else {
    return 0;
  }
}

void prepareStringToSend() {
  // Get all values that we need, concatenate and make a char array at the end.
  // S PL1234 12 23 123 40 1 00 E
  // Start[1], customerID[6], sensorID[2], OT[2], LT[3], GZ[3], HO[2], PR[1], statusCode[2], End[1]
  // Concatenate.
  String toSendString = "";
  toSendString.concat("S");
  toSendString.concat(customerID);
  toSendString.concat(sensorID);
  toSendString.concat(addZerosToData(dataOT, 2));
  toSendString.concat(addZerosToData(dataLT, 3));
  toSendString.concat(addZerosToData(dataGZ, 3));
  toSendString.concat(addZerosToData(dataHO, 2));
  toSendString.concat(addZerosToData(dataPR, 1));
  toSendString.concat(statusCode);
  toSendString.concat("E");
  toSendString.toCharArray(toSend, 32);
  if (debug) printf("toSendString: %s\n", toSend);
}

void writeCustomerIDToEEPROM(char customerID[]) {
  int startByte = 0; // Always start from 0 byte in EEPROM.
  for (int i = 0; i < customerIdArraySize; i++) {
    if (debug) printf("Writing %c on %i byte\n", customerID[i], startByte + i);
    EEPROM.write(startByte + i, customerID[i]);
  }
}

void readCustomerIDFromEEPROM() {
  int startByte = 0; // Always start from 0 byte in EEPROM.
  for (int i = 0; i < customerIdArraySize; i++) {
    customerID[i] = EEPROM.read(startByte + i);
    if (debug) printf("Read %i byte: %c\n", startByte + i, customerID[i]);
  }
}

void writeSensorIDToEEPROM(char sensorID[]) {
  int startByte = 7; // Always start from 7 byte in EEPROM.
  for (int i = 0; i < sensorIdArraySize; i++) {
    if (debug) printf("Writing %c on %i byte\n", sensorID[i], startByte + i);
    EEPROM.write(startByte + i, sensorID[i]);
  }
}

void readSensorIDFromEEPROM() {
  int startByte = 7; // Always start from 7 byte in EEPROM.
  for (int i = 0; i < sensorIdArraySize; i++) {
    sensorID[i] = EEPROM.read(startByte + i);
    if (debug) printf("Read %i byte: %c\n", startByte + i, sensorID[i]);
  }
}

void sendSMS(int button) {
  // Text mode.
  Serial.println("AT+CMGF=1\r");
  delay(100);
  // Receivers number.
  Serial.println("AT + CMGS = \"+48691464561\"");
  delay(100);
  // SMS text.
  Serial.println("SMS text here.");
  delay(100);
  Serial.println((char)26);//the ASCII code of the ctrl+z is 26
  delay(100);
  if (debug) printf("SMS sended.\n");
}

void receiveSMS() {
  // Receive SMS.
  if (debug) printf("SMS received.\n");
}

void onLED(int led) {
  digitalWrite(led, HIGH);
  if (debug) printf("LED %i turned on.\n", led);
}

void offLED(int led) {
  digitalWrite(led, LOW);
  if (debug) printf("LED %i turned off.\n", led);
}

void checkButtonStates() {
  // Check button states.
  button1State = digitalRead(BUTTON1);
  button2State = digitalRead(BUTTON2);
  button3State = digitalRead(BUTTON3);
  button4State = digitalRead(BUTTON4);
  if (debug) printf("Button states: [%i %i %i %i]\n", button1State, button2State, button3State, button4State);
  if (button1State == 1) {
    sendSMS(1);
  } else if (button2State == 1) {
    sendSMS(2);
  } else if (button3State == 1) {
    sendSMS(3);
  } else if (button4State == 1) {
    sendSMS(4);
  }
}

void analyzeReceivedText(String receivedText) {
  /*
  The message looks like this:
  S[methodID][argument]E
  S[00][1234567890]E
  ex. S130987654321E
  */
  char method[3];
  method[0] = receivedText[1];
  method[1] = receivedText[2];
  char argument[10];
  argument[0] = receivedText[3];
  argument[1] = receivedText[4];
  argument[2] = receivedText[5];
  argument[3] = receivedText[6];
  argument[4] = receivedText[7];
  argument[5] = receivedText[8];
  argument[6] = receivedText[9];
  argument[7] = receivedText[10];
  argument[8] = receivedText[11];
  argument[9] = receivedText[12];
  if (debug) printf("Received method ID: %s, argument: %s\n", method, argument);
  callMethod(atoi(method), argument);
}

void changeDebugMode(int debugMode) {
  debug = debugMode;
  if (debug) printf("Debug mode: %d\n", debug);
}

void changeTimeout(int newTimeout) {
  timeout = newTimeout;
  if (debug) printf("New timeout: %d\n", timeout);
}

String addZerosToData(int data, byte dataLenght) {
  byte howManyZeros = 0;
  if (data < 10) {
    howManyZeros = dataLenght - 1;
  } else if (data >= 10 && data < 100) {
    howManyZeros = dataLenght - 2;
  } else if (data >= 100 && data < 1000) {
    howManyZeros = dataLenght - 3;
  } else {
    if (debug) printf("Something is wrong with the data: %d\n", data);
    setStatusCode(0, 1);
  }
  dataStr = "";
  for (int i = 0; i < howManyZeros; i++) {
    dataStr.concat("0");
  }
  dataStr.concat(data);
  return dataStr;
}

void callMethod(int methodID, char argument[]) {
  switch (methodID) {
    case 0 :
      if (debug) printf("Calling method %d, getAllSensorData, %s\n", methodID, argument);
      getAllSensorData();
    case  1 :
      if (debug) printf("Calling method %d, writeCustomerIDToEEPROM, %s\n", methodID, argument);
      writeCustomerIDToEEPROM(argument);
      break;
    case  2 :
      if (debug) printf("Calling method %d, readCustomerIDFromEEPROM, %s\n", methodID, argument);
      readCustomerIDFromEEPROM();
      break;
    case  3 :
      if (debug) printf("Calling method %d, writeSensorIDToEEPROM, %s\n", methodID, argument);
      writeSensorIDToEEPROM(argument);
      break;
    case  4 :
      if (debug) printf("Calling method %d, readSensorIDFromEEPROM, %s\n", methodID, argument);
      readSensorIDFromEEPROM();
      break;
    case 5 :
      if (debug) printf("Calling method %d, changeDebugMode, %s\n", methodID, argument);
      changeDebugMode(argument[0] - '0'); // Convert first item of array into integer.
      break;
    case 6 :
      if (debug) printf("Calling method %d, checkNRF24L01, %s\n", methodID, argument);
      checkNRF24L01();
      break;
    case 7 :
      if (debug) printf("Calling method %d, changeTimeout, %s\n", methodID, argument);
      changeTimeout(atoi(argument)); // Convert first item of array into integer.
      break;
  }
}

void setStatusCode(char firstCode, char secondCode) {
  statusCode[0] = firstCode;
  statusCode[1] = secondCode;
  if (debug) printf("Status code set to: %i%i\n", statusCode[0], statusCode[1]);
}

