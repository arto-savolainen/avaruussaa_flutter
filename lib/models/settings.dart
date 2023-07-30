import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

/// Generates a model for user settings.
@freezed
class Settings with _$Settings {
  factory Settings({
    required double notificationThreshold,
    required double notificationInterval,
    required bool notificationsEnabled,
    required bool minimizeToTray,
  }) = _Settings;
}