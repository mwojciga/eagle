/*
Klaudia Trembecka & Maciej Wojciga
Last update: 20161227
A software for uC, used to aquire commands from USB (from java app), and use them to start or stop motors with appropriate speed and direction.
Works with SID116 motor controller from Wobit, http://www.wobit.com.pl/produkt/10749/sterowniki-silnikow-dc/sid116/
*/

/* Notes.
1. After connecting the power to the uC, none of the motors should be working;
2. After sending a message to the uC, all motors should work with the same speed for a specific amount of time.
3. At the end, return to the state from point 1.

/* 
CHANGELOG
1.1 Changes appropraite for the current project.
1.0 Initial software, taken from the dbfs, v.1.0.1.
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
byte e = 3;
long tmillis = 0;

/* Variables connected with relays */
long until = 0;
byte pstarted = 0;
byte r0 = 0;
byte r1 = 0;
byte r2 = 0;
byte r3 = 0;
byte r4 = 0;

/* Pins. */
int hardStopPin = 12;
int dirPin = 11;
int r0Pin = 10;
int r1Pin = 9;
int r2Pin = 8;
int r3Pin = 7;
int r4Pin = 6;

void setup() {
  Serial.begin(9600); // it must be the same as in our java app.
  /* Specifing pins connected with our motor controller.*/
  pinMode(hardStopPin, OUTPUT);
  pinMode(dirPin, OUTPUT);
  pinMode(r0Pin, OUTPUT);
  pinMode(r1Pin, OUTPUT);
  pinMode(r2Pin, OUTPUT);
  pinMode(r3Pin, OUTPUT);
  pinMode(r4Pin, OUTPUT);

  /* By default .. */
  digitalWrite(hardStopPin, LOW); // switch hard stop off.
  digitalWrite(dirPin, LOW); // reset dir pin, 0 is OK.
  digitalWrite(r0Pin, HIGH); // set R0 to 1, because R0 should be set to 0V on the motor controller.
  digitalWrite(r1Pin, LOW); // set R1 to 0.
  digitalWrite(r2Pin, LOW); // set R2 to 0.
  digitalWrite(r3Pin, LOW); // set R3 to 0.
  digitalWrite(r4Pin, LOW); // set R4 to 0.

  delay(2);
}

void loop() {
  /* Open right relay, for a specific period of time */
  if (millis() < until && pstarted == 0 && e != 1) {
    // Start.
    digitalWrite(hardStopPin, LOW);
    digitalWrite(dirPin, d);
    digitalWrite(r0Pin, LOW);
    digitalWrite(r1Pin, r1);
    digitalWrite(r2Pin, r2);
    pstarted = 1;
    printResponse();
  }
  if (millis() > until && pstarted == 1 && e != 1) {
    // Stop.
    digitalWrite(hardStopPin, LOW);
    digitalWrite(r0Pin, HIGH);
    digitalWrite(r1Pin, LOW);
    digitalWrite(r2Pin, LOW);
    pstarted = 0;
    printResponse();
  }
  getMessage();
  delayMicroseconds(3);
}

void printResponse() {
  /*
  Sd0v0u000t000p0e0E
  S_DIR_VELOCITY_UNTIL_TIME_STARTED_ERROR_E
  */
  message += "Sd";
  message += d;
  message += "v";
  message += v;
  message += "u";
  message += until;
  message += "t";
  message += millis();
  message += "s";
  message += pstarted;
  message += "p";
  message += r0;
  message += r1;
  message += r2;
  message += r3;
  message += r4;
  message += "e";
  message += e;
  message += "E";
  Serial.println(message);
  message = "";
}

void boostVelocity(){
  digitalWrite(r3Pin, HIGH);
  delayMicroseconds(20);
  digitalWrite(r3Pin, LOW);
  printResponse();
}

void slowVelocity(){
  digitalWrite(r4Pin, HIGH);
  delayMicroseconds(20);
  digitalWrite(r4Pin, LOW);
  printResponse();
}

void getMessage() {
  /*
  The message looks like this:
  Sd0v0t000e0E
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
      /* Now we have d, v, e, t. */
      if (e == 0 && pstarted == 0 && v != 3 && v != 4) {
        // Count time until which the motors should be turned on.
        tmillis = t*1000;
        until = millis() + tmillis;
        switch (v) {
          case 1:
            r0 = 0;
            r1 = 1;
            r2 = 0;
            break;
          case 2:
            r0 = 0;
            r1 = 0;
            r2 = 1;
            break;
        }
      } else if (e == 0 && pstarted != 0) {
        if(v == 0){
          digitalWrite(r0Pin, HIGH);
          digitalWrite(r1Pin, LOW);
          digitalWrite(r2Pin, LOW);
          pstarted = 0;
          until = 0;
          printResponse();
        } else if (v == 1 || v == 2) {
          Serial.println("The process is already running.E");
        } else if (v == 3) {
          boostVelocity();
        } else if (v == 4) {
          slowVelocity();
        }
      } 
      /* If e equals 2, then just send back the remaining time. */
      if(e == 2) {
        printResponse();
        e = 0;
      }
      if(e == 1) {
        // Stop.
        digitalWrite(hardStopPin, HIGH);
        digitalWrite(r0Pin, LOW);
        digitalWrite(r1Pin, LOW);
        digitalWrite(r2Pin, LOW);
        digitalWrite(r3Pin, LOW);
        digitalWrite(r4Pin, LOW);
        until = 0;
        pstarted = 0;
        printResponse();
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
