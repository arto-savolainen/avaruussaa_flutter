import 'package:flutter/material.dart';
import '../services/stations_service.dart';
import '../models/station_model.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

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
    const activityStyle = TextStyle(
      // TODO: better solution for styles?
      fontFamily: 'Calibri',
      fontSize: 50,
      fontWeight: FontWeight.bold,
      color: Color(0xff1717fc),
    );

    const timerStyle = TextStyle(
      fontSize: 14,
    );

    // Set text widgets for displaying activity level, time to next update, and the name of the currently selected station
    // Widgets built with ListenableBuilder are rebuilt when the StationModel object notifies them of changed values
    final activityText = ListenableBuilder(
        listenable: stationNotifier,
        builder: (BuildContext context, Widget? child) {
          return Text(
            stationNotifier.activity.toString(),
            style: activityStyle,
          );
        });

    final timerText = ListenableBuilder(
        listenable: stationNotifier,
        builder: (BuildContext context, Widget? child) {
          return Text(
            'Seuraava päivitys: ${stationNotifier.timerString}',
            style: timerStyle,
          );
        });

    final currentStationNameText = ListenableBuilder(
        listenable: stationNotifier,
        builder: (BuildContext context, Widget? child) {
          return Text(
            stationNotifier.name,
            softWrap: true,
          );
        });

    // Buttons that go to StationView
    final stationBtn = TextButton(
      onPressed: () => Navigator.pushNamed(context, '/stations'),
      child: currentStationNameText,
    );
    final stationIconBtn = GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/stations'),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Image.asset('assets/station-icon.png'),
      ),
    );
    final stationClickable = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: stationBtn),
        stationIconBtn,
      ],
    );

    // Main view and appBar
    final mainView = Column(
      children: [
        SizedBox(
          height: 70,
          child: Center(child: activityText),
        ),
        timerText,
        stationClickable,
      ],
    );
    final appBar = AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => Navigator.pushNamed(context, '/settings'),
      ),
      centerTitle: true,
      title: const Text('Aktiivisuus'),
    );

    return Scaffold(
      appBar: appBar,
      body: Center(child: mainView),
    );
  }
}