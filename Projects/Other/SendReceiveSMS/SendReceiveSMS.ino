#include "SIM900.h"
#include <SoftwareSerial.h>
#include "sms.h"
SMSGSM sms;

// Sending SMS: sms.SendSMS("+48792616768", "Test SMS"))

int numdata;
boolean started = false;
boolean deleteSMS = true;
char smsbuffer[160];
char n[20];

char sms_position;
char phone_number[20];
char sms_text[300];
int i;

void setup() {
  Serial.begin(19200);
  Serial.print("Initializing GSM modem... ");
  if (gsm.begin(19200)) {
    Serial.println("READY.");
    started = true;
    if (deleteSMS) {
      Serial.println("Removing old SMS messages from memory...");
      for (byte i = 0 ; i <= 25 ; i++) {
        Serial.print("Deleting SMS on position ");
        Serial.println(i);
        sms.DeleteSMS(i);
      }
      Serial.println("Done.");
    }
  } else {
    Serial.println("IDLE.");
  }
};

void loop()
{
  if (started) {
    sms_position = sms.IsSMSPresent(SMS_ALL);
    if (sms_position) {
      sms.GetSMS(sms_position, phone_number, sms_text, 300);
      Serial.print(millis());
      Serial.print("|");
      Serial.print(sms_position, DEC);
      Serial.print("|");
      Serial.print(phone_number);
      Serial.print("|");
      Serial.print(sms_text);
      Serial.println(";");
    }
    sms.DeleteSMS(sms_position);
    delay(2000);
  }
};

