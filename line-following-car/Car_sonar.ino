#include <Servo.h> //servo library
Servo myservo;
int Echo = A4;  
int Trig = A5; 
int in1 = 6;
int in2 = 7;
int in3 = 8;
int in4 = 9;
int ENA = 5;
int ENB = 11;
int ABS = 150;

void _mForward()
{
 analogWrite(ENA,ABS);
 analogWrite(ENB,ABS);
  digitalWrite(in1,HIGH);
  digitalWrite(in2,LOW);
  digitalWrite(in3,LOW);
  digitalWrite(in4,HIGH);
 Serial.println("go forward!");
}

void _mBack()
{
 analogWrite(ENA,ABS);
 analogWrite(ENB,ABS);
  digitalWrite(in1,LOW);
  digitalWrite(in2,HIGH);
  digitalWrite(in3,HIGH);
  digitalWrite(in4,LOW);
 Serial.println("go back!");
}

void _mleft()
{
 analogWrite(ENA,ABS);
 analogWrite(ENB,ABS);
  digitalWrite(in1,HIGH);
  digitalWrite(in2,LOW);
  digitalWrite(in3,HIGH);
  digitalWrite(in4,LOW); 
 Serial.println("go left!");
}

void _mright()
{
 analogWrite(ENA,ABS);
 analogWrite(ENB,ABS);
  digitalWrite(in1,LOW);
  digitalWrite(in2,HIGH);
  digitalWrite(in3,LOW);
  digitalWrite(in4,HIGH);
 Serial.println("go right!");
} 
void _mStop()
{
  digitalWrite(ENA,LOW);
  digitalWrite(ENB,LOW);
  Serial.println("Stop!");
} 

//sonar distance measurement from Elegoo's code
int Distance_test()   
{
  digitalWrite(Trig, LOW);   
  delayMicroseconds(2);
  digitalWrite(Trig, HIGH);  
  delayMicroseconds(20);
  digitalWrite(Trig, LOW);   
  float Fdistance = pulseIn(Echo, HIGH);  
  Fdistance= Fdistance/58;       
  return (int)Fdistance;
}  

void setup() 
{ 
  myservo.attach(3);// attach servo on pin 3 to servo object
  Serial.begin(9600);     
  pinMode(Echo, INPUT);    
  pinMode(Trig, OUTPUT);  
  pinMode(in1,OUTPUT);
  pinMode(in2,OUTPUT);
  pinMode(in3,OUTPUT);
  pinMode(in4,OUTPUT);
  pinMode(ENA,OUTPUT);
  pinMode(ENB,OUTPUT);
  _mStop();
} 

void loop() 
{ 
    //measure distance at 5 points, keeping track of closest distance
    myservo.write(0);
    delay(400);
    int distance0 = Distance_test();
    int currentClosest = distance0;
    int currentClosestPosition = -2;

    myservo.write(45);
    delay(150);
    int distance45 = Distance_test();
    if (distance45 < currentClosest) {
      currentClosest = distance45;
      currentClosestPosition = -1;
    }

    myservo.write(90);
    delay(150);
    int distance90 = Distance_test();
    if (distance90 < currentClosest) {
      currentClosest = distance90;
      currentClosestPosition = 0;
    }

    myservo.write(135);
    delay(150);
    int distance135 = Distance_test();
    if (distance135 < currentClosest) {
      currentClosest = distance135;
      currentClosestPosition = 1;
    }

    myservo.write(180);
    delay(150);
    int distance180 = Distance_test();
    if (distance180 < currentClosest) {
      currentClosest = distance180;
      currentClosestPosition = 2;
    }

    //turn right if closest position is to the right
    if(currentClosestPosition < 0){
      _mright();
      delay(currentClosestPosition * -115);
    }
    
    //turn left if closest position is to the left
    else if(currentClosestPosition > 0){
      _mleft();
      delay(currentClosestPosition * 115);
    }
    
    _mStop();                
}

