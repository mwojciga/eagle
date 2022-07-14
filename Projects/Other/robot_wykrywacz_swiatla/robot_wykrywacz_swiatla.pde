#include <Servo.h>

Servo maciekServo;

int servoPin = 10;
int buttonPin = 2;
int val = HIGH;
int fotoPin = 0;
int bestLight = 0;
int light = 0;
int nextLight = 0;
int i = 0;

void setup()
{
  maciekServo.attach(servoPin);
  pinMode(buttonPin, INPUT);
  pinMode(fotoPin, INPUT);
  Serial.begin(57600);  
}

void loop()
{
  val = digitalRead(buttonPin);
  if ( val == LOW )
  {
    bestLight = 0;
    light = 0;
    for (i = 0; i <= 180; i = i+10 )
    {
      maciekServo.write(i);
      nextLight = analogRead(fotoPin);
      Serial.println(nextLight);
      if (nextLight > light)
      {
        bestLight = i;
        light = nextLight;
      }
      delay(500);
    }
  }
  else 
  {
    maciekServo.write(bestLight);
    Serial.print("Wybralem wartosc: ");
    Serial.println(light);
    Serial.print("Kat: ");
    Serial.println(bestLight);    
    delay(1000);
  }
}
