import 'package:flutter/material.dart';
import '../services/stations_service.dart';
import '../components/station.dart';

class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State {
  String currentStationName = 'loading...';
  double activity = 0;

  @override
  initState() {
    super.initState();
    getStationData();
  }

  getStationData() async {
    var currentStation = await StationsService.getCurrent();
    currentStationName = currentStation.name;
    activity = currentStation.activity;
    updateView();
  }

  updateView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const activityStyleTemp = TextStyle(
      fontFamily: 'Calibri',
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Color(0xff1717fc));

    final currentStationNameText = Text(currentStationName);
    final activityText = Text(activity.toString(), style: activityStyleTemp);

    final stationBtn = TextButton(
      onPressed: () => Navigator.pushNamed(context, '/stations').then((_) => getStationData()),
      child: currentStationNameText);
    final stationIconBtn = GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/stations').then((_) => getStationData()),
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Image.asset('assets/station-icon.png')));
    final stationClickable = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [stationBtn, stationIconBtn]);

    final mainView = Column(children: [activityText, stationClickable]);
    final appBar = AppBar( //TODO custom AppBar class, close & minimize buttons on the right
      leading: IconButton(
        icon: const Icon(Icons.menu), 
        onPressed: () => Navigator.pushNamed(context, '/settings').then((_) => getStationData())),
      centerTitle: true, 
      title: const Text('Aktiivisuus'));

    setState(() {
      
    });

    return Scaffold(
        appBar: appBar,
        // body: SafeArea(child: Center(child: mainView))); for mobile
        body: Center(child: mainView));
  }
}