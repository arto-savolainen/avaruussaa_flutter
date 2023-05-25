import 'package:flutter/material.dart';
import 'dart:async';
import '../components/station.dart';

class StationModel with ChangeNotifier {
  String _name = 'loading...';
  double _activity = 0;
  Timer? _updateTimer;
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

  setTimer(int secondsToNextUpdate) {
    if (_updateTimer != null) {
      print('CANCELING OLD TIMER');
      _updateTimer?.cancel();
    }

    print('arrived in setTimer, secondsToNextUpdate: $secondsToNextUpdate');
    DateTime updateTime = DateTime.now().add(Duration(seconds: secondsToNextUpdate));
    _updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateSeconds(updateTime));

  }

  _updateSeconds(DateTime updateTime) {
    print('UPDATETIME: $updateTime');
    int timeToUpdate = ((updateTime.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch) / 1000).round();
    print('TIMETOUPDATE: $timeToUpdate');
  }
}

