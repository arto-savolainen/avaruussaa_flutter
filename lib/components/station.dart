import 'package:flutter/material.dart';
import '../services/stations_service.dart';

class Station extends StatelessWidget {
  final String name;
  final double activity;
  String error;

  Station(this.name, {this.activity = 0, this.error = ''});

  @override
  Widget build(BuildContext context) {
    setStation() {
      StationsService.setStation(name);
      Navigator.pop(context);
    }

    return TextButton(onPressed: setStation, child: Text(name));
  }
}