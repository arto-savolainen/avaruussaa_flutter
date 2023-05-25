import 'package:flutter/material.dart';
import '../components/station.dart';
import '../services/stations_service.dart';

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
    final stationsGridView = GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 0.5,
      childAspectRatio: 8,
      // childAspectRatio: (itemWidth / itemHeight),
      children: stationsList,
    );
    final gridContainer = Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10), child: stationsGridView);

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Valitse havaintoasema', style: TextStyle(fontSize: 15))),
        body: SafeArea(child: Center(child: gridContainer)));
  }
}
