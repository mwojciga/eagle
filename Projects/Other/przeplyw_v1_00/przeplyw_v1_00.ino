/*
Klaudia Trembecka & Maciej Wojciga
CD: 20140226
MD: 20140308

Input:  Sf000s000t000e0E
Output: Sf000s000t000e0E
*/

/* 
CHANGELOG
1.0.0: 
*/

int place = 0;
int i = 0;
int j = 0;
int started = 0;
int timeout = 1000; 
int xtimeout = 1000;
int ytimeout = 1000;
int ztimeout = 1000;

char a;
String message = "";
byte work = 0;

/* Motor pins */
const int motorFast = 9;
const int motorSlow = 10;

/*
This arrays are 1 char larger, because they should
have also place for the terminating \0 for atoi method.
*/
char serialReadString[18]; //28
char farray[4]; 
char sarray[4];
char tarray[4];

/* Used only for creating x, y, z arrays */
byte b = 0;
byte c = 0;
byte d = 0;
byte f = 0;

/* Initializing variables */

long x = 0;
long y = 0;
long t = 0;
byte e = 0;

long tmillis = 0;
long waited = 0;
byte waiting = 0;

void setup() {
  Serial.begin(9600); // it must be the same as in our java app.
  /* Specifing pins connected with our motor controller.*/
  pinMode(motorFast, OUTPUT); // motor 1.
  pinMode(10, OUTPUT); // motor 2.
}

void loop() {
  if(j <= t*100 && work == 1 && millis() - tmillis >= 10) {
    analogWrite(motorFast, x);
    analogWrite(motorSlow, y);
    j++;
    tmillis = millis();
  }
   if(j == t*100 && work == 1 ) {
    analogWrite(motorFast, 0);
    analogWrite(motorSlow, 0);
    j = 0;
    tmillis = 0;
    printMessage();
    work = 0;
  }

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
        f = i+10;
        farray[i]=serialReadString[b];
        sarray[i]=serialReadString[c];
        tarray[i]=serialReadString[f];
      }
      e = serialReadString[14]-48; // int = char-48;
      x = atol(farray);
      y = atol(sarray);
      t = atol(tarray);
      if (e == 1) {
        // Stop the robot.
        work = 0;
        printMessage();  
      }
      started = 0;
      work = 1;
    } else {
      if (started == 1){ // the middle of the command.
        serialReadString[place] = a;
        place++; 
      }
    }
  }
 delayMicroseconds(3);
}

void printMessage() {
    message += "Sf";
    message += x;
    message += "s";
    message += y;
    message += "t";
    message += t;
    message += "e";
    message += e;
    message += "E";
    Serial.println(message);
    message = "";
}
