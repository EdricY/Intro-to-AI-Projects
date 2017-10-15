#include <Servo.h>

//www.elegoo.com
//2016.09.23

//sonar
Servo myservo;
int Echo = A4;  
int Trig = A5; 
bool move = true;

//movement
int in1=6;
int in2=7;
int in3=8;
int in4=9;
int ENA=5;
int ENB=11;
 int ABS=115;

int distance0 = 100;
int distance45 = 100;
int distance90 = 100;
  
 void _mForward()
{
  analogWrite(ENA,ABS);
  analogWrite(ENB,ABS);
  digitalWrite(in1,HIGH);//digital output
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

void setup() 
{
  myservo.attach(3);// attach servo on pin 3 to servo object
  Serial.begin(9600);     
  pinMode(Echo, INPUT);    
  pinMode(Trig, OUTPUT);
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

void loop() {
  myservo.write(0);
  followLine(100); //delay
  distance0 = Distance_test();
  move = !(distance90 < 50 || distance45 < 50 || distance0 < 50);
  
  myservo.write(45);
  followLine(50);
  distance45 = Distance_test();
  move = !(distance90 < 50 || distance45 < 50 || distance0 < 50);
  
  myservo.write(90);
  followLine(50);
  distance90 = Distance_test();
  move = !(distance90 < 50 || distance45 < 50 || distance0 < 50);
}

void followLine(int time) {
  int timeTaken = 0;
  if (move){
    while (timeTaken < time) {
      int num1,num2,num3;
      num1=digitalRead(10);    
      num2=digitalRead(4);
      num3=digitalRead(2);
      if(num2!=0) 
      {
        _mForward();
      }    
      else if(num1!=0)
      {
         _mleft();
      }
      else
      {
        _mright();
      } 
      delay(4);
      timeTaken += 4;
      _mStop();
      delay(1);
      timeTaken += 1;
    }
  }
  else {
    delay(time*3);
  }
}

