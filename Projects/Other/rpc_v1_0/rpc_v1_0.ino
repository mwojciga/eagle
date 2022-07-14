/*
Klaudia Trembecka & Maciej Wojciga
Last update: 20141109
A software for uC, used to aquire commands from USB (from java app),
and use them to open or close the pipes of the artificial patient.
*/

/* Notes.
1. After connecting the power to the uC, one relay (left - without the PCV tube) should be opened, and the other (right - with the PCV tube) should be closed;
2. After sending a message to the uC, the right relay should open for a specific amount of time. In addition, close the other relay for that time.
3. At the end, return to the state from point 1.

/* 
CHANGELOG
1.1 Changes appropraite to the current project. Only right relay implemented.
1.0 Initial software, taken from the biorobot, v.4.0.4.
*/

int place = 0;
int i = 0;
int j = 0;
int started = 0;
char a;

String message = "";

/*
This arrays are 1 char larger, because they should
have also place for the terminating \0 for atoi method.
*/
char serialReadString[23]; //28
char tarray[4]; 

/* Used only for creating x, y, z arrays */
byte b = 0;

/* Initializing variables */
byte d = 0;
long v = 0;
long t = 0;
byte e = 0;
long tmillis = 0;

/* Variables connected with relays */
long until = 0;
byte pstarted = 2;
byte r1 = 0;
byte r2 = 0;
byte r3 = 0;
byte r4 = 0;

/* Pins. */
int enablePin = 12;
int dirPin = 11;
int hardStopPin = 10;
int unusedPin = 9;
int r1Pin = 8;
int r2Pin = 7;
int r3Pin = 6;
int r4Pin = 5;

void setup() {
  Serial.begin(9600); // it must be the same as in our java app.
  /* Specifing pins connected with our motor controller.*/
  pinMode(enablePin, OUTPUT);
  pinMode(dirPin, OUTPUT);
  pinMode(hardStopPin, OUTPUT);
  pinMode(unusedPin, OUTPUT);
  pinMode(r1Pin, OUTPUT);
  pinMode(r2Pin, OUTPUT);
  pinMode(r3Pin, OUTPUT);
  pinMode(r4Pin, OUTPUT);
  /* By default .. */
  digitalWrite(enablePin, LOW); // block the replay with PCV tube.
  digitalWrite(dirPin, LOW); // block the replay with PCV tube.
  digitalWrite(hardStopPin, LOW); // oped relay without the tube to let the blood flow.
  digitalWrite(r1Pin, LOW); // block the replay with PCV tube.
  digitalWrite(r2Pin, LOW); // block the replay with PCV tube.
  digitalWrite(r3Pin, LOW); // block the replay with PCV tube.
  digitalWrite(r4Pin, LOW); // block the replay with PCV tube.
}

void loop() {
  /* Open right relay, for a specific period of time */
  if (millis() <= until && pstarted == 0 && e != 1) {
    // Start.
    digitalWrite(enablePin, HIGH); // Open right relay.
    digitalWrite(dirPin, d); // Open right relay.
    digitalWrite(r1Pin, r1); // Open right relay.
    digitalWrite(r2Pin, r2); // Open right relay.
    digitalWrite(r3Pin, r3); // Open right relay.
    digitalWrite(r4Pin, r4); // Open right relay.
    digitalWrite(hardStopPin, LOW); // Close left relay.
    pstarted = 1;
    printTime(e);
  }
  if (millis() > until && pstarted == 1 && e != 1) {
    // Stop.
    digitalWrite(enablePin, LOW); // Open right relay.
    digitalWrite(r1Pin, LOW); // Open right relay.
    digitalWrite(r2Pin, LOW); // Open right relay.
    digitalWrite(r3Pin, LOW); // Open right relay.
    digitalWrite(r4Pin, LOW); // Open right relay.
    digitalWrite(hardStopPin, LOW); // Close left relay.
    pstarted = 0;
    printTime(e);
  }
  getMessage();
  delayMicroseconds(3);
}

void printTime(byte e) {
  /*
  Sr000l000t000e0E
  S_RIGHTUNTIL_LEFTUNTIL_TIME_ERROR_E
  */
  message += "Sd";
  message += d;
  message += "v";
  message += v;
  message += "t";
  message += millis();
  message += "e";
  message += e;
  message += "E";
  Serial.println(message);
  message = "";
}

void getMessage() {
  /*
  The message looks like this:
  Sd0v0t000e0E
  Sr000l000e0E
  S_DIR_VELOCITY_TIME_ERROR_E
  */
  /* Check the incomming message */
  while(Serial.available()) {
    a = Serial.read();
    if(a == 'S') { // beginning of the command.
      started = 1;
    }
    if(a == 'E' && started == 1){ // end of the command.
      place = 0; // reset the place in the array.
      for(i=0; i<=4; i++){
        b = i+6;
        tarray[i]=serialReadString[b];
      }
      d = serialReadString[2]-48; // int = char-48;
      v = serialReadString[4]-48; // int = char-48;
      e = serialReadString[10]-48; // int = char-48;
      t = atol(tarray)*60; // seconds to keep the right relay opened.
      /* Now we have d, v, e. */
      switch (v) {
        case 1:
          r1 = 1;
          r2 = 0;
          r3 = 0;
          r4 = 0;
          break;
        case 2:
          r1 = 0;
          r2 = 1;
          r3 = 0;
          r4 = 0;
          break;
        case 3:
          r1 = 0;
          r2 = 0;
          r3 = 1;
          r4 = 0;
          break;
        case 4:
          r1 = 0;
          r2 = 0;
          r3 = 0;
          r4 = 1;
          break;
        default:
          r1 = 0;
          r2 = 0;
          r3 = 0;
          r4 = 0;
        break;
      } 

      if(e == 0) {
        tmillis = t*1000;
        pstarted = 0;
        // Count time until which the relay should be opened.
        until = millis() + tmillis;
      }
      /* If e equals 2, then just send back the remaining time. */
      if(e == 2) {
        printTime(e);
        e = 0;
      }
      if(e == 1) {
        digitalWrite(hardStopPin, HIGH); // Close left relay.
        printTime(e);
        // Stop.
        digitalWrite(enablePin, LOW); // Open right relay.
        digitalWrite(r1Pin, LOW); // Open right relay.
        digitalWrite(r2Pin, LOW); // Open right relay.
        digitalWrite(r3Pin, LOW); // Open right relay.
        digitalWrite(r4Pin, LOW); // Open right relay.
      }
      started = 0;
    } else {
      if (started == 1){ // the middle of the command.
        serialReadString[place] = a;
        place++; 
      }
    }
  }
}
