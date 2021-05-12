This document describes a custom electronics setup for a Voron2.4
printer.

# Huvud boards

The printer uses three [Huvud
boards](https://github.com/bondus/KlipperToolboard).  One is mounted
to the toolhead stepper motor and the other two are mounted to the
back of the corexy stepper motors.

A single CAN bus is used to communicate with these Huvud boards.  The
Raspberry Pi running Klipper has a [canable](https://canable.io/) USB
adapter for CAN bus communication.

A custom wiring harness was made for the CAN bus - the bus routes the
toolhead huvud board, to the canable usb adapter, to the rear-right
corexy huvud board, and finally to the rear-left corexy huvud board.
The wiring harness is comprised of four 20AWG wires: 24V, GND, CANH,
CANL.  A 120 Ohm "through hole" resistor is soldered between the CAN
wires at both ends of the wiring bus (near the toolhead Huvud board
and near the rear-left corexy Huvud board).

The toolhead wires follow the filament "reverse bowden" tube.  The
standard Voron XY cable chains are not deployed.  I purchased "1/2
inch black PET wire loom split tubing" (from Amazon) for wire
management.

For the wires between the two corexy stepper motors, I designed a
[rear wire clip](rear_wire_guide.stl) to route the wires along the
2020 aluminum extrusion.

# Homing

This printer uses an experimental Klipper setup using multi-mcu
homing.  The corexy and Z stepper motors also use "sensorless homing"
via Trinamic tmc2209 drivers.  The standard Voron XY endstop switches
were not deployed.  The standard Voron Z endstop switch was not
deployed.

The Z sensorless homing is done by moving the Z away from the bed
until each Z carriage contacts the top of the rail.  I designed [Z
rail ends](z_stop.stl) for the top of rail contact point.

# Other

The Z stepper motors are controlled by a "bigtreetech mini-mz" board.
This board was deployed because of its availability at the time of
assembly.  The board is mounted under the printer via the DIN rails.
(The screw holes on the standard Voron Raspberry Pi holder was close
enough to the mini-mz mounting holes that I could reuse that holder to
mount this board.)

A chamber thermistor is deployed on the rear-left corexy Huvud board.
It is a generic "NTC 3950" glass bead type thermistor (purchased from
Amazon as a ten pack).
