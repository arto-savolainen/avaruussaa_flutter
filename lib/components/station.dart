import 'package:flutter/material.dart';

/// This class represents a weather station. It is also a Widget which builds
/// a TextButton that calls a given [callback] function and pops to the
/// previous view when pressed. Widgets created by this class are used by
/// StationsView to allow the user to select a station's data for viewing.
class Station extends StatelessWidget {
  const Station({
    required this.name,
    required this.callback,
    this.activity = 0,
    this.error = '',
    super.key,
  });

  final String name;
  final double activity; // Current activity level measured at station.
  final String error; // This is set if no valid data for the station could be retrieved.
  final Function callback; // This is called when the user presses the TextButton returned by build.

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // The callback function updates app state to show the selected station.
        callback(this);
        // Then we return to the main view.
        Navigator.pop(context);
      },
      child: Text(name),
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return '{ name: $name, activity: $activity, error: $error }';
  }
}
