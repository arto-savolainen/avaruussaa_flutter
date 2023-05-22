import 'package:flutter/material.dart';
import '../components/station.dart';
import '../services/stations_service.dart';

class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State {
  late Station currentStation;

  @override
  // initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    currentStation = StationsService().getCurrent();

    final stationsBtn = ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/stations').then((_) => setState(() => {})),
      child: const Text('stations'));

    final mainView = Column(children: [stationsBtn, Text('CURRENT STATION: ${currentStation.name}')]);
    final appBar = AppBar( //TODO custom AppBar class, close & minimize buttons on the right
      leading: IconButton(
        icon: const Icon(Icons.menu), 
        onPressed: () => Navigator.pushNamed(context, '/settings').then((_) => setState(() => {}))),
      centerTitle: true, 
      title: const Text('Aktiivisuus'));

    return Scaffold(
        appBar: appBar,
        body: SafeArea(child: Container(child: Center(child: mainView))));
  }
}