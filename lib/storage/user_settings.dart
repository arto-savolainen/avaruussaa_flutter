library;

import 'package:shared_preferences/shared_preferences.dart';

// This library offers functions for modifying and retrieving user settings stored in SharedPreferences.

const double _thresholdDefault =
    0.4; // Activity level threshold for showing a notification.
const double _intervalDefault =
    1; // Minimum time between notifications in hours.
const bool _notificationsDefault = true; // Send desktop notifications.
const bool _minimizeDefault = true; // Hide window and send to tray on minimize.

setNotificationsEnabled(bool value) async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  settings.setBool('NOTIFICATIONS_ENABLED', value);
}

getNotificationsEnabled() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  if (!settings.containsKey('NOTIFICATIONS_ENABLED')) {
    return _notificationsDefault;
  }

  return settings.getBool('NOTIFICATIONS_ENABLED');
}

setMinimizeToTray(bool value) async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  settings.setBool('MINIMIZE_TO_TRAY', value);
}

getMinimizeToTray() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  if (!settings.containsKey('MINIMIZE_TO_TRAY')) {
    return _minimizeDefault;
  }

  return settings.getBool('MINIMIZE_TO_TRAY');
}

setNotificationThreshold(double threshold) async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  settings.setDouble('NOTIFICATION_THRESHOLD', threshold);
}

getNotificationThreshold() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  if (!settings.containsKey('NOTIFICATION_THRESHOLD')) {
    return _thresholdDefault;
  }

  return settings.getDouble('NOTIFICATION_THRESHOLD');
}

setNotificationInterval(double interval) async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  settings.setDouble('NOTIFICATION_INTERVAL', interval);
}

getNotificationInterval() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  if (!settings.containsKey('NOTIFICATION_INTERVAL')) {
    return _intervalDefault;
  }

  return settings.getDouble('NOTIFICATION_INTERVAL');
}
