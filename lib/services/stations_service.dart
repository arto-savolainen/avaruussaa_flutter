import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import '../components/station.dart';

class StationsService extends Model {
  static final StationsService _instance = StationsService._internal();
  static String url = 'https://www.ilmatieteenlaitos.fi/revontulet-ja-avaruussaa';
  static List<Station> _stations = [];
  static Station _currentStation = Station('', 0);
  static bool _initialized = false;
  
  factory StationsService() => _instance;

  StationsService._internal();

  static setStationsList(List<Station> newStations) {
    _stations = newStations;
  }

  static setStation(Station newStation) {
    _currentStation = newStation;
  }

  static getStations() async {
    if (!_initialized) {
      await _fetchData();
    }

    return _stations;
  }

  static getCurrent() async {
    if (!_initialized) {
      await _fetchData();
    }

    return _currentStation;
  }

  static _fetchData() async {
    var response = await http.get(Uri.parse(url));
  
    final List<Station> tempStationList = [
      Station('station_1', 0.420),
      Station('station_2', 6),
      Station('station_3', 0.001)
    ];

    _stations = tempStationList;
    _currentStation = tempStationList.first;
    _initialized = true;
  }
}

