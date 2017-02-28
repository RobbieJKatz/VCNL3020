EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:SensorEtch
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L VCNL3020 U1
U 1 1 58AAA32B
P 5350 3125
F 0 "U1" H 5500 2725 60  0000 C CNN
F 1 "VCNL3020" H 5350 3500 60  0000 C CNN
F 2 "SensorEtch:VCLN3020" H 5350 3125 60  0001 C CNN
F 3 "" H 5350 3125 60  0001 C CNN
	1    5350 3125
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X08 P1
U 1 1 58AAA376
P 5325 4075
F 0 "P1" H 5325 4525 50  0000 C CNN
F 1 "CONN_01X08" V 5425 4075 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08" H 5325 4075 50  0001 C CNN
F 3 "" H 5325 4075 50  0000 C CNN
	1    5325 4075
	0    1    1    0   
$EndComp
Wire Wire Line
	4850 3400 4850 3750
Wire Wire Line
	4850 3750 5175 3750
Wire Wire Line
	5175 3750 5175 3875
Wire Wire Line
	4850 3200 4775 3200
Wire Wire Line
	4775 3200 4775 3800
Wire Wire Line
	4775 3800 5075 3800
Wire Wire Line
	5075 3800 5075 3875
Wire Wire Line
	4850 3025 4650 3025
Wire Wire Line
	4650 3025 4650 3875
Wire Wire Line
	4650 3875 4975 3875
Wire Wire Line
	5825 3325 5825 3675
Wire Wire Line
	5825 3675 5275 3675
Wire Wire Line
	5275 3675 5275 3875
Wire Wire Line
	5825 3250 5875 3250
Wire Wire Line
	5875 3250 5875 3725
Wire Wire Line
	5875 3725 5375 3725
Wire Wire Line
	5375 3725 5375 3875
Wire Wire Line
	5825 3175 5900 3175
Wire Wire Line
	5900 3175 5900 3750
Wire Wire Line
	5900 3750 5475 3750
Wire Wire Line
	5475 3750 5475 3875
Wire Wire Line
	5825 3100 5925 3100
Wire Wire Line
	5925 3100 5925 3800
Wire Wire Line
	5925 3800 5575 3800
Wire Wire Line
	5575 3800 5575 3875
Wire Wire Line
	5825 2925 5975 2925
Wire Wire Line
	5975 2925 5975 3875
Wire Wire Line
	5975 3875 5675 3875
$EndSCHEMATC
