/* 
 RFID Software
 A software used to read and make use of RFID.
 
 Author: Maciej Wojciga
 CD: 20131130
 MD: 20131130
 */

/*
CHANGELOG:
 1.0.0: Start of the project.
 */

/*
Read incomming message;
 Check if it equals one of the registered cards;
 If yes, give a mirror value to the previous one on one of the outputs;
 If no, do nothing;
 Check if the card is held for longer then 10 seconds;
 If yes, check for the next 10 seconds for a registered card;
 If yes, register the first one;
 If no, do nothing;
 If no, do nothing;
 */

#define redLed 2
#define yellowLed 3
#define greenLed 4
#define output 5

int i;

byte tmp;
String token = "";
boolean correctToken = false;
byte state = false;
byte redState = false;
String trueToken = "25056484849536970704850503"; // Token ID: 0001437680
String lastToken = ""; // Last toekn read by RFID


void setup() {
  Serial.begin(9600);
  pinMode(redLed, OUTPUT); // Red LED
  pinMode(yellowLed, OUTPUT); // Yellow LED
  pinMode(greenLed, OUTPUT); // Green LED
  pinMode(output, OUTPUT); // Output.
  digitalWrite(redLed, LOW);
  digitalWrite(yellowLed, state);
  digitalWrite(greenLed, HIGH);
}

void loop() {
  correctToken = readCard();
  if (correctToken) {
    state = (state == HIGH) ? LOW : HIGH;
    digitalWrite(yellowLed, state);
    digitalWrite(output, state);
    digitalWrite(redLed, HIGH);
    digitalWrite(greenLed, LOW);
    delay(3000);
  }
  digitalWrite(redLed, LOW);
  digitalWrite(greenLed, HIGH);
  delay(100);
}

boolean readCard() {
  if (Serial.available() > 0){
    tmp = Serial.read();
    token.concat(tmp);
    if (token.length() == 26 && token != lastToken && token.charAt(0) == '2' && token.charAt(25) == '3' ) {
      if (token == trueToken) {
        token = "";
        return true;
      } else {
        Serial.println(token);
        digitalWrite(greenLed, LOW);
        for (i=0; i<10; i++) {
          digitalWrite(redLed, redState);
          redState = !redState;
          delay(200);
        }
        token = "";
      }
    } 
    else if (token.length() >= 26) {
      token = ""; 
    }
    return false;
  }
}


