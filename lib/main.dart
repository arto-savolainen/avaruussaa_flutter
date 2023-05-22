import 'package:flutter/material.dart';

import 'package:window_manager/window_manager.dart';

import 'views/mainview.dart';
import 'views/settingsview.dart';
import 'views/stationsview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(300, 225),
    center: true,
    backgroundColor: Colors.transparent,
    // backgroundColor: Color(0xff151515),
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,

  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setResizable(false);
    await windowManager.show();
    await windowManager.focus();
   
  });

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/main',
      routes: {
        '/main':(context) => MainView(),
        '/settings': (context) => SettingsView(),
        '/stations': (context) => StationsView()
      },
    );
  }
}
