---
sidebar_position: 1
---

# Electronics: introduction

The open robotic incubator is driven by a RAMPS board. These are very useful boards for these types of projects. They are designed as 3D printer controllers, and so are mass-produced. But they are made up simply of a standard ARDUINO Mega 2560 and a shield that sits on top of it. The shield has stepper motor output and a range of other outputs that we can use to control every aspect of the incubator. We write our own driver software.

## RAMPS board

Start by assembling the RAMPS board. Carefully line up the pins with the Arduino board and push them together. Connect the terminals for the power supply if supplied separately.

We need to set the jumpers for microstepping for the stepper motors. 

[Todo: record the jumper settings for all steppers]



 Insert the stepper motor drivers. We need drivers for X, Y and Z. 

:::warning

Make sure you insert the stepper motor drivers the right way around. The adjustable potentiometers end up pointing away from where the power supply comes into the RAMPS. The drivers are sensitive and will blow if you suddenly connect/disconnect the stepper motor while the power supply is on - always power down before connecting or disconnecting the motors. If the drivers blow you can replace them.

:::

## Stepper motors

All of the stepper motors are NEMA-17. We used, for example https://www.openimpulse.com/blog/products-page/product-category/42byghw811-stepper-motor-2-5-4-8-kg%E2%8B%85cm/ .

The axes are as follows:
X: move carriage up and down with leadscrew
Y: move carriage in and out with belt
Z: open and close door

## Limit switches

For the X and Y axes we use limit switches to allow the robot to home on startup. We use widely available PCB-mounted limit switches originally for Makerbots: https://www.amazon.co.uk/GALDOEP-Printer-Switch%EF%BC%8CMicro-Arduino-Makerbot/dp/B09ZFBNJLG/ref=sr_1_4_sspa?crid=2R14XAW1E343U&keywords=makerbot+limit+switch&qid=1705780946&sprefix=makerbot+limit+switch%2Caps%2C70&sr=8-4-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&psc=1


# DC loads

We use the three MOSFETrs on the RAMPS board to control several DC loads. These are:

## D10: the solenoid valve
:::warning

When connecting up the solenoid valve (we used a 2W-025-08)

:::

## D9: the fans

There are a variety of fans to circulate air around the incubator. We connect them all in parallel. We also connect the heat-sink fan used to heat the incubator to this.

## D8: the heater

The beefiest output is D8 which we use to control the heater, which has a fan blowing through it.

# The oxygen / temperature sensor

We power the O2 sensor from the GND and 5V pins in the aux region of the board, and connect it to D16 and D17 to read the data from a secondary Arduino serial port.




