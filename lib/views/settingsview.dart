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
    final appBar = AppBar( //TODO apply app styles
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), 
        onPressed: () => Navigator.pop(context)),
      centerTitle: true, 
      title: const Text('Asetukset'));

    return Scaffold(
        appBar: appBar,
        body: SafeArea(child: Container(child: Center(child: settingsView))));
  }
}