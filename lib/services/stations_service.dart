// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_notifier/local_notifier.dart';
import '../components/station.dart';
import '../util/set_timeout.dart';
import '../models/station_model.dart';

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

class StationsService {
  static const String url = 'https://www.ilmatieteenlaitos.fi/revontulet-ja-avaruussaa';
  static final List<Station> _stations = [];
  static bool _initialized = false;
  static StationModel _model = StationModel();
  static double _notificationTreshold = 0.4;

  StationsService._(); // Private constructor for static class

  static subscribe(StationModel model) {
    _model = model;

    _checkIfInitialized();
  }

  static setStation(String stationName) async {
    await _checkIfInitialized();

    _model.updateCurrentStation(_stations.firstWhere(
        (element) => element.name == stationName,
        orElse: () => _errorStation(stationName, '$stationName station not found!')));
  }

  // Used by StationsView to populate the grid for selecting a station
  static getStations() async {
    await _checkIfInitialized();

    return _stations;
  }

  static setNotificationTreshold(double treshold) {
    _notificationTreshold = treshold >= 0 ? treshold : 0;
  }

  static _checkIfInitialized() async {
    // Do nothing if service is already initialized
    if (_initialized) {
      return;
    }

    // Start update timers upon first use of class
    var time = DateTime.now();
    // Calculate how many minutes to the next time minutes are divisible by 10 (ie. 00, 10, 20 etc.)
    var offsetMinutes = 10 - (time.minute % 10 == 0 ? 10 : time.minute % 10);
    // How many seconds to a full minute? By adding this to offsetMinutes we give the site a 1 minute buffer to update
    var offsetSeconds = 60 - time.second;
    // Time in econds until the clock is 11 minutes past, 21 past, etc.
    var secondsToNextUpdate = offsetMinutes * 60 + offsetSeconds;

    print('STARTING FIRST TIMER');
    setTimeout(secondsToNextUpdate, () async {
      // Here time is about 1 minute after assumed site update. Now we set a timer that will run through the lifetime of the program
      // and call the data fetch function every 10 minutes.
      print('STARTING REPEATING TIMER');
      setRepeatingTimeout(10 * 60, (timer) async {
        print('EXECUTING REPEATING TIMER');
        await _fetchData();
        _model.setTimer(10 * 60);
      });

      // Fetch data at the calculated time, after this fetching will happen at 10 minute intervals
      await _fetchData();
      _model.setTimer(10 * 60);
    });

    // After setting timers, fetch data and initialize class variables
    // StationsService is ready to serve data to callers after this
    _model.setTimer(secondsToNextUpdate); // NOTE: Changed places of this and fetchData
    await _fetchData();
    // _model.setTimer(secondsToNextUpdate);
  }

  static _fetchData() async {
    print('IN FETCHDATA');
    _stations.clear();

    try {
      String data;
      var response = await http.get(
        Uri.parse(url),
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

      // Parse activity data for each station and add that data to _stations
      for (var station in _stationCodes) {
        String splitString =
            '${station.code}\\":{\\"dataSeries\\":'; // Data starts after this string
        List<String> splitData = data.split(splitString);

        // If data for station was not found
        if (splitData.length < 2) {
          _stations.add(_errorStation(station.name,
              'Aseman ${station.name} havainnot ovat tilapäisesti pois käytöstä.'));
          continue;
        }

        splitData = splitData[1].split('}');
        String stationData = splitData[0];
        var deSerializedData = json.decode(stationData);
        var lastData =
            deSerializedData[deSerializedData.length - 1]; // Latest data point

        // If data for station is valid add it to stations list
        if (lastData.length == 2 && lastData[1] is double) {
          _stations.add(Station(station.name, StationsService.setStation,
              activity: lastData[1]));
        }
        // Sometimes current activity data for a station is null
        else {
          // Try the previous data point
          lastData = deSerializedData[deSerializedData.length - 2];

          if (lastData.length == 2 && lastData[1] is double) {
            _stations.add(Station(station.name, StationsService.setStation,
                activity: lastData[1]));
          } 
          else {
            _stations.add(_errorStation(station.name, 'Aseman ${station.name} tiedot eivät tilapäisesti ole saatavilla, yritä myöhemmin uudelleen.'));
          }
        }
      }
    } catch (e) {
      print('ERROR: $e');
      _model.updateCurrentStation(_errorStation('Error', '$e'));
      return;
    }

    assert(_stations.length == 12, 'INCORRECT LENGTH OF _stations');

    for (var i in _stations) {
      print('STATION: ${i.toString()}');
    }

    // If the model is not yet initialized, set Nurmijärvi as default station
    if (!_initialized) {
      _model.updateCurrentStation(_stations[10]);
    }
    // Else find the fresh data for the current station from _stations and update the model
    else {
      Station currentStation = _stations.firstWhere((element) => element.name == _model.name);
      _model.updateCurrentStation(currentStation);

      // Show notification if activity level is at or above treshold
      if (currentStation.activity >= _notificationTreshold) {
        _showNotification(currentStation);
      }
    }

    _initialized = true;
  }

  static _showNotification(Station currentStation) {
    LocalNotification notification = LocalNotification(
      title: "Revontulet todennäköisiä",
      body:
          "Magneettinen aktiivisuus @ ${currentStation.name}: ${currentStation.activity} nT/s",
    );

    notification.show();
  }

  static Station _errorStation(String name, String error) {
    return Station(name, StationsService.setStation, error: error);
  }
}
