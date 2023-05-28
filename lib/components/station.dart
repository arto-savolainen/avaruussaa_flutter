import 'package:flutter/material.dart';

// Widgets created by this class are used to select a station's data for viewing by the user
// StationsView lists the stations in a grid of clickable buttons returned by Station's build function
class Station extends StatelessWidget {
  final String name; // Station name
  final double activity; // Current activity level measured at station
  final String error; // This is set if no valid data for the station could be retrieved 
  final Function callback; // This is called when the user presses the TextButton returned by build

  const Station(this.name, this.callback, {super.key, this.activity = 0, this.error = '',});


  @override
  Widget build(BuildContext context) {
    // When a user clicks the button, the callback function sets the current station in StationModel
    setStation() {
      // Callback function is StationsService.setStation(String stationName)
      callback(name);
      // Then we return to the main view
      Navigator.pop(context);
    }

    return TextButton(onPressed: setStation, child: Text(name));
  }

  @override
  String toString({ DiagnosticLevel minLevel = DiagnosticLevel.debug }) {
    return '{ name: $name, activity: $activity, error: $error }';
  }
}