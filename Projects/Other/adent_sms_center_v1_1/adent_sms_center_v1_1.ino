#include <SoftwareSerial.h>

SoftwareSerial GPRS(7, 8);
unsigned char buffer[64];
int count=0;
char a;
int i = 0;
int j = 0;
int place = 0;
int started = 0;

/*
This arrays are 1 char larger, because they should
have also place for the terminating \0 for atoi method.
*/
char serialReadString[33];
char yearArray[5];
char monthArray[3];
char dayArray[3];
char hourArray[3];
char minuteArray[3];
char telephoneArray1[4];
char telephoneArray2[4];
char telephoneArray3[4];

/* Used only for creating x, y, z arrays */
byte b = 0;
byte c = 0;
byte d = 0;
byte e = 0;
byte f = 0;
byte g = 0;
byte h = 0;
byte k = 0;

/* Variables */
int caseMsg;
String telephone;
int telephone1;
int telephone2;
int telephone3;
int year;
int month;
int day;
int hour;
int minute;

void setup() {
  GPRS.begin(19200);
  Serial.begin(19200);
}
 
void loop() {
  if (GPRS.available()) {
    while(GPRS.available()) {
      buffer[count++]=GPRS.read();
      if(count == 64) {
        break;
      }
    }
    Serial.write(buffer,count);
    clearBufferArray();
    count = 0;
  }

  
  /* Check the incomming message */
  /* Sc1y2013m03d24h20m10t792616768E */
  while(Serial.available()) {
    a = Serial.read();
    if(a == 'S') { // beginning of the command.
      started = 1;
    }
    if(a == 'E' && started == 1){ // end of the command.
      place = 0; // reset the place in the array.
      for(i=0; i<=3; i++){
        b = i+4;
        yearArray[i]=serialReadString[b];
      }
      for(i=0; i<=1; i++){
        c = i+9;
        d = i+12;
        e = i+15;
        f = i+18;
        monthArray[i]=serialReadString[c];
        dayArray[i]=serialReadString[d];
        hourArray[i]=serialReadString[e];
        minuteArray[i]=serialReadString[f];
      }
      for(i=0; i<=2; i++){
        g = i+21;
        h = i+24;
        k = i+27;
        telephoneArray1[i]=serialReadString[g];
        telephoneArray2[i]=serialReadString[h];
        telephoneArray3[i]=serialReadString[k];
      }
      caseMsg = serialReadString[2]-48; // int = char-48;
      for(i=0; i<=2; i++){
        telephone.concat(telephoneArray1[i]);
      }
      for(i=0; i<=2; i++){
        telephone.concat(telephoneArray2[i]);
      }
      for(i=0; i<=2; i++){
        telephone.concat(telephoneArray3[i]);
      }
      year = atoi(yearArray);
      month = atoi(monthArray);
      day = atoi(dayArray);
      hour = atoi(hourArray);
      minute = atoi(minuteArray);
      if(caseMsg == 0) {
        // do nothing
      }
      if(caseMsg == 1) {
        sendTodaySMS(telephone, hour, minute);
        resetVariables();
      }
      if(caseMsg == 2) {
        sendOtherDaySMS(telephone, hour, minute, day, month, year);
        resetVariables();
      }
      started = 0;
    } else {
      if (started == 1){ // the middle of the command.
        serialReadString[place] = a;
        place++; 
      }
    }
  }
  delay(10);
}

void clearBufferArray() { 
  for (int i=0; i<count;i++) {
    buffer[i]=NULL;
  }
}

void resetVariables(){
  telephone = "";
  caseMsg = 0;
  telephone1 = 0;
  telephone2 = 0;
  telephone3 = 0;
  year = 0;
  month = 0;
  day = 0;
  hour = 0;
  minute = 0;
}

void sendTodaySMS(String telephone, int hour, int minute) {
  // Text mode.
  GPRS.print("AT+CMGF=1\r");
  delay(100);
  // Receivers number.
  String telMsg = "";
  String telMsg1 = "AT + CMGS = \"+48";
  String telMsg2 = "\"";
  telMsg.concat(telMsg1);
  telMsg.concat(telephone);
  telMsg.concat(telMsg2);
  GPRS.println(telMsg);
  delay(100);
  // SMS text.
  String textMsg = "A-DENT Uprzejmie przypominam o terminie wizyty stom. w dniu dzisiejszym o godzinie ";
  textMsg.concat(hour);
  textMsg.concat(":");
  textMsg.concat(minute);
  textMsg.concat(". Kontakt: 530 530 289. Pozdrawiam, A.Sabat-Wojciga, lek. dent. spec.");
  GPRS.println(textMsg);
  delay(100);
  GPRS.println((char)26);//the ASCII code of the ctrl+z is 26
  delay(100);
  GPRS.println();
}

void sendOtherDaySMS(String telephone, int hour, int minute, int day, int month, int year) {
  // Text mode.
  GPRS.print("AT+CMGF=1\r");
  delay(100);
  // Receivers number.
  String telMsg = "";
  String telMsg1 = "AT + CMGS = \"+48";
  String telMsg2 = "\"";
  telMsg.concat(telMsg1);
  telMsg.concat(telephone);
  telMsg.concat(telMsg2);
  GPRS.println(telMsg);
  delay(100);
  // SMS text.
  String textMsg = "A-DENT Zapraszam na wizyte stomatologiczna w dniu ";
  textMsg.concat(day);
  textMsg.concat(".");
  textMsg.concat(month);
  textMsg.concat(".");
  textMsg.concat(year);
  textMsg.concat(" o godzinie ");
  textMsg.concat(hour);
  textMsg.concat(":");
  textMsg.concat(minute);
  textMsg.concat(". Kontakt: 530 530 289. Pozdrawiam, Agnieszka Sabat-Wojciga, lek. dent. spec.");
  GPRS.println(textMsg);
  delay(100);
  GPRS.println((char)26);//the ASCII code of the ctrl+z is 26
  delay(100);
  GPRS.println();
}
