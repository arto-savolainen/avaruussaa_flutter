import 'package:avaruussaa_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/stations_service.dart';
import '../models/station_model.dart';
import '../components/titlebar.dart';
import '../components/footer.dart';
import '../models/settings.dart';

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
    // Below we pass the model object to StationsService so that the model we use is updated by the service
    // Changes in the model are reflected in this view
    StationsService.subscribe(stationNotifier);
  }

  @override
  Widget build(BuildContext context) {
    // This forces async initialization of app settings before loading the settings view
    // Thus eliminating any visual bugs resulting from async operations finishing after view render
    // ignore: unused_local_variable
    final AsyncValue<Settings> settings = ref.watch(settingsProvider);

    TextStyle? activityStyle = Theme.of(context).textTheme.displayLarge;
    TextStyle? errorStyle = Theme.of(context).textTheme.bodyMedium;

    // Set text widgets for displaying activity level, time to next update, and the name of the currently selected station
    // Widgets built with ListenableBuilder are rebuilt when the StationModel object notifies them of changed values
    final activityText = ListenableBuilder(
        listenable: stationNotifier,
        builder: (BuildContext context, Widget? child) {
          return Text(
            // Display error message in place of activity if the model's error is not empty
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

    // Clickable elements to navigate to StationsView
    final stationBtn = TextButton(
      onPressed: () => Navigator.pushNamed(context, '/stations'),
      child: currentStationNameText,
    );
    final stationIconBtn = GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/stations'),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Image.asset('assets/station-icon.png', filterQuality: FilterQuality.high,),
      ),
    );
    final stationRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: stationBtn),
        stationIconBtn,
      ],
    );

    // Views consist of a title bar and the view components defined by the view class, 
    // and a link footer as the bottomSheet of the scaffold
    final mainView = Column(
      children: [
        const TitleBar('main'),
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
    // return settingsTest.when(
    //   loading: () => Scaffold(body: Center(child: Text('LOADING'))),
    //   error: () => Scaffold(body: Center(child: Text('ERROR'))),
    //   data: (settings) => Scaffold(body: Center(child: Text('SETTINGS: $settings'))),
    // );
  }
}