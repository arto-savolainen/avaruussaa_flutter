import 'package:flutter/material.dart';
import '../services/stations_service.dart';

class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State {
  String currentStation = '';
  double activity = 0;

  @override
  // initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    currentStation = StationsService().getCurrent().name;
    activity = StationsService().getCurrent().activity;

    const activityStyleTemp = TextStyle(
      fontFamily: 'Calibri',
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Color(0xff1717fc));

    final stationBtn = TextButton(
      onPressed: () => Navigator.pushNamed(context, '/stations').then((_) => setState(() => {})),
      child: Text(currentStation));
    final stationIconBtn = GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/stations').then((_) => setState(() => {})),
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Image.asset('assets/station-icon.png')));
    final stationClickable = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [stationBtn, stationIconBtn]);

    final mainView = Column(children: [Text(activity.toString(), style: activityStyleTemp), stationClickable]);
    final appBar = AppBar( //TODO custom AppBar class, close & minimize buttons on the right
      leading: IconButton(
        icon: const Icon(Icons.menu), 
        onPressed: () => Navigator.pushNamed(context, '/settings').then((_) => setState(() => {}))),
      centerTitle: true, 
      title: const Text('Aktiivisuus'));

    return Scaffold(
        appBar: appBar,
        // body: SafeArea(child: Center(child: mainView))); for mobile
        body: Center(child: mainView));
  }
}