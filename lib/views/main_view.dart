import 'package:flutter/material.dart';
import '../services/stations_service.dart';
import '../models/station_model.dart';

class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State {
  final StationModel stationNotifier = StationModel();

  @override
  initState() {
    super.initState();
    // Below we pass the model object to StationsService so that the model we use is updated by the service
    // Changes in the model are reflected in this view
    StationsService.subscribe(stationNotifier);
  }

  @override
  Widget build(BuildContext context) {
    const activityStyleTemp = TextStyle(
      fontFamily: 'Calibri',
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Color(0xff1717fc));

    // Widgets built with ListenableBuilder are rebuilt when the model notifies them of changed values
    final currentStationNameText = ListenableBuilder(
      listenable: stationNotifier, 
      builder: (BuildContext context, Widget? child) {
        return Text(stationNotifier.name, softWrap: true);
      }
    );
    
    final activityText = ListenableBuilder(
      listenable: stationNotifier, 
      builder: (BuildContext context, Widget? child) {
        return Text(stationNotifier.activity.toString(), style: activityStyleTemp);
      }
    );

    final stationBtn = TextButton(
      onPressed: () => Navigator.pushNamed(context, '/stations'),
      child: currentStationNameText);
    final stationIconBtn = GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/stations'),
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Image.asset('assets/station-icon.png')));
    final stationClickable = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Flexible(child: stationBtn), stationIconBtn]);

    final mainView = Column(children: [activityText, stationClickable]);
    final appBar = AppBar( //TODO custom AppBar class, close & minimize buttons on the right
      leading: IconButton(
        icon: const Icon(Icons.menu), 
        onPressed: () => Navigator.pushNamed(context, '/settings')),
      centerTitle: true, 
      title: const Text('Aktiivisuus'));

    return Scaffold(
        appBar: appBar,
        body: Center(child: mainView));
  }
}