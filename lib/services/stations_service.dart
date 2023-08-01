library;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../components/station.dart';
import '../utils/set_timeout.dart';
import '../models/station_model.dart';
import '../system/notifier.dart' as notifier;

// This service fetches weather station data from the internet at 10 minute
// intervals and updates the subscribed StationModel with new data.

/// A list of weather stations and their codes. The codes are used to parse station data from JavaScript.
const _stationCodes = [
  (name: 'Kevo', code: 'KEV'),
  (name: 'Kilpisjärvi', code: 'KIL'),
  (name: 'Ivalo', code: 'IVA'),
  (name: 'Muonio', code: 'MUO'),
  (name: 'Sodankylä', code: 'SOD'),
  (name: 'Pello', code: 'PEL'),
  (name: 'Ranua', code: 'RAN'),
  (name: 'Oulujärvi', code: 'OUJ'),
  (name: 'Mekrijärvi', code: 'MEK'),
  (name: 'Hankasalmi', code: 'HAN'),
  (name: 'Nurmijärvi', code: 'NUR'),
  (name: 'Tartto', code: 'TAR'),
];

/// URL of the data source.
const String _url = 'https://www.ilmatieteenlaitos.fi/revontulet-ja-avaruussaa';
/// Data cache containing the names, activity values and error states of weather stations.
final List<Station> _stations = []; 
/// Service must be initialized before first use, set to true after _fetchData().
bool _initialized = false; 
/// _model notifies listeners in MainView of changes in station data and the update timer.
StationModel _model = StationModel(); 

/// Subscribes a StationModel to receive data updates. This service will call _model.setCurrentStation()
/// and _model.setTimer().
subscribe(StationModel model) {
  _model = model;

  _initializeService();
}

/// This is used as a callback function given to a grid element in StationsView. When the user clicks on
/// such an element this function calls _model.setCurrentStation() to propagate the change to the main view.
setStation(String stationName) async {
  await _initializeService();

  _model.setCurrentStation(_stations.firstWhere(
    (element) => element.stationName == stationName,
    orElse: () => _errorStation(stationName, '$stationName station not found!')
  ));
}

/// Used by StationsView to populate the grid for selecting a station.
getStations() async {
  await _initializeService();

  return _stations;
}

/// Calculates the number of seconds until the next time _fetchData() should be called.
int _secondsToNextUpdate() {
  var time = DateTime.now();
  // Calculate how many minutes to the next time minutes are divisible by 10 (ie. 00, 10, 20 etc.).
  int offsetMinutes = 10 - (time.minute % 10 == 0 ? 10 : time.minute % 10);
  // How many seconds to a full minute? By adding this to offsetMinutes we give the data source
  // a 1 minute buffer to update.
  int offsetSeconds = 60 - time.second;
  // Time in seconds until the clock is 11 minutes past, 21 past, etc.
  return offsetMinutes * 60 + offsetSeconds;
}

_initializeService() async {
  // Do nothing if service is already initialized.
  if (_initialized) {
    return;
  }

  int secondsToNextUpdate = _secondsToNextUpdate();

  // Start update timers.
  debugPrint('STARTING FIRST TIMER');
  setTimeout(secondsToNextUpdate, () async {
    // Here time is about 1 minute after assumed site update. Now we set a timer that will
    // run through the lifetime of the program and call fetchData() every 10 minutes.
    debugPrint('STARTING REPEATING TIMER');
    setRepeatingTimeout(10 * 60, (timer) async {
      debugPrint('EXECUTING REPEATING TIMER');
      await _fetchData();
      _model.setTimer(10 * 60);
    });

    // Fetch data at the calculated time, after this fetching will happen at 10 minute intervals.
    await _fetchData();
    _model.setTimer(10 * 60);
  });

  // After setting timers, fetch data and initialize class variables.
  // StationsService is ready to serve data to callers after this.
  _model.setTimer(secondsToNextUpdate); // NOTE: Changed place with fetchData().
  await _fetchData();
}

_fetchData() async {
  debugPrint('IN FETCHDATA');

  try {
    String data;
    var response = await http.get(
      Uri.parse(_url),
      headers: {
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
      },
    );

    switch (response.statusCode) {
      case 200:
        data = response.body;
        break;

      default:
        throw Exception(response.reasonPhrase);
    }

    _stations.clear(); // Clear cache before repopulating it.

    // Parse activity data for each station and add that data to _stations.
    for (var station in _stationCodes) {
      String splitString = '${station.code}\\":{\\"dataSeries\\":'; // Data starts after this string.
      List<String> splitData = data.split(splitString);

      // If data for station was not found.
      if (splitData.length < 2) {
        _stations.add(_errorStation(station.name, 'Aseman ${station.name} havainnot ovat tilapäisesti pois käytöstä.'));
        continue;
      }

      splitData = splitData[1].split('}');
      String stationData = splitData[0];
      var deSerializedData = json.decode(stationData);
      var lastData =
          deSerializedData[deSerializedData.length - 1]; // Latest data point.

      // If data for station is valid add it to stations list.
      if (lastData.length == 2 && lastData[1] is double) {
        _stations.add(Station(stationName: station.name, callback: setStation, activity: lastData[1]));
      }
      // Sometimes current activity data for a station is null.
      else {
        // Try the previous data point.
        lastData = deSerializedData[deSerializedData.length - 2];

        if (lastData.length == 2 && lastData[1] is double) {
          _stations
              .add(Station(stationName: station.name, callback: setStation, activity: lastData[1]));
        } else {
          _stations.add(_errorStation(station.name, 'Aseman ${station.name} tiedot eivät tilapäisesti ole saatavilla, yritä myöhemmin uudelleen.'));
        }
      }
    }
  } catch (e) {
    debugPrint('ERROR: $e');
    _model.setCurrentStation(_errorStation('Error', '$e'));
    return;
  }

  for (var i in _stations) {
    debugPrint('STATION: ${i.toString()}');
  }

  // If the service has not yet been initialized, set Nurmijärvi as the default station.
  if (!_initialized) {
    _model.setCurrentStation(_stations[10]);
  }
  // Else find the fresh data for the current station from _stations and update the model.
  else {
    Station currentStation = _stations.firstWhere((element) => element.stationName == _model.name);
    _model.setCurrentStation(currentStation);

    // Send notification if appropriate (notifier checks conditions).
    notifier.sendNotification(currentStation.stationName, currentStation.activity);
  }

  _initialized = true;
}

Station _errorStation(String name, String error) {
  return Station(stationName: name, callback: setStation, error: error);
}
