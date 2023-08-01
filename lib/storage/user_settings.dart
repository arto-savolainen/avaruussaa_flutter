library;

import 'package:shared_preferences/shared_preferences.dart';

// This library offers functions for modifying and retrieving user settings stored in SharedPreferences.

// Define default values for settings that have not yet been modified.
/// Activity level threshold for showing a notification.
const double _thresholdDefault = 0.4;
/// Minimum time between notifications, in hours (avoids spamming the user every 10 minutes).
const double _intervalDefault = 1;
/// Notifications are enabled by default.
const bool _notificationsDefault = true;
/// Hide window and send app to tray on minimize.
const bool _minimizeDefault = true; 

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
