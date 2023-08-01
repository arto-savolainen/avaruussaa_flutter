import 'dart:async';

import 'package:flutter/material.dart';

import '../components/station.dart';
import '../utils/set_timeout.dart';

/// Data model for the currently selected station and the UI update timer.
/// Notifies listeners in MainView when station data or the timer changes, 
/// triggering a rebuild of widgets dependent on the model's data.
class StationModel with ChangeNotifier {
  String _name = 'loading...';
  String _error = '';
  double _activity = 0;
  Timer? _timer;
  String _timerString = '00:00';
  String get name => _name;
  String get error => _error;
  double get activity => _activity;
  String get timerString => _timerString;

  setCurrentStation(Station newStation) {
    debugPrint('UPDATING STATIONMODEL');
    _activity = newStation.activity;
    _name = newStation.stationName;
    _error = newStation.error;

    notifyListeners();
  }

  setTimer(int secondsToNextUpdate) {
    if (_timer != null) {
      debugPrint('CANCELING OLD TIMER');
      _timer?.cancel();
    }

    debugPrint('arrived in setTimer, secondsToNextUpdate: $secondsToNextUpdate');
    DateTime updateTime = DateTime.now().add(Duration(seconds: secondsToNextUpdate));
    _updateTimerString(updateTime);
    _timer = setRepeatingTimeout(1, (timer) => _updateTimerString(updateTime));
  }

  _updateTimerString(DateTime updateTime) {
    int secondsToNextUpdate = ((updateTime.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch) / 1000).round();

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

