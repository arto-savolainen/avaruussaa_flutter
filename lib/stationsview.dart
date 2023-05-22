import 'package:flutter/material.dart';

class StationsView extends StatefulWidget {
  @override
  StationsViewState createState() => StationsViewState();
}

class StationsViewState extends State {
  var stationsList;

  @override
  initState() {
    super.initState();
    updateStationsList();
  }

  updateStationsList() {
    // stationsList = StationsApi().getStations();
    stationsList = [Text('station'), Text('station 2')];

    updateView();
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
        appBar: AppBar(centerTitle: true, title: Text('Valitse havaintoasema')),
        body: SafeArea(child: Container(child: Center(child: stationsGridView))));
  }
}
