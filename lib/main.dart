import 'package:flutter/material.dart';
import 'mainview.dart';
import 'settingsview.dart';
import 'stationsview.dart';

void main() {
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
