/*
CU: Maciej Wójciga
CD: 20150907
LU: 20150920
HW: GasSensorModule_v2.1
Desc: Gas sensor software.

CHANGELOG
20150920: Working, gathering signals, analyzing, transmiting to central unit.
20150908: Initial software.

TODO
1. Change thresholds methods, change minGZ, change maxGZ, etc.
 
SENSOR PINS:
PC0: GAS
PC1: TEMP
PC2: LIGHT
PC3: DHT
PD2: MOTION
PD3: LED1
PD4: BUTTON1
PD7: CSN
PB0: CE
PB3: MOSI
PB4: MISO
PB5: SCK

Notes:
Max 32 characters can be sent at one time.
S PL1234 12 23 123 40 1 00 E
Start[1], customerID[6], sensorID[2], OT[2], LT[3], GZ[3], HO[2], PR[1], statusCode[2], End[1]

PINS:
GZ - A0
OT - A1
LT - A2
HO - A3
PR - D2

SENSOR:
1. Gets info from all of the sensors every x seconds.
2. Listens for requests from centralModule and answers.
3. Every sensor should have a treshold (max and sometimes min) value. If passed, send info to centralModule.
4. 

EEPROM:
0-6: customerID
7-9: sensorID
*/

#include <SPI.h>
#include <EEPROM.h>
#include "nRF24L01.h"
#include "RF24.h"
#include "printf.h"
#include <dht.h>

RF24 radio(8,7);
dht DHT;

// Radio pipe addresses for the 2 nodes to communicate.
const uint64_t pipes[2] = { 0xF0F0F0F0E1LL, 0xF0F0F0F0D2LL };

// Mode: 0 receive, 1 transmit.
boolean mode = 0;

// String to send.
char toSend[32];

// Other.
boolean debug = 1; // Debug mode.
char customerID[7] = "PL1234"; // Put the default ID here. It can be always changed using writeToEEPROM function.
int customerIdArraySize = sizeof(customerID); // Must be the exact length of customerID[7] array (the array size is 7 because of the null character at the end of the string).
char sensorID[3] = "12";// Put the default ID here. It can be always changed using writeToEEPROM function.
int sensorIdArraySize = sizeof(sensorID); // Must be the exact length of customerID[7] array (the array size is 7 because of the null character at the end of the string).

boolean dataError = 0;
int timeout = 10000;
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

// Pins.
int pinGZ = A0;
int pinOT = A1;
int pinLT = A2;
int pinHO = A3;
int pinPR = 2;

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

void setup(void)
{
  Serial.begin(57600);
  // Pins.
  pinMode(pinGZ, INPUT);
  pinMode(pinOT, INPUT);
  pinMode(pinLT, INPUT);
  pinMode(pinHO, INPUT);
  pinMode(pinPR, INPUT);  
  // Radio.
  printf_begin(); // It must be here!
  radio.begin();
  radio.setRetries(15,15); // optionally, increase the delay between retries & # of retries
  radio.openWritingPipe(pipes[0]);
  radio.openReadingPipe(1,pipes[1]);
  radio.startListening();
  if (debug) radio.printDetails();
  // Write IDs.
  //writeCustomerIDToEEPROM(customerID);
  //writeSensorIDToEEPROM(sensorID);
  // Read IDs.
  readCustomerIDFromEEPROM();
  readSensorIDFromEEPROM();
  if (debug) printf("customerID: %s\nsensorID: %s\n", customerID, sensorID);
  // Other functions.
  //callMethod(1, "EU4321");
  //callMethod(2, "");
  //callMethod(3, "24");
  //callMethod(4, "");
  //callMethod(5, "1");
  //callMethod(6, "");
  //callMethod(7, "10000");
}

void loop(void)
{
  // Get data form sensors.
  getAllSensorData();
  // Analyze the data.
  dataError = analyzeData();
  // Check connection with CM.
  checkConnectionWithCM();
  if (dataError) {
    // Send a message with all data to the CM.
    mode = 1;
    prepareStringToSend();
  }
  if (!mode) {
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
  }
  delay(timeout);
}

void getAllSensorData() {
  // Get data from all sensors and put it to global variables.
  getOT();
  getLT();
  getGZ();
  getHO();
  getPR();
  // Just for Developement.
  /*dataOT = 52;
  dataLT = 1;
  dataGZ = 2;
  dataHO = 3;
  dataPR = 1;*/
  if (debug) printf("DataOT: %i\nDataLT: %i\nDataGZ: %i\nDataHO: %i\nDataPR: %i\n", dataOT, dataLT, dataGZ, dataHO, dataPR);
}

void getOT() {
  // TEMPERATURE.
  //dataOT = analogRead(pinOT);
  //dataOT = dataOT * 0.48828125;
  int chk = DHT.read11(pinHO);
  dataOT = DHT.temperature,1;
}

void getLT() {
  // LIGHT.
 dataLT = analogRead(pinLT); 
}

void getGZ() {
  // GAS.
  dataGZ = analogRead(pinGZ);
}

void getHO() {
  // HUMIDITY.
  //Serial.print("DHT11, ");
  int chk = DHT.read11(pinHO);
  /*switch (chk)
  {
    case DHTLIB_OK:  
    Serial.print("OK, "); 
    break;
    case DHTLIB_ERROR_CHECKSUM: 
    Serial.print("Checksum error, "); 
    break;
    case DHTLIB_ERROR_TIMEOUT: 
    Serial.print("Time out error, "); 
    break;
    default: 
    Serial.print("Unknown error, "); 
    break;
  }
  Serial.print(DHT.humidity,1);
  Serial.print(", ");
  Serial.println(DHT.temperature,1);*/
  dataHO = DHT.humidity,1;
}

void getPR() {
  // PIR.
  dataPR = digitalRead(pinPR);
}

void checkNRF24L01() {
  radio.printDetails();
}

boolean checkConnectionWithCM() {
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
  toSendString.toCharArray(toSend,32);
  if (debug) printf("toSendString: %s\n", toSend);
}

void writeCustomerIDToEEPROM(char customerID[]) {
  int startByte = 0; // Always start from 0 byte in EEPROM.
  for (int i = 0; i < customerIdArraySize; i++) {
    //if (debug) printf("Writing %i on %i byte\n", customerID[i], startByte + i);
    EEPROM.write(startByte + i, customerID[i]);
  }
}

void readCustomerIDFromEEPROM() {
  int startByte = 0; // Always start from 0 byte in EEPROM.
  for (int i = 0; i < customerIdArraySize; i++) {
    customerID[i] = EEPROM.read(startByte + i);
    //if (debug) printf("Read %i byte: %c\n", startByte + i, customerID[i]);
  }
}

void writeSensorIDToEEPROM(char sensorID[]) {
  int startByte = 7; // Always start from 7 byte in EEPROM.
  for (int i = 0; i < sensorIdArraySize; i++) {
    //if (debug) printf("Writing %i on %i byte\n", sensorID[i], startByte + i);
    EEPROM.write(startByte + i, sensorID[i]);
  }
}

void readSensorIDFromEEPROM() {
  int startByte = 7; // Always start from 7 byte in EEPROM.
  for (int i = 0; i < sensorIdArraySize; i++) {
    sensorID[i] = EEPROM.read(startByte + i);
    //if (debug) printf("Read %i byte: %c\n", startByte + i, sensorID[i]);
  }
}

void analyzeReceivedText(String receivedText) {
  /*
  The message looks like this:
  S[methodID][argument]E
  S[00][1234567890]E
  ex. S130987654321E
  */
  char* method = "12";
  method[0] = receivedText[1];
  method[1] = receivedText[2];
  char* argument = "1234567890";
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
    // statusCode = {"0", "1"}; jak to kuzwa zrobic
  }
  dataStr = "";
  for (int i = 0; i < howManyZeros; i++) {
    dataStr.concat("0");
  }
  dataStr.concat(data);
  return dataStr;
}
 
void callMethod(int methodID, char argument[]) {
  switch(methodID) {
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

