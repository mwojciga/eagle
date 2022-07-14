/*
Klaudia Trembecka & Maciej Wojciga
Last update: 20141109
A software for uC, used to aquire commands from USB (from java app),
and use them to open or close the pipes of the artificial patient.
*/

/* 
CHANGELOG
1.0.1 Changes appropraite to the current project. Only right relay implemented.
1.0.0 Initial software, taken from the biorobot, v.4.0.4.
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
char serialReadString[36]; //28
char rarray[4]; 
char larray[4];

/* Used only for creating x, y, z arrays */
byte b = 0;
byte c = 0;
byte d = 0;
byte f = 0;

/* Initializing variables */
long r = 0;
long l = 0;
byte e = 0;
long rmillis = 0;
long lmillis = 0;

/* Variables connected with relays */
long runtil = 0;
byte rstarted = 0;
long luntil = 0;
byte lstarted = 0;
long timeleft = 0;

/* Pins. */
int rightRelayPin = 3;
int leftRelayPin = 4;

void setup() {
  Serial.begin(9600); // it must be the same as in our java app.
  /* Specifing pins connected with our motor controller.*/
  pinMode(rightRelayPin, OUTPUT); // right relay.
  pinMode(leftRelayPin, OUTPUT); // left relay.
  /* By default all pins should be HIGH - if the pin is set to HIGH, relay is blocked */
  digitalWrite(rightRelayPin, HIGH);
  digitalWrite(leftRelayPin, HIGH);
}

void loop() {
  /* Open relay, for a specific period of time */
  if (millis() <= runtil && e != 1) {
    // Start.
    digitalWrite(rightRelayPin, LOW); // Open right relay.
    rstarted = 1;
  }
  if (millis() > runtil && rstarted == 1 && e != 1) {
    // Stop.
    digitalWrite(rightRelayPin, HIGH); // Close right relay.
    rstarted = 0;
  }
  
  /*
  The message looks like this:
  Sr000l000e0E
  S_RIGHTPUMP_LEFTPUMP_ERROR_E
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
        b = i+2;
        c = i+6;
        rarray[i]=serialReadString[b];
        larray[i]=serialReadString[c];
      }
      e = serialReadString[10]-48; // int = char-48;
      r = atol(rarray)*60; // seconds to keep the right relay opened.
      l = atol(larray)*60; // seconds to keep the left relay opened.
      /* Now we have r, l, e. */
      if(e == 0) {
        rmillis = r*1000;
        lmillis = l*1000;
      }
      /* If e equals 2, then just send back the remaining time. */
      if(e == 2) {
        timeleft = (runtil - millis())/1000;
        printTime(e);
        e = 0;
      }
      if(e == 1) {
        printTime(e);
        digitalWrite(rightRelayPin, HIGH);
        digitalWrite(leftRelayPin, HIGH);
      }
      // Count time until which the relay should be opened.
      runtil = millis() + rmillis;
      luntil = millis() + lmillis;
      started = 0;
    } else {
      if (started == 1){ // the middle of the command.
        serialReadString[place] = a;
        place++; 
      }
    }
  }
 delayMicroseconds(3);
}

//Sr000l000e0E
void printTime(byte e) {
  timeleft = (runtil - millis())/1000;
  message += "St";
  message += timeleft;
  message += "e";
  message += e;
  message += "E";
  Serial.println(message);
  message = "";
}
