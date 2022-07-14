/*
Author: Maciej Wojciga
CD: 20140301
MD: 20140308
*/

#include <LiquidCrystal.h>
#include <FreqCounter.h>

// Meter mode
String meterMode[] = {"L", "C", "F"};
String currentMode = meterMode[0];
int modeIterator = 0;

// LCD
const int pinRS = 8;
const int pinEn = 6;
const int pinD4 = 3;
const int pinD5 = 2;
const int pinD6 = 1;
const int pinD7 = 0;
LiquidCrystal lcd(pinRS, pinEn, pinD4, pinD5, pinD6, pinD7);
//LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

// Buttons
const int pinBtnCal = 18; //A4
const int pinBtn1 = 19; //A5
const int pinBtn2 = 17; //A3
const int btnCal = 0; //A4
const int btn1 = 1; //A5
const int btn2 = 2; //A3
const int BTN_PINS[] = {pinBtnCal, pinBtn1, pinBtn2};
boolean btnPressed[] = {false, false, false};

// Initial values
float F0 = 442500;
const float Cth = 681 * 1e-12; //theoretical 681pF
const float Lth = 220 * 1e-6; //theoretical 220uH
float l0 = Lth;
float c0 = Cth;
unsigned long frq;

boolean calibrated = false;

void setup() {
  lcd.begin(16, 2);
  for (int i = 0; i < 3; i++) {
    pinMode(BTN_PINS[i], INPUT);
    digitalWrite(BTN_PINS[i], HIGH);
  }
  lcd.clear();
}

void loop() {
  // Count frequency.
  countFrequency();
  if(calibrated != true) {
    // Calibrate.
    lcd.setCursor(0, 0);
    lcd.print("Calibrate:");
    displayFreq(frq, 0);
    if (buttonPressed(btn1)) {
      calibrate();  
    }
  } else {
    lcd.clear();
    // Display frequency and measured value.
    displayMeasurement(frq);  
    printFreqAndMode();
  }
  if (buttonPressed(btn1)) {
    changeMeterMode();
  } else if (buttonPressed(btnCal)) {
    calibrate();
  }
  for (int i = 0; i < 3; i++) {
    if (buttonReleased(i)) {
      //the button is released, no action is necessary.
    }
  }
}

void printFreqAndMode() {
  lcd.setCursor(12, 0);
  lcd.print("|");
  long printL = (long)F0;
  if (printL >= 1000) {
    lcd.print(printL/1000);
  } else {   
    lcd.print(printL);
  }
  lcd.setCursor(12, 1);
  lcd.print("| ");
  lcd.print(currentMode);
}

void countFrequency() {
  FreqCounter::f_comp = 106;
  FreqCounter::start(1000);
  while (FreqCounter::f_ready == 0){
    frq = FreqCounter::f_freq;
  }
}

void calibrate() {
  lcd.setCursor(0, 0);
  lcd.print("Calibrating...");
  delay(1000);
  // Count l0, c0, F0
  l0 = calcV(frq, Lth) + Lth;
  c0 = calcV(frq, Cth) + Cth;
  F0 = frq;
  calibrated = true;
  lcd.clear();
}

void changeMeterMode() {
  // Change meter mode.
  if (modeIterator == 3) { 
    modeIterator = 0;
  }
  currentMode = meterMode[modeIterator];
  lcd.setCursor(0, 0);
  lcd.print("Current mode: " + currentMode + " ");
  modeIterator++;  
}

// Display frequency.
void displayFreq(long fin, boolean top) {
  if (top) {      
    lcd.setCursor(0, 0);
  } else {
    lcd.setCursor(0, 1);
  }
  float f = 0;
  if (fin < 1000) {
    f = 1.0 * ((float) fin);
    lcd.print(f, 0);
    lcd.print(" Hz  ");
  } else if (fin >= 1000) {
    f = ((float) fin) / 1000.0;
    lcd.print(f, 3);
    lcd.print(" KHz ");
  }
}

// Button pressed.
boolean buttonPressed(int btnId) {
  if (digitalRead(BTN_PINS[btnId]) == LOW && !btnPressed[btnId]) {
    delayMilliseconds(20);
    if (digitalRead(BTN_PINS[btnId]) == LOW) {
      btnPressed[btnId] = true;
      return true;
    }
  }
  return false;
}

// Button released.
boolean buttonReleased(int btnId) {
  if (digitalRead(BTN_PINS[btnId]) == HIGH && btnPressed[btnId]) {
    delayMilliseconds(20);
    if (digitalRead(BTN_PINS[btnId]) == HIGH) {
      btnPressed[btnId] = false;
      return true;
    }
  }
  return false;
}

// To be more acurate: change mills to micros
void delayMilliseconds(int ms) {
  for (int i = 0; i < ms; i++) {
    delayMicroseconds(1000);
  }
}

// Calculate L or C.
float calcV(float f, float VRef) {
  float v = 0;
  v = ((F0 * F0) / (f * f) - 1.0) * VRef;
  return v;
}

// Display L or C.
void displayMeasurement(long fin) {
  displayFreq(frq, 1);
  float f = (float) fin;
  float v = 0;
  lcd.setCursor(0, 1);
  if (currentMode == "C") {
    v = calcV(f, c0);
    if (v < 1e-9) {
      v = v * 1e12;
      lcd.print(v);
      lcd.print(" pF ");
    } else if (v >= 1e-9 && v < 1e-6) {
      v = v * 1e9;
      lcd.print(v);
      lcd.print(" nF ");
    } else {
      lcd.print("---");
    }
  } else if (currentMode == "L") { 
    v = calcV(f, l0);
    if (v < 1e-6) {
      v = v * 1e9;
      lcd.print(v);
      lcd.print(" nH ");
    } else if (v >= 1e-6 && v < 1e-3) {
      v = v * 1e6;
      lcd.print(v);
      lcd.print(" uH ");
    } else if (v >= 1e-3 && v < 1) {
      v = v * 1e3;
      lcd.print(v);
      lcd.print(" mH ");
    } else if (v >= 1 && v < 100) {
      lcd.print(v);
      lcd.print(" H  ");
    } else {
      lcd.print("---");
    }
  } else {
    // It always displays frequency, so do nothing.
  }
}
