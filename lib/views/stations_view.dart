import 'package:flutter/material.dart';
import '../components/station.dart';
import '../services/stations_service.dart';
import '../components/titlebar.dart';
import '../components/footer.dart';

class StationsView extends StatefulWidget {
  const StationsView({super.key});

  @override
  StationsViewState createState() => StationsViewState();
}

class StationsViewState extends State {
  List<Station> stationsList = [];

  @override
  initState() {
    super.initState();
    updateStationsList();
  }

  updateStationsList() async {
    stationsList = await StationsService.getStations();
    updateView();
  }

  updateView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const titleBar = TitleBar('stations');

    final stationsGridView = GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 0.5,
      childAspectRatio: 7,
      children: stationsList,
    );
    final gridContainer = Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10), child: stationsGridView);

    final stationsView = Column(children: [titleBar, Expanded(child: gridContainer)]);

    return Scaffold(
      body: SafeArea(child: Center(child: stationsView)),
      bottomSheet: const Footer(),
    );
  }
}
