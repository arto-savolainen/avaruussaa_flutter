import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State {
  // @override
  // initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final mainView = ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/settings'),
      child: const Text('settings'));
    
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Aktiivisuus')),
        body: SafeArea(child: Container(child: Center(child: mainView))));
  }
}