/*
CU: Maciej Wójciga
CD: 20150907
MD: 20160103
HW: GasSensorModule_v2.1
Desc: Gas central software.

CHANGELOG
20150908: Initial software.

TODO
1. Sensor ID -> device ID
2. Communicate with GSM, how
3. 
 
SENSOR PINS:

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

Notes:


CENTRAL MODULE:
1. Listens for messages from sensors.
2. Analyzes the messages and sends info through GSM.

EEPROM:
0-6: customerID
7-9: sensorID

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

*/

//#include <SoftwareSerial.h>

//SoftwareSerial GPRS(7, 8);

int button1 = 2;
int button2 = 3;
int button3 = 4;
int button4 = 5;

int led1 = A0;
int led2 = A2;
int led3 = 6;
int led4 = 10;

int button1State;
int button2State;
int button3State;
int button4State;

boolean once = 0;

void setup() {
  //GPRS.begin(19200);
  Serial.begin(19200);
  pinMode(button1, INPUT);
  pinMode(button2, INPUT);
  pinMode(button3, INPUT);
  pinMode(button4, INPUT);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
  pinMode(led4, OUTPUT);
  pinMode(13, OUTPUT);
}

void loop() {
  
  button1State = digitalRead(button1);
  button2State = digitalRead(button2);
  button3State = digitalRead(button3);
  button4State = digitalRead(button4);
  if (once == 0) {
    onLED(led1);
    onLED(led2);
    onLED(led3);
    onLED(led4);
    delay(1000);
    once = 1;
    offLED(led1);
    offLED(led2);
    offLED(led3);
    offLED(led4);
  }

  // check if the pushbutton is pressed.
  // if it is, the buttonState is LOW:
 if (button1State == LOW) {
    onLED(led1);
     sendSMS(1);
  } else {
     offLED(led1); 
  }

    if (button2State == LOW) {
      onLED(led2);
     sendSMS(2);
  } else {
     offLED(led2); 
  }

    if (button3State == LOW) {
      onLED(led3);
     sendSMS(3);
  } else {
     offLED(led3); 
  }

    if (button4State == LOW) {
      onLED(led4);
     sendSMS(4);
  } else {
     offLED(led4); 
  }

  delay(100);
  
}

void sendSMS(int button) {
  // Text mode.
  Serial.println("AT+CMGF=1\r");
  delay(100);
  // Receivers number.
  Serial.println("AT + CMGS = \"+48691464561\"");
  delay(100);
  // SMS text.
  Serial.println(button);
  delay(100);
  Serial.println((char)26);//the ASCII code of the ctrl+z is 26
  delay(100);
}

void onLED(int led) {
 digitalWrite(led, HIGH);
}

void offLED(int led) {
 digitalWrite(led, LOW);
}

