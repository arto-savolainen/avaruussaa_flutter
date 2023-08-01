import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/stations_service.dart' as stations_service;
import '../models/station_model.dart';
import '../components/titlebar.dart';
import '../components/footer.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<MainView> createState() => MainViewState();
}

class MainViewState extends ConsumerState<MainView> {
  final StationModel stationNotifier = StationModel();

  @override
  initState() {
    super.initState();
    // Below we pass the model object to StationsService so that the model we use is updated by the service.
    // Changes in the model are reflected in this view.
    stations_service.subscribe(stationNotifier);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? activityStyle = Theme.of(context).textTheme.displayLarge;
    TextStyle? errorStyle = Theme.of(context).textTheme.bodyMedium;
    
    // Set text widgets for displaying activity level, time to next update, and the name of the currently selected station.
    // Widgets built with ListenableBuilder are rebuilt when the StationModel object notifies them of changed values.
    final activityText = ListenableBuilder(
        listenable: stationNotifier,
        builder: (BuildContext context, Widget? child) {
          return Text(
            // Display error message in place of activity if the model's error is not empty.
            stationNotifier.error == '' ? stationNotifier.activity.toString() : stationNotifier.error,
            style: stationNotifier.error == '' ? activityStyle : errorStyle,
            textAlign: TextAlign.center,
          );
        });

    final timerText = ListenableBuilder(
        listenable: stationNotifier,
        builder: (BuildContext context, Widget? child) {
          return Text('Seuraava päivitys: ${stationNotifier.timerString}'); 
        });

    final currentStationNameText = ListenableBuilder(
        listenable: stationNotifier,
        builder: (BuildContext context, Widget? child) {
          return Text(stationNotifier.name);
        });

    // Clickable elements that display the name of the currently selected weather station
    // and allow navigation to StationsView.
    final stationBtn = TextButton(
      onPressed: () => Navigator.pushNamed(context, '/stations'),
      child: currentStationNameText,
    );
    final stationIconBtn = GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/stations'),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Image.asset(
          'assets/station-icon.png',
          filterQuality: FilterQuality.high,
        ),
      ),
    );
    final stationRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: stationBtn),
        stationIconBtn,
      ],
    );

    // Views consist of a draggable title bar, the view content itself,
    // and a footer containing a link as the bottomSheet of the scaffold.
    final mainView = Column(
      children: [
        const TitleBar(viewId:'main'),
        SizedBox(
          height: 76,
          child: Center(child: activityText),
        ),
        timerText,
        const SizedBox(height: 5),
        stationRow,
      ],
    );

    return Scaffold(
      body: Center(child: mainView),
      bottomSheet: const Footer(),
    );
  }
}