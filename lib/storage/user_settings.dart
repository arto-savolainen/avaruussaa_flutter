import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  static const double _tresholdDefault = 0.4; // Activity level treshold for showing a notification
  static const double _intervalDefault = 1; // Minimum time between notifications in hours

  UserSettings._();

  static setNotificationTreshold(double treshold) async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    settings.setDouble('NOTIFICATION_TRESHOLD', treshold);
  }

  static getNotificationTreshold() async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    if (!settings.containsKey('NOTIFICATION_TRESHOLD')) {
      return _tresholdDefault;
    }

    return settings.getDouble('NOTIFICATION_TRESHOLD');
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