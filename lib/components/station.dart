import 'package:flutter/material.dart';

/// A clickable TextButton which calls the given [callback] function and pops to the previous view.
/// Widgets created by this class are used by StationsView to allow the user to select a weather
/// station's data for viewing.
class Station extends StatelessWidget {
  const Station({
    required this.stationName,
    required this.callback,
    this.activity = 0,
    this.error = '',
    super.key,
  });

  final String stationName;
  final double activity; // Current activity level measured at station.
  final String error; // This is set if no valid data for the station could be retrieved.
  final Function callback; // This is called when the user presses the TextButton returned by build.

  @override
  Widget build(BuildContext context) {
    // When a user clicks the button, the callback function sets the current station in StationModel.
    handleClick() {
      // Callback function should be StationsService.setStation(String stationName).
      callback(stationName);
      // Then we return to the main view.
      Navigator.pop(context);
    }

    return TextButton(
      onPressed: handleClick,
      child: Text(stationName),
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return '{ name: $stationName, activity: $activity, error: $error }';
  }
}
