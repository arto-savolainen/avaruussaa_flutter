import 'package:flutter/material.dart';

// Immutable class for holding app settings values, to be used with StateNotifier
class Settings {
  final double notificationThreshold;
  final double notificationInterval;
  final bool notificationsEnabled;
  final bool minimizeToTray;

  Settings({
    required this.notificationThreshold,
    required this.notificationInterval ,
    required this.notificationsEnabled ,
    required this.minimizeToTray,
  });

  Settings.defaultSettings({
    this.notificationThreshold = 0.4,
    this.notificationInterval = 1,
    this.notificationsEnabled = true,
    this.minimizeToTray = true,
  });

  Settings copyWith({
    double? notificationTreshold,
    double? notificationInterval,
    bool? notificationsEnabled,
    bool? minimizeToTray,
  }) {
    return Settings(
      notificationThreshold: notificationTreshold ?? this.notificationThreshold,
      notificationInterval: notificationInterval ?? this.notificationInterval,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      minimizeToTray: minimizeToTray ?? this.minimizeToTray,
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return '''{ notificationThreshold: $notificationThreshold, 
    notificationInterval: $notificationInterval, 
    notificationsEnabled: $notificationsEnabled, 
    minimizeToTray: $minimizeToTray }''';
  }
}
