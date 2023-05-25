import 'package:flutter/material.dart';
import '../components/appbar.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  SettingsViewState createState() => SettingsViewState();
}

class SettingsViewState extends State {
  // @override
  // initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final settingsView = Text('settings');
    const appBar = MyAppBar('settings');

    return Scaffold(
        appBar: appBar,
        body: SafeArea(child: Center(child: settingsView)));
  }
}