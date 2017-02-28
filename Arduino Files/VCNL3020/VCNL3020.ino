#include <Wire.h>
#define VCNL3020_ADDRESS 0x13  //I2C Address of the board
#define interruptPin 3
boolean high = false;



void setup() {
  Serial.begin(9600);  // Serial's used to debug and print data
  Wire.begin();  // initialize I2C stuff
  initVCNL3020(); //initilize and setup the board
  attachInterrupt(digitalPinToInterrupt(interruptPin), sense, FALLING);

}

void loop() {

  Serial.println(readProximity());
    
}

void initVCNL3020() {
  byte temp = readVCNLByte(0x81);
  if (temp == 0x21)
  {
    //Serial.println("Success!");
  }

  writeVCNLByte(0x82, 0b111);
  writeVCNLByte(0x83, 0b111111);
  writeVCNLByte(0x8F, 0b00000001);
 
  writeVCNLByte(0x80,3);
 
  //writeVCNLByte(0x8C,0x12);
  //writeVCNLByte(0x8D,0x00);
//  writeVCNLByte(0x89, 0b01001010);


  writeVCNLByte(0x8C,0x2);
  writeVCNLByte(0x8D,0x80);
  writeVCNLByte(0x89, 0b01101010);

//  writeVCNLByte(0x8F, 0b00011001);
//  writeVCNLByte(0x8C,0x00);
//  writeVCNLByte(0x8D,0x00);
//  writeVCNLByte(0x89, 0b00001010);



}




unsigned int readProximity() {
  // readProximity() returns a 16-bit value from the VCNL4000's proximity data registers
  byte temp = readVCNLByte(0x80);
  writeVCNLByte(0x80, temp | 0x08);  // command the sensor to perform a proximity measure

  while (!(readVCNLByte(0x80) & 0x20)); // Wait for the proximity data ready bit to be set
  unsigned int data = readVCNLByte(0x87) << 8;
  data |= readVCNLByte(0x88);

  return data;
}


void writeVCNLByte(byte address, byte data) {
  // writeVCNLByte(address, data) writes a single byte of data to address
  Wire.beginTransmission(VCNL3020_ADDRESS);

  Wire.write(address);
  Wire.write(data);
  Wire.endTransmission();
}

byte readVCNLByte(byte address) {
  // readByte(address) reads a single byte of data from address
  Wire.beginTransmission(VCNL3020_ADDRESS);
  Wire.write(address);
  Wire.endTransmission();
  Wire.requestFrom(VCNL3020_ADDRESS, 1);

  while (!Wire.available());

  byte data = Wire.read();
  return data;
}

void sense() {
  high = true;
}

