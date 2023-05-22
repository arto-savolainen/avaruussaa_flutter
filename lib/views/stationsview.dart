import 'package:flutter/material.dart';
import '../components/station.dart';
import '../services/stations_service.dart';

class StationsView extends StatefulWidget {
  @override
  StationsViewState createState() => StationsViewState();
}

class StationsViewState extends State {
  late List<Station> stationsList;

  @override
  initState() {
    super.initState();
    updateStationsList();
  }

  updateStationsList() {
    stationsList = StationsService().getStations();

    // updateView();
  }

  updateView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final stationsGridView = GridView.count(
      crossAxisCount: 2,
      // childAspectRatio: (itemWidth / itemHeight),
      children: stationsList,
    );

    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Valitse havaintoasema', style: TextStyle(fontSize: 15))),
        body: SafeArea(child: Container(child: Center(child: stationsGridView))));
  }
}
