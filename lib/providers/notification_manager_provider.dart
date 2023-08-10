import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/settings_model.dart';
import './settings_provider.dart';
import '../utils/set_timeout.dart';

part 'notification_manager_provider.g.dart';

/// AsyncNotifier which exposes the sendNotification() method to UI components.
/// Listens for changes in user settings and keeps track of the conditions for sending
/// notifications - only shows notifications if the settings allow it. Generates an
/// AsyncNotifierProvider "notificationManagerProvider" for accessing this Notifier.
@Riverpod(keepAlive: true)
class NotificationManager extends _$NotificationManager {
  bool _notificationsEnabled = false; // User setting for allowing notifications.
  double _notificationThreshold = 0; // Activity threshold for sending a notification.
  double _notificationInterval = 0; // Minimum time between notifications in hours.
  Timer? _intervalTimer; // If this timer is active i.e. not null, don't send notifications.
  final Stopwatch _timeElapsedStopwatch = Stopwatch(); // Time elapsed since the last notification.

  /// Sends a system notification using the local_notifier package. This function checks the values of user
  /// settings and only sends the notification if the following conditions are true: 1) notifications are
  /// turned on and 2) [activity] meets or exceeds threshold and 3) at least [_notificationInterval] time
  /// since the last notification has elapsed.
  void sendNotification(String stationName, double activity) {
    debugPrint('_notificationsEnabled: $_notificationsEnabled, _notificationThreshold: $_notificationThreshold');
    if (!_notificationsEnabled || activity < _notificationThreshold || _intervalTimer != null) {
      debugPrint('NOTIFICATION MANAGER: Returning without sending noti, timeElapsedStopWatch.millis: ${_timeElapsedStopwatch.elapsedMilliseconds}');
      return;
    }

    _startTimer(_hoursToSeconds(_notificationInterval));
    
    _showNotification('Revontulet todennäköisiä', 'Magneettinen aktiivisuus @ $stationName: $activity nT/s');
  }

  void _startTimer(int timerDurationInSeconds, [bool resetStopwatch = true]) {
    debugPrint('NOTIFICATION MANAGER: Starting timer with duration of: $timerDurationInSeconds seconds');
    _intervalTimer = setTimeout(timerDurationInSeconds, () =>_cancelTimeout());

    // Start the stopwatch to keep track of time elapsed since the last notification.
    // The stopwatch is reset when a new notification is being sent.
    if (resetStopwatch) {
      _timeElapsedStopwatch.reset();
    }
    _timeElapsedStopwatch.start();
  }

  int _hoursToSeconds(double hours) {
    return (hours * 60 * 60).round();
  }

  /// Cancels the timeout tied to [_intervalTimer] and sets the timer to null.
  void _cancelTimeout() {
      debugPrint('NOTIFICATION MANAGER: Canceling timeout');
      _intervalTimer?.cancel();
      _intervalTimer = null;
  }

  /// Changes the notification interval to [newIntervalInHours] hours. Modifies
  /// [_intervalTimer] to account for the new interval. As a result the timer
  /// keeps up with changes to the interval setting, and notifications are not
  /// sent unless at least the specified interval of time has elapsed since the
  /// last notification.
  void _changeNotificationInterval(double newIntervalInHours) {
    _notificationInterval = newIntervalInHours;
    Duration newIntervalDuration = Duration(seconds: _hoursToSeconds(newIntervalInHours));
    Duration timeLeft = newIntervalDuration - _timeElapsedStopwatch.elapsed;
    debugPrint('newIntervalDuration: $newIntervalDuration timeLeft: $timeLeft');
  
    // Check if the new interval is less than the time elapsed since last notification.
    if (timeLeft.inMicroseconds <= 0) {
      _cancelTimeout();
    }
    // If new interval is greater than time elapsed, cancel the old timeout and start a new
    // one with the duration of the remainder.
    else {
      _cancelTimeout();
      _startTimer(timeLeft.inSeconds, false);
    }
  }

  /// Sends a system notification using local_notifier.
  void _showNotification(String title, String body) {
    LocalNotification notification = LocalNotification(
      title: title,
      body: body,
    );

    notification.show();
  }

  @override
  build() {
    // Fetch values for user notification settings via asyncSettingsProvider.
    _notificationsEnabled = ref.read(asyncSettingsProvider).hasValue ? ref.read(asyncSettingsProvider).value!.notificationsEnabled : false;
    _notificationThreshold = ref.read(asyncSettingsProvider).hasValue ? ref.read(asyncSettingsProvider).value!.notificationThreshold : 0;
    _notificationInterval = ref.read(asyncSettingsProvider).hasValue ? ref.read(asyncSettingsProvider).value!.notificationInterval : 0;

    debugPrint('BUILDING NOTIFICATION MANAGER. _notificationsEnabled: $_notificationsEnabled, _notificationThreshold: $_notificationThreshold, _notificationInterval: $_notificationInterval');

    // Listen for changes in the notification settings.
    ref.listen(asyncSettingsProvider, (AsyncValue<Settings>? previous, AsyncValue<Settings> next) {
      if (next.hasValue) {
        Settings settings = next.value!;
        debugPrint('ref.listen: settings.notificationsEnabled: ${settings.notificationsEnabled} settings.notificationThreshold: ${settings.notificationThreshold}');
        _notificationsEnabled = settings.notificationsEnabled;
        _notificationThreshold = settings.notificationThreshold;
        _changeNotificationInterval(settings.notificationInterval);
      }
    });
  }
}