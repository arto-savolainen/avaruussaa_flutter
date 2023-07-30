import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/main_view.dart';
import 'views/settings_view.dart';
import 'views/stations_view.dart';
import 'themes/theme.dart';
import 'system/system_tray_manager.dart';

void main() async {
  // Required by some packages accessing system functions.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications.
  await localNotifier.setup(
    appName: 'Avaruussää',
  );

  // Initialize system tray.
  await createSystemTray(false);

  runApp(const ProviderScope(child: AvaruussaaApp()));

  // Initialize window, must be done after runApp().
  _initWindow();
}

Future<void> _initWindow() async {
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

class AvaruussaaApp extends StatelessWidget {
  const AvaruussaaApp({super.key});

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