import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/settings.dart';
import '../storage/user_settings.dart';


  // TODO: USE ASYNCNOTIFIERPROVIDER
class SettingsProvider extends StateNotifier<AsyncValue<Settings>> {
  SettingsProvider() : super(const AsyncValue.loading()) {
    _fetch();
  }

  _fetch() async {
    double notificationThreshold = await UserSettings.getNotificationThreshold();
    double notificationInterval = await UserSettings.getNotificationInterval();
    bool notificationsEnabled = await UserSettings.getNotificationsEnabled();
    bool minimizeToTray = await UserSettings.getMinimizeToTray();

    return Settings(
      notificationThreshold: notificationThreshold,
      notificationInterval: notificationInterval,
      notificationsEnabled: notificationsEnabled,
      minimizeToTray: minimizeToTray,
    );
  }

  static getProvider() {
    return FutureProvider<Settings>((ref) async {
      double notificationTreshold = await UserSettings.getNotificationThreshold();
      double notificationInterval = await UserSettings.getNotificationInterval();
      bool notificationsEnabled = await UserSettings.getNotificationsEnabled();
      bool minimizeToTray = await UserSettings.getMinimizeToTray();

      return Settings(
        notificationThreshold: notificationTreshold,
        notificationInterval: notificationInterval,
        notificationsEnabled: notificationsEnabled,
        minimizeToTray: minimizeToTray,
      );
    });
  }
}
