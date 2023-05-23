import 'package:avaruussaa_flutter/services/stations_service.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:window_manager/window_manager.dart';
import 'views/mainview.dart';
import 'views/settingsview.dart';
import 'views/stationsview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

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

  runApp(MainApp(model: StationsService()));
}

class MainApp extends StatelessWidget {
  final StationsService model;

  const MainApp({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: model,
      child: MaterialApp(
        initialRoute: '/main',
        routes: {
          '/main': (context) => MainView(),
          '/settings': (context) => SettingsView(),
          '/stations': (context) => StationsView()
        },
        debugShowCheckedModeBanner: false,
    ));
  }
}
