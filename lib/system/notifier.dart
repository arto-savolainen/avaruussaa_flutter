library;

import 'package:local_notifier/local_notifier.dart';

import '../storage/user_settings.dart' as user_settings;

/// Sends a system notification informing the user that northern lights are likely at [stationName].
/// Note that this function checks user settings in SharedPreferences and only sends the notification
/// if NOTIFICATIONS_ENABLED == true and NOTIFICATION_THRESHOLD >= [activity].
Future<void> showNotification(String stationName, double activity) async {
  // Fetch the value of the notificationsEnabled setting.
  bool notificationsEnabled = await user_settings.getNotificationsEnabled();
  double notificationThreshold = await user_settings.getNotificationThreshold();

  // Only show notification if 1) notifications are turned on and
  // 2) activity meets or exceeds threshold.
  if (!notificationsEnabled || activity < notificationThreshold) {
    return;
  }

  LocalNotification notification = LocalNotification(
    title: "Revontulet todennäköisiä",
    body: "Magneettinen aktiivisuus @ $stationName: $activity nT/s",
  );

  notification.show();
}
