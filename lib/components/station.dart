import 'package:flutter/material.dart';

class Station extends StatelessWidget {
  final String name;
  final double activity;
  final String error;
  final Function callback;

  Station(this.name, this.callback, {this.activity = 0, this.error = '',});

  @override
  Widget build(BuildContext context) {
    setStation() {
      //StationsService.setStation(name);
      callback(name);
      Navigator.pop(context);
    }

    return TextButton(onPressed: setStation, child: Text(name));
  }
}