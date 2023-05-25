import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:local_notifier/local_notifier.dart';
import 'views/main_view.dart';
import 'views/settings_view.dart';
import 'views/stations_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  // Initialize notifications
  await localNotifier.setup(
    appName: 'Avaruussää',
  );

  WindowOptions windowOptions = const WindowOptions(
    size: Size(319, 237),
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
          '/main': (context) => const MainView(),
          '/settings': (context) => const SettingsView(),
          '/stations': (context) => const StationsView()
        },
        debugShowCheckedModeBanner: false,
    );
  }
}
