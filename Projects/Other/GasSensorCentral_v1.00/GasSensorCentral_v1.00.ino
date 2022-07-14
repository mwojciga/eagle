/*
CU: Maciej Wójciga
CD: 20150907
LU: 20150920
HW: GasSensorModule_v2.1
Desc: Gas central software.

CHANGELOG
20150908: Initial software.

TODO
1. Sensor ID -> device ID
2. Communicate with GSM, how
3. 
 
SENSOR PINS:
PC1: TEMP

BUTTON PINS:
PD2: BUTTON1
PD3: BUTTON2
PD4: BUTTON3
PD5: BUTTON4

LED PINS:
A0: LED1
A2: LED2
PD6: LED3
PB2: LED4 -10

Notes:
Max 32 characters can be sent at one time.
S PL1234 12 23 123 40 1 00 E
Start[1], customerID[6], sensorID[2], OT[2], LT[3], GZ[3], HO[2], PR[1], statusCode[2], End[1]

SENSOR:
1. Gets info from all of the sensors every x seconds.
2. Listens for requests from centralModule and answers.
3. Every sensor should have a treshold (max and sometimes min) value. If passed, send info to centralModule.
4. 

CENTRAL MODULE:
1. Listens for messages from sensors.
2. Analyzes the messages and sends info through GSM.

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
char sensorID[3] = "01";// Put the default ID here. It can be always changed using writeToEEPROM function.
int sensorIdArraySize = sizeof(sensorID); // Must be the exact length of customerID[7] array (the array size is 7 because of the null character at the end of the string).

boolean dataError = 0;
int timeout = 10000;
char statusCode[3] = "00";

// Data, error and pins.
int dataOT = 0;

// Sensor pins.
int pinOT = A1;

// Button pins.
int pinButton1 = 2;
int pinButton2 = 3;
int pinButton3 = 4;
int pinButton4 = 5;

// LED pins.
int pinLED1 = A0;
int pinLED2 = A2;
int pinLED3 = 6;
int pinLED4 = 10;

// Others.
long ledTimeout = 5000;
long ledMillis = 0;
byte ledBlink = 0;
byte ledState = 0;


// Sensors modules list.
char* sensorsIDList[] = {"10", "11"};

void setup(void)
{
  Serial.begin(57600);
  // Pins.
  pinMode(pinOT, INPUT);
  pinMode(pinButton1, INPUT);
  pinMode(pinButton2, INPUT);
  pinMode(pinButton3, INPUT);
  pinMode(pinButton4, INPUT);
  pinMode(pinLED1, OUTPUT);
  pinMode(pinLED2, OUTPUT);
  pinMode(pinLED3, OUTPUT);
  pinMode(pinLED4, OUTPUT);
  // Radio.
  printf_begin(); // It must be here!
  radio.begin();
  radio.setRetries(15,15); // optionally, increase the delay between retries & # of retries
  radio.openWritingPipe(pipes[1]);
  radio.openReadingPipe(1,pipes[0]);
  radio.startListening();
  if (debug) radio.printDetails();
  // Write IDs.
  writeCustomerIDToEEPROM(customerID);
  writeSensorIDToEEPROM(sensorID);
  // Read IDs.
  readCustomerIDFromEEPROM();
  readSensorIDFromEEPROM();
  if (debug) printf("customerID: %s\nsensorID: %s\n", customerID, sensorID);
}

void loop(void)
{
  // Check connection with CM.
  checkConnectionWithSensors();
  // Check if any button is pressed.
  //if (digitalRead(pinButton1)) buttonPressed(1);
  //if (digitalRead(pinButton2)) buttonPressed(2);
  //if (digitalRead(pinButton3)) buttonPressed(3);
  //if (digitalRead(pinButton4)) buttonPressed(4);
  // Blink apropriate LEDS.
  if (millis() - ledMillis >= ledTimeout && ledBlink != 0) {
    ledState = !ledState;
    ledMillis = millis();
    if (ledBlink == 1) {
      digitalWrite(pinLED1, ledState);
    } else if (ledBlink == 2) {
      digitalWrite(pinLED2, ledState);
    } else if (ledBlink == 3) {
      digitalWrite(pinLED3, ledState);
    } else if (ledBlink == 4) {
      digitalWrite(pinLED4, ledState);
    } else {
      // Stop blinking.
      ledState = 0;
      ledMillis = 0;
    }
  }
  // Get data from own sensors.
  getAllSensorData();
  // Receive data and analyze it.
  if (!mode) {
    // RECEIVE.
    if (radio.available()) {
      // Dump the payloads until we've gotten everything
      char gotText[32] = {0};
      bool done = false;
      while (!done) {
        done = radio.read(&gotText, sizeof(gotText)); // Fetch the payload, and see if this was the last one.
        if (debug) printf("Received message: %s\n", gotText);
        //analyzeReceivedText(gotText); // Do something with the received text.
        //delay(20); // Delay just a little bit to let the other unit make the transition to receiver.
      }
    }
  } 
  // If prompted transmit data.
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
  // Transmit data to GSM.
  
  delay(timeout);
}

void buttonPressed(int buttonNo) {
  // TODO
  if (debug) printf("Button %i pressed.\n", buttonNo);
}

void getAllSensorData() {
  // Get data from all sensors and put it to global variables.
  getOT();
  // Just for Developement.
  dataOT = 23;
  if (debug) printf("DataOT: %i\n", dataOT);
}

void getOT() {
  // TEMPERATURE.
  dataOT = analogRead(pinOT);
  dataOT = dataOT * 0.48828125;
}

void checkNRF24L01() {
  radio.printDetails();
}

boolean checkConnectionWithSensors() {
  // TODO
  // Sent a specific message, and measure the time.
  return 1;
}

void prepareStringToSend(String methodID, String argument) {
  // Get all values that we need, concatenate and make a char array at the end.
  // S PL1234 12 07 0000005000 E
  // Start[1], customerID[6], sensorID[2], methodID[2], argument[10], End[1]
  // ex. SPL123412070000005000E
  // Concatenate.
  String toSendString = "";
  toSendString.concat("S");
  toSendString.concat(customerID);
  toSendString.concat(sensorID);
  toSendString.concat(methodID);
  toSendString.concat(argument);
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
  S PL1234 12 23 123 40 1 00 E
  Start[1], customerID[6], sensorID[2], OT[2], LT[3], GZ[3], HO[2], PR[1], statusCode[2], End[1
  ex. SPL1234122312340100E
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
  //callMethod(atoi(method), argument);
}

void changeDebugMode(int debugMode) {
  debug = debugMode;
  if (debug) printf("Debug mode: %d\n", debug);
}

void changeTimeout(int newTimeout) {
  timeout = newTimeout;
  if (debug) printf("New timeout: %d\n", timeout);
}

