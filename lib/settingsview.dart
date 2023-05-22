import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
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

    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Asetukset')),
        body: SafeArea(child: Container(child: Center(child: settingsView))));
  }
}