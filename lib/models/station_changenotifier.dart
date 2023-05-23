import 'package:flutter/material.dart';
import '../components/station.dart';

class StationModel with ChangeNotifier {
  String _name = '';
  double _activity = 0;
  String get name => _name;
  double get activity => _activity;

  updateCurrentStation(Station newStation) {
    print('UPDATING STATIONMODEL');
    _activity = newStation.activity;

    if (newStation.error.isNotEmpty) {
      _name = newStation.error;
    }
    else {
      _name = newStation.name;
    }

    notifyListeners();
  }
}
