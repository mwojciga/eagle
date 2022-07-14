#include <LiquidCrystal.h>

int teraz = 0;
int drzwi;
int przycisk;
int i, j, k, l, m;
int rozbrojono = 0;


LiquidCrystal lcd(13, 12, 11, 10, 9, 8);

void setup() {
  lcd.begin(16, 2);
  pinMode(2, INPUT);
  pinMode(7, INPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  digitalWrite(5, LOW);
  digitalWrite(6, LOW);
 }

void loop() {
  start:
  digitalWrite(4, LOW);
  digitalWrite(5, LOW);
  digitalWrite(6, LOW);
  int i, j, k, l, m = 0;
  lcd.clear();
  if(teraz == 0) {
    przycisk = digitalRead(2);
    drzwi = digitalRead(7);
    if(drzwi == HIGH) { //otwarte 
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("Drzwi otwarte.");
      lcd.setCursor(0, 1);
      lcd.print("Alarm rozbrojony");
      blinkGreen(500);
      while(przycisk == LOW) {
        przycisk = digitalRead(2);
        digitalWrite(6, HIGH); // zaświeć zieloną diodę ciągle
        for(i=0; i<=5; i++) {
        lcd.clear();
        lcd.setCursor(0, 0);
        lcd.print("Uzbrajam...");
        lcd.setCursor(0, 1);
        lcd.print(i);
        delay(1000);
          if(i>=5) {
            for(j=30; j>=0; j--) {
              lcd.clear();
              lcd.setCursor(0, 0);
              lcd.print("UZBROJONO!");
              lcd.setCursor(0, 1);
              lcd.print("Masz ");
              lcd.setCursor(5, 1);
              lcd.print(j);
              lcd.setCursor(8, 1);
              lcd.print("sek.");
              delay(1000);
              if(j==0) {
                teraz = 1;
                goto uzbrojono;
              }
            }
          }
        }
      }
    }
    else if(drzwi == LOW && przycisk == HIGH){ // zamknięte i OFF
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("Drzwi zamkniete.");
      lcd.setCursor(0, 1);
      lcd.print("Alarm rozbrojony");
      blinkGreen(500);
    }
    else if(drzwi == LOW && przycisk == LOW) { // zamknięte i ON
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("Otworz drzwi");
      lcd.setCursor(0, 1);
      lcd.print("zeby uzbroic!");
      delay(100);
    }
  }
  uzbrojono:
  if(teraz == 1) {
    przycisk = digitalRead(2);
    drzwi = digitalRead(7);
    if(drzwi == LOW) { // zamknięte, czekaj
      digitalWrite(6, LOW);
      lcd.clear();
      digitalWrite(5, HIGH); // pomrugaj czerwoną diodą
      delay(1000);              
      digitalWrite(5, LOW);    
      delay(3000);
    }
    otwarte_uzbrojony:
    if(drzwi == HIGH) { //ktoś otworzył
      for(k=15; k>=0; k--) {
        przycisk = digitalRead(2);
        lcd.clear();
        lcd.setCursor(0, 0);
        lcd.print("Rozbroj alarm!");
        lcd.setCursor(0, 1);
        lcd.print(k);
        delay(1000);
        digitalWrite(5, HIGH); // zaświeć czerwoną diodę ciągle
        if(k==0) { //odpal dzwonek na 30 sek
          for(m=0; m<=30; m++) {
            przycisk = digitalRead(2);
            digitalWrite(5, LOW);
            digitalWrite(4, HIGH);
            lcd.clear();
            lcd.setCursor(0, 0);
            lcd.print("ALARM!");
            lcd.setCursor(0, 1);
            lcd.print("ZLODZIEJ!");
            delay(1000);
            if(m==30) {
              teraz = 0;
              goto start;              
            }
            if(przycisk == LOW) {
              goto przycisk_low;
            }
          }
        }
        przycisk_low:
        if(przycisk == LOW) { // no chyba ze ktoś wciśnie przycisk to rozbrajaj
        digitalWrite(4, LOW); // gdyby dzwonek był wczesniej włączony to wyłącz
          for(l=0; l<=5; l++) {
            przycisk = digitalRead(2);
            lcd.clear();
            lcd.setCursor(0, 0);
            lcd.print("Rozbrajam...");
            lcd.setCursor(0, 1);
            lcd.print(l); 
            if(przycisk == HIGH && l==4) {
              lcd.clear();
              lcd.setCursor(0, 0);
              lcd.print("ROZBROJONO!");
              lcd.setCursor(0, 1);
              lcd.print(":)");
              delay(5000);
              teraz = 0;
              goto start;              
            }
            if(przycisk == HIGH && l!=4) {
              goto otwarte_uzbrojony;
            }
            delay(1000);
          }
        }
      }   
    }
  }
}

// Inne funckje:

void blinkGreen(int i) {
  digitalWrite(6, HIGH);
  delay(i);
  digitalWrite(6, LOW);
  delay(i);
}
