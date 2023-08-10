import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/titlebar.dart';
import '../components/footer.dart';
import '../components/station.dart';
import '../models/settings_model.dart';
import '../providers/stations_data_provider.dart';
import '../providers/settings_provider.dart';

/// The main view of the app. Displays a weather station's magnetic activity.
/// Listens to asyncStationsDataProvider which supplies the view with data.
class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  /// Determines the style of the activity element's text. Text color is red if [activity]
  /// is equal to or higher than settings.notificationThreshold, blue otherwise.
  TextStyle _getActivityStyle(double activity, AsyncValue<Settings> asyncSettings, BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.displayLarge!;

    return asyncSettings.when(
      data: (settings) {
        return activity >= settings.notificationThreshold ? style.copyWith(color: Colors.red) : style;
      },
      error: (error, stackTrace) => style,
      loading: () => style,
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncSettings = ref.watch(asyncSettingsProvider);
    final asyncStationsData = ref.watch(asyncStationsDataProvider);
    
    return asyncStationsData.when(
      data: (stationsData) {
        Station currentStation = stationsData.currentStation;
        TextStyle activityStyle = _getActivityStyle(currentStation.activity, asyncSettings, context);
        TextStyle errorStyle = Theme.of(context).textTheme.bodyMedium!;

        final activityText = Text(
          // Display error message in place of activity if currentStation.error is not empty.
          currentStation.error == '' ? currentStation.activity.toString() : currentStation.error,
          style: currentStation.error == '' ? activityStyle : errorStyle,
          textAlign: TextAlign.center,
        );

        final timerText =
            Text('Seuraava päivitys: ${stationsData.timerString}');

        // Clickable widgets that display the name of the currently selected weather station
        // and allow navigation to StationsView.
        final stationBtn = TextButton(
          onPressed: () => Navigator.pushNamed(context, '/stations'),
          child: Text(currentStation.name),
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

        // Views consist of a title bar, the view content itself,
        // and a footer containing a link as the bottomSheet of the scaffold.
        final mainView = Column(
          children: [
            const TitleBar(viewId: 'main'),
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
      },
      error: (error, stackTrace) => Scaffold(body: Center(child: Text('Virhe: $error'))),
      // The provider's state is set almost instantly so in this case it
      // doesn't really matter what we put here.
      loading: () => const Scaffold(body: Center(child: Text('ladataan'))),
    );
  }
}
