library;

import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'system_tray_manager.dart';

/// Removes the system tray icon and exits the app.
Future<void> closeWindow() async {
  await destroySystemTray();
  appWindow.close();
}

/// Brings up the app window and sets a context menu for the tray with the Hide item on top.
Future<void> showWindow() async {
  appWindow.show();
  await createSystemTray(false);
}

/// Hides the app window and sets a context menu for the tray with the Show item on top.
Future<void> hideWindow() async {
  appWindow.hide();
  await createSystemTray(true);
}

/// Minimizes the app window.
void minimizeWindow() {
  appWindow.minimize();
}