import 'package:flutter/material.dart';
import '../components/titlebar.dart';

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
    final titleBar = TitleBar('settings');
    final settingsView = Column(children: [titleBar, Text('settings')]);
    // const appBar = MyAppBar('settings');

    return Scaffold(
        // appBar: appBar,
        body: SafeArea(child: Center(child: settingsView)));
  }
}