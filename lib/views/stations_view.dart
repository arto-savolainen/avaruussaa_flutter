import 'package:flutter/material.dart';
import '../components/station.dart';
import '../services/stations_service.dart' as stations_service;
import '../components/titlebar.dart';
import '../components/footer.dart';

/// Displays a grid of available weather stations. The user can click on the
/// name of a station to view its activity data (Station widget is clickable).
class StationsView extends StatefulWidget {
  const StationsView({super.key});

  @override
  StationsViewState createState() => StationsViewState();
}

class StationsViewState extends State {
  List<Station> stationList = [];

  @override
  initState() {
    super.initState();
    updateStationsList();
  }

  /// Get station data from the stations service.
  updateStationsList() async {
    stationList = await stations_service.getStations();
    updateView();
  }

  /// Rebuild the view after station data has been retrieved.
  updateView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const titleBar = TitleBar(viewId: 'stations');

    final stationsGridView = GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 0.5,
      childAspectRatio: 7,
      children: stationList,
    );
    final gridContainer = Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: stationsGridView,
    );

    final stationsView = Column(
      children: [
        titleBar,
        Expanded(child: gridContainer),
      ],
    );

    return Scaffold(
      body: SafeArea(child: Center(child: stationsView)),
      bottomSheet: const Footer(),
    );
  }
}
