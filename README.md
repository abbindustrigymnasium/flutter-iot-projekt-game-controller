# SpaceShooter

## Overview

A 2D game with the ability to connect bluetooth devices (bluetooth only works on android).

A minor modifide copy of Spacescape, repo: https://github.com/ufrshubham/spacescape
In that repo there exist a good install and setup manual. To connect a bluetooth device, the device needs to send data according to the format.
For now the bluetooth address is hard coded so if you want to connect you need to change it in the code (/lib/game/bluetooth.dart) to the right address.

## How does the bluetooth work

Bluetooth only works on android. To connect change the address in /lib/game/bluetooth.dart to the address to the bluetooth device you want to connect.

The data is sent in package of 5 bytes as big endian in the format:
|offset|length(bit)|description|
|-|-|-|
|0x00.0|16|x-axis|
|0x02.0|16|y-axis|
|0x04.0|1|joystick button|

note: The plan is to implement a more standard format
