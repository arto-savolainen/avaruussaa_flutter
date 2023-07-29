import 'package:shared_preferences/shared_preferences.dart';

// This class offers static functions for modifying and retrieving user settings stored in SharedPreferences
class UserSettings {
  static const double _thresholdDefault = 0.4; // Activity level threshold for showing a notification
  static const double _intervalDefault = 1; // Minimum time between notifications in hours
  static const bool _notificationsDefault = true; // Send desktop notifications
  static const bool _minimizeDefault = true; // Hide window and send to tray on minimize

  UserSettings._();

  static setNotificationsEnabled(bool value) async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    settings.setBool('NOTIFICATIONS_ENABLED', value);
  }

  static getNotificationsEnabled() async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    if (!settings.containsKey('NOTIFICATIONS_ENABLED')) {
      return _notificationsDefault;
    }

    return settings.getBool('NOTIFICATIONS_ENABLED');
  }

  static setMinimizeToTray(bool value) async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    settings.setBool('MINIMIZE_TO_TRAY', value);
  }

  static getMinimizeToTray() async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    if (!settings.containsKey('MINIMIZE_TO_TRAY')) {
      return _minimizeDefault;
    }

    return settings.getBool('MINIMIZE_TO_TRAY');
  }

  static setNotificationThreshold(double threshold) async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    settings.setDouble('NOTIFICATION_THRESHOLD', threshold);
  }

  static getNotificationThreshold() async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    if (!settings.containsKey('NOTIFICATION_THRESHOLD')) {
      return _thresholdDefault;
    }

    return settings.getDouble('NOTIFICATION_THRESHOLD');
  }

  static setNotificationInterval(double interval) async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    settings.setDouble('NOTIFICATION_INTERVAL', interval);
  }

  static getNotificationInterval() async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    if (!settings.containsKey('NOTIFICATION_INTERVAL')) {
      return _intervalDefault;
    }

    return settings.getDouble('NOTIFICATION_INTERVAL');
  }
}