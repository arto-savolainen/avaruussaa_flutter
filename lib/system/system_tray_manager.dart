import 'package:system_tray/system_tray.dart';
import 'window_manager.dart';

/// Removes the system tray icon.
Future<void> destroySystemTray() async {
  SystemTray().destroy();
}

/// Creates a system tray icon and sets click event listeners and the context menu for it.
/// The top menu item is either Show or Hide, which shows or hides the app window respectively.
/// Set [topItemIsShow] to true for Show or false for Hide.
Future<void> createSystemTray(bool topItemIsShow) async {
  // Note: There doesn't appear to be a way to modify the menu of an existing system tray,
  // so we must initialize a new tray every time the menu needs to be changed.
  // Calling SystemTray() invalidates any existing system tray.
  final SystemTray systemTray = SystemTray();
  final Menu menu = Menu();

  // Create the clickable context menu labels.
  final showItem = MenuItemLabel(
    label: 'Show',
    onClicked: (menuItem) async {
      await showWindow();
    },
  );
  final hideItem = MenuItemLabel(
    label: 'Hide',
    onClicked: (menuItem) async {
      await hideWindow();
    },
  );
  final exitItem = MenuItemLabel(
    label: 'Exit',
    onClicked: (menuItem) async {
      await closeWindow();
    },
  );

  await systemTray.initSystemTray(
    title: 'Avaruussää', // This only does something on MacOS.
    iconPath: 'assets/icon.ico',
  );

  // Build and set the context menu.
  await menu.buildFrom([
    topItemIsShow ? showItem : hideItem,
    exitItem,
  ]);
  await systemTray.setContextMenu(menu);

  // Handle system tray click events.
  systemTray.registerSystemTrayEventHandler((eventName) async {
    // Bring app to focus when user left-clicks the system tray icon.
    if (eventName == kSystemTrayEventClick) {
      await showWindow();
    }
    // Show context menu on right click.
    else if (eventName == kSystemTrayEventRightClick) {
      systemTray.popUpContextMenu();
    }
  });
}
