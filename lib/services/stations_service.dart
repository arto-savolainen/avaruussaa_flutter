import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/station.dart';

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
  static String url = 'https://www.ilmatieteenlaitos.fi/revontulet-ja-avaruussaa';
  static List<Station> _stations = [];
  static Station _currentStation = Station('', 0);
  static bool _initialized = false;
  
  StationsService._(); // Private constructor for static class

  static setStationsList(List<Station> newStations) { // Currently unused
    _stations = newStations;
  }

  static setStation(String stationName) async {
    await _checkIfInitialized();

    _currentStation = _stations.firstWhere((element) => element.name == stationName, orElse: () => _errorStation('$stationName station not found!'));
  }

  static getStations() async {
    await _checkIfInitialized();

    return _stations;
  }

  static getStation() async { // Currently unused
    await _checkIfInitialized();

    return _currentStation;
  }

  static getName() async {
    await _checkIfInitialized();

    return _currentStation.name;
  }

  static getActivity() async {
    await _checkIfInitialized();

    return _currentStation.activity;
  }

  static _checkIfInitialized() async {
    if (!_initialized) {
      await _fetchData();
    }
  }

  static _fetchData() async {
    try {
      var response = await http.get(Uri.parse(url));
      String data;

      switch (response.statusCode) {
        case 200:
          data = response.body;
        default:
          throw Exception(response.reasonPhrase);
      }

      // Parse activity data for each station and add that data to _stations
      for (var station in _stationCodes) {
        String splitString = '${station.code}\\":{\\"dataSeries\\":'; // Data starts after this string
        List<String> splitData = data.split(splitString);
        
        // If data for station was not found 
        if (splitData.length < 2) {
          _stations.add(_errorStation('Aseman ${station.name} havainnot ovat tilapäisesti pois käytöstä.'));
          continue;
        }

        splitData = splitData[1].split('}');
        String stationData = splitData[0];
        var jsonData = json.decode(stationData);
        var lastItem = jsonData[jsonData.length -1];

        // If data for station is valid add it to stations list
        if (lastItem.length == 2 && lastItem[1] is double) {
          _stations.add(Station(station.name, lastItem[1]));
        }
        // Sometimes current activity data for a station is null
        else {
          _stations.add(_errorStation('Aseman ${station.name} data ei tilapäisesti ole saatavilla, yritä myöhemmin uudelleen.'));
        }
      }
    } 
    catch (e) {
      print('ERROR: $e');
      _currentStation = _errorStation('Error: $e');
      return;
    }
  
    assert(_stations.length == 12, 'INCORRECT LENGTH OF _stations');

    // If _currentStation is not yet initialized, set Nurmijärvi as default station
    if (_currentStation.name == '') {
      _currentStation = _stations[10]; 
    }
    
    _initialized = true;
  }

  static Station _errorStation(String error) {
    return Station(error, 0);
  }
}

