// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'dart:async';
import '../components/station.dart';
import '../util/set_timeout.dart';

class StationModel with ChangeNotifier {
  String _name = 'loading...';
  double _activity = 0;
  Timer? _timer;
  String _timerString = '00:00';
  String get name => _name;
  double get activity => _activity;
  String get timerString => _timerString;

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
    if (_timer != null) {
      print('CANCELING OLD TIMER');
      _timer?.cancel();
    }

    print('arrived in setTimer, secondsToNextUpdate: $secondsToNextUpdate');
    DateTime updateTime = DateTime.now().add(Duration(seconds: secondsToNextUpdate));
    _updateTimer(updateTime);
    _timer = setRepeatingTimeout(1, (timer) => _updateTimer(updateTime));
  }

  _updateTimer(DateTime updateTime) {
    print('UPDATETIME: $updateTime');
    int secondsToNextUpdate = ((updateTime.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch) / 1000).round();
    print('TIMETOUPDATE: $secondsToNextUpdate');

    if (secondsToNextUpdate < 0) {
      return;
    }

    int minutes = (secondsToNextUpdate / 60).floor();
    int seconds = secondsToNextUpdate - minutes * 60;
    String minutesString = minutes < 10 ? '0$minutes' : '$minutes';
    String secondsString = seconds < 10 ? '0$seconds' : '$seconds';
    _timerString = '$minutesString:$secondsString';

    notifyListeners();
  }
}

