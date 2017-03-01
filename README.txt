—————————————————
EXECUTIVE SUMMARY
—————————————————

The VCNL3020 chip is a good near-distance proximity sensor. It is easy to program and interface with however when sensing humans, e.g. hands, heads, ears, I would suggest making sure the application requires the proximity distance to be within 3cm to achieve reliability. The chip can do all the processing, and can give the master uC interrupts when needed. This results in simple uC side programming. 

——————————————
FILES INCLUDED
——————————————

1. README
2. KICAD Files
3. Arduino Example
4. Documentation Files (data sheet + application note)

________
HARDWARE
————————

Breakout Board
——————————————
The VCNL3020 is a pretty tiny smd chip and seeing as the front of the sensor is where the sensing occurs it is rather difficult to dead-bug solder. The suggestion is to etch a breakout board for the chip. 

Accompanying Passives
—————————————————————
The chip needs several external components to make the chip work. The suggestion is to follow the circuit in the datasheet.  


——————————— 
PROGRAMMING
——————————— 

Reading and Writing
———————————————————
Using Arduino, it is straightforward to program using the <Wire.h> library. To write to a single register on the VNCL3020 chip, you need to give two pieces of data, the address of the register and the data you want written to it. The following method achieves this:

void writeVCNLByte(byte address, byte data) {
  // writeVCNLByte(address, data) writes a single byte of data to address
  Wire.beginTransmission(VCNL3020_ADDRESS);

  Wire.write(address);
  Wire.write(data);
  Wire.endTransmission();
}

The constant VCNL3020_ADDRESS is the I2C address of the chip and is set to 0x13 for all VCNL3020 chips. 

To read from the chip the the following method was used:

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

Setting Up and Receiving Data
—————————————————————————————

For just reading proximity measurements, only two registers need to be setup on start. 0x82 which is the Proximity Rate register, allows you to change the rate of the measurements from about 2 samples/s to 250 samples/s. 0x83 which is the IR LED current register which sets the amount of current going through the IR LED. To maximise range, set this to 200mA.

To receive proximity data from the chip you must first command the sensor to perform a measurement. Then wait until the measurement is ready and the read the data. The 16-bit data is stored in two 8-bit registers, so the need to joined together to create the final value. The following code was used:

unsigned int readProximity() {
  // readProximity() returns a 16-bit value from the VCNL4000's proximity data registers
  byte temp = readVCNLByte(0x80);
  writeVCNLByte(0x80, temp | 0x08);  // command the sensor to perform a proximity measure

  while (!(readVCNLByte(0x80) & 0x20)); // Wait for the proximity data ready bit to be set
  unsigned int data = readVCNLByte(0x87) << 8;  // Most significant byte
  data |= readVCNLByte(0x88);	 // Least significant byte. 

  return data;
}

Setting Up Interrupts
—————————————————————

To set up interrupts, two bits in Register 0 (0x80) need to be set, the prox_en and the selftimed_en bits. The thresholds also need to be set, a high and a low threshold can be set to trigger interrupts when they are hit. Both thresholds are set in 2 registers, for the low: 0x8A and 0x8B. For the high: 0x8C and 0x8D. Furthermore, the interrupt control register found at 0x89 needs to be configured. The int_count_exceed value must be set to configure how many consecutive measurements must pass the threshold for an interrupt to be triggered. It can be set from 1 count up to 128 counts. Furthermore int_prox_ready_en and  int_thres_en must be set and int_thres_sel must be set to 0. 

When an interrupt has occurred the corresponding bit in the Interrupt Status Register (0x8E) will go high and must be set (i.e. send a 1 to the bit that has already gone high) to reset the Interrupt and allow for another interrupt event to occur.

————————
PITFALLS
————————

There are several issues with the chip. 

1) All of the chips have a static I2C address. This means that you can’t have them on the same I2C line without a workaround. It is important to note that the <Wire.h> library only supports one I2C line, and connects to pins A4 and A5. Software I2C and other hardware solutions are possible. 

2) The claim is that the chip works up to 20cm. This is only for highly reflective surfaces. It is also noteworthy that different surfaces work differently and will have different ranges. This can become relevant to humans interacting with it when it comes to skin color, so it is important to test with multiple users before deployment. 

——————————————
IDEAL USE CASE
——————————————

For detecting people, it would be best used when the person is pressed up against the sensor, for example like when talking on a  mobile phone. 

——————————————————
EXTENDING DISTANCE
——————————————————

It is also possible to extend the proximity sensing distance to add external LED(s). The included application note explains how this is done. 


 



