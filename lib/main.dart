import 'package:flutter/material.dart';
// import 'package:window_manager/window_manager.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:system_tray/system_tray.dart';
import 'views/main_view.dart';
import 'views/settings_view.dart';
import 'views/stations_view.dart';
import 'themes/theme.dart';

void main() async {
  // Required by some packages accessing system functions
  WidgetsFlutterBinding.ensureInitialized();
  // // Must add this line.
  // await windowManager.ensureInitialized();

  // Initialize notifications
  await localNotifier.setup(
    appName: 'Avaruussää',
  );

  // Initialize system tray
  initSystemTray();

  runApp(const MainApp());

  // Initialize window *after* runApp
  initWindow();
}

Future<void> initSystemTray() async {
  String iconPath = 'assets/icon.ico';

  final AppWindow appWindow = AppWindow();
  final SystemTray systemTray = SystemTray();

  // We first init the systray menu
  await systemTray.initSystemTray(
    title: "system tray",
    iconPath: iconPath,
  );

  // Create context menu
  final Menu menu = Menu();
  await menu.buildFrom([
    MenuItemLabel(
      label: 'Show',
      onClicked: (menuItem) {
        appWindow.show();
      },
    ),
    MenuItemLabel(
      label: 'Exit',
      onClicked: (menuItem) async {
        await systemTray.destroy();
        appWindow.close(); 
      },
    ),
  ]);

  await systemTray.setContextMenu(menu);

  // Handle system tray events
  systemTray.registerSystemTrayEventHandler((eventName) {
    debugPrint("system_tray eventName: $eventName");
    debugPrint('kSystemTrayEventClick: $kSystemTrayEventClick');
    if (eventName == kSystemTrayEventClick) {
      appWindow.show();
    } 
    else if (eventName == kSystemTrayEventRightClick) {
      systemTray.popUpContextMenu();
    }
  });
}

Future<void> initWindow() async {
  doWhenWindowReady(() {
    const initialSize = Size(300, 225);
    appWindow.minSize = initialSize;
    appWindow.maxSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'Avaruussää';
    appWindow.show();
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AvaruusTheme.theme,
      initialRoute: '/main',
      routes: {
        '/main': (context) => const MainView(),
        '/settings': (context) => const SettingsView(),
        '/stations': (context) => const StationsView(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}