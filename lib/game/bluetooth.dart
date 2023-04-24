import 'dart:async';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Bluetooth {
  // ignore: prefer_typing_uninitialized_variables
  var callback;
  var button;
  Bluetooth(callback, button) {
    this.callback = callback;
    this.button = button;
  }
  var close = false;
  Future<void> connect() async {
    try {
      BluetoothConnection connection =
          await BluetoothConnection.toAddress("24:4C:AB:09:D5:5E");
      print('Connected to the device');
      connection.input!.listen((data) {
        // the incomming data should be 5 bytes long
        // .buffer adds 3 bytes at the begining for some reason
        var buffer = data.buffer.asByteData(3, 5);
        var x = buffer.getUint16(0);
        var y = buffer.getUint16(2);
        var b = buffer.getUint8(4);
        //if button was pressed
        if (b == 1) {
          button();
        }
        //the range for the joystick values are from 0 to 4095 and 2048 are in the middle and it should be 0
        callback(x - 2048, 2048 - y);
        // close is true when disconnect is called
        if (close) {
          connection.finish(); // Closing connection
          print('Disconnecting by local host');
          close = false;
        }
      }).onDone(() {
        print('Disconnected by remote request');
      });
    } catch (exception) {
      print('Cannot connect, exception occured, exception: $exception');
    }
  }

  void disconnect() {
    close = true;
  }
}
