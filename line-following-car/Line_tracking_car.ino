//www.elegoo.com
//2016.09.23

int in1=6;
int in2=7;
int in3=8;
int in4=9;
int ENA=5;
int ENB=11;
 int ABS=115;
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
  Serial.begin(9600);
}

void loop() {
  int num1,num2,num3,count;
  count=0;
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
  delay(2);
  _mStop();
  delay(1);
}

