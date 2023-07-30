import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/settings.dart';
import '../storage/user_settings.dart' as user_settings;

part 'settings_provider.g.dart';

/// AsyncNotifier which exposes app settings. Generates an AsyncNotifierProvider that
/// provides information to UI components and saves changes by calling user_settings,
/// which writes the settings to SharedPreferences.
@riverpod
class AsyncSettings extends _$AsyncSettings {
  Future<Settings> _fetchSettings() async {
    double notificationTreshold = await user_settings.getNotificationThreshold();
    double notificationInterval = await user_settings.getNotificationInterval();
    bool notificationsEnabled = await user_settings.getNotificationsEnabled();
    bool minimizeToTray = await user_settings.getMinimizeToTray();

    return Settings(
      notificationThreshold: notificationTreshold,
      notificationInterval: notificationInterval,
      notificationsEnabled: notificationsEnabled,
      minimizeToTray: minimizeToTray,
    );
  }

  @override
  FutureOr<Settings> build() async {
    return _fetchSettings();
  }

  // Note: These functions are called from SettingsView when the user changes a setting.
  /// Sets the AsyncNotifier's state with notificationThreshold changed to [value]
  /// and calls user_settings to write the updated value to SharedPreferences.
  Future<void> setNotificationsThreshold(double value) async {
    // state.value should never be null at this point so we can bypass null safety.
    Settings? newState = state.value?.copyWith(notificationThreshold: value);
    // Set the state to update UI.
    state = AsyncValue.data(newState!);

    // Finally, write the new value of the setting to SharedPreferences.
    await user_settings.setNotificationThreshold(value);
  }

  /// Sets the AsyncNotifier's state with notificationInterval changed to [value]
  /// and calls user_settings to write the updated value to SharedPreferences.
  Future<void> setNotificationsInterval(double value) async {
    Settings? newState = state.value?.copyWith(notificationInterval: value);
    state = AsyncValue.data(newState!);

    await user_settings.setNotificationInterval(value);
  }

  /// Sets the AsyncNotifier's state with notificationEnabled changed to [enabled]
  /// and calls user_settings to write the updated value to SharedPreferences.
  Future<void> setNotificationsEnabled(bool enabled) async {
    Settings? newState = state.value?.copyWith(notificationsEnabled: enabled);
    state = AsyncValue.data(newState!);

    await user_settings.setNotificationsEnabled(enabled);
  }

  /// Sets the AsyncNotifier's state with minimizeToTray changed to [minimized]
  /// and calls user_settings to write the updated value to SharedPreferences.
  Future<void> setMinimizeToTray(bool minimized) async {
    Settings? newState = state.value?.copyWith(minimizeToTray: minimized);
    state = AsyncValue.data(newState!);

    await user_settings.setMinimizeToTray(minimized);
  }
}
