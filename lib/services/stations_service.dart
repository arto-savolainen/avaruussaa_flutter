import '../components/station.dart';

class StationsService {
  // This is a singleton class that holds a single instance of itself
  static final StationsService _instance = StationsService._internal();
  late List<Station> _stations;
  late Station _currentStation;
  
  // Returns the single instance when instantiated by outside users
  factory StationsService() => _instance;

  StationsService._internal() {
    // TODO fetch from web here
    final List<Station> tempStationList = [
      Station('station_1', 0.420),
      Station('station_2', 6),
      Station('station_3', 0.001)
    ];

    _stations = tempStationList;
    _currentStation = tempStationList.first;
  }

  setStationsList(List<Station> newStations) {
    _stations = newStations;
  }

  setStation(Station newStation) {
    _currentStation = newStation;
  }

  getStations() {
    return _stations;
  }

  getCurrent() {
    return _currentStation;
  }
}