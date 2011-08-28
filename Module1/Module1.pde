#include <Servo.h>

// Declarations of variables
Servo myservo; 
int temperaturePin = 0; 
int pos = 0;       


void setup()
{
  Serial.begin(9600);  //Start the serial connection with the copmuter
                       //to view the result open the serial monitor 
                       //last button beneath the file bar (looks like a box with an antenae)
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object

  myservo.write(pos);              // tell servo to go to position in variable 'pos'
}
 
void loop()                     // run over and over again
{
  
  
 float temperature = getVoltage(temperaturePin);  //getting the voltage reading from the temperature sensor
 temperature = (temperature - .5) * 100;          //converting from 10 mv per degree wit 500 mV offset
                                                  //to degrees ((volatge - 500mV) times 100)
 Serial.println(temperature);                     //printing the result
 
 // opens and closes the door
 if ((temperature > 24) && (pos == 0)) {                          //checks if the result is more than 24, AND the servo is at pos 0
    // move the servo pos to 9
    while (pos < 90)  // goes from 0 degrees to 180 degrees
    {      
      pos += 1;     
      myservo.write(pos);              // tell servo to go to position in variable 'pos'
      delay(15);                       // waits 15ms for the servo to reach the position
    }
 } else if ((temperature < 24) && (pos == 90)) {
    while (pos >= 1)  // goes from 0 degrees to 180 degrees
    {      
      pos -= 1;       // in steps of 1 degree
      myservo.write(pos);              // tell servo to go to position in variable 'pos'
      delay(15);                       // waits 15ms for the servo to reach the position
    }
 }
 delay(1000);                                     //waiting a second
}

/*
 * getVoltage() - returns the voltage on the analog input defined by
 * pin
 */
float getVoltage(int pin){
 return (analogRead(pin) * .004882814); //converting from a 0 to 1024 digital range
                                        // to 0 to 5 volts (each 1 reading equals ~ 5 millivolts
}
