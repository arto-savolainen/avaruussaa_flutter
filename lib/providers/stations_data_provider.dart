import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/stations_data_model.dart';
import '../components/station.dart';
import '../storage/user_settings.dart' as user_settings;
import '../utils/set_timeout.dart';
import 'notification_manager_provider.dart';

part 'stations_data_provider.g.dart';

/// AsyncNotifier which fetches weather station data from the web and exposes
/// that data to UI components. Generates an AsyncNotifierProvider for
/// accessing the Notifier.
@riverpod
class AsyncStationsData extends _$AsyncStationsData {
  /// A list of weather stations and their codes. The codes are used to parse
  /// station data from HTML/JavaScript fetched from the data source.
  static const _stationCodes = [
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
  /// URL of the data source queried in _fetchData().
  static const String _url = 'https://www.ilmatieteenlaitos.fi/revontulet-ja-avaruussaa';
  Timer? _timer;

  /// Changes state.value.currentStation to [selectedStation]. Used as the callback
  /// function when the user clicks on a station's name in the stations view.
  void setStation(Station selectedStation) {
    // setStation() won't be called unless state is populated with data, so we
    // can reasonably expect that state.value won't be null.
    state = _buildNewState(state.value!.stations, selectedStation);

    // Save the choice to SharedPreferences.
    user_settings.setCurrentStation(selectedStation.name);
  }

  /// Makes an HTTP request to [_url] and parses the response body to extract
  /// weather station data, and updates Notifier state with that data. Calls
  /// notifier.sendNotification() after update.
  Future<StationsData> _fetchData() async {
    List<Station> stationList = [];
    Station currentStation;

    try {
      String responseBody;
      var response = await http.get(
        Uri.parse(_url),
        headers: {
          'Cache-Control': 'no-cache',
          'Expires': '0',
        },
      );

      switch (response.statusCode) {
        case 200:
          responseBody = response.body;
          break;

        default:
          throw Exception(response.reasonPhrase);
      }

      stationList = _parseDataFromResponse(responseBody);
    } 
    catch (e) {
      // In case of network / json error, set currentStation.error and update state.
      // This shows the error in the main view in place of station activity.
      debugPrint('ERROR: $e');
      currentStation = _errorStation('Virhe', '$e');
      state = _buildNewState(stationList, currentStation);
      return state.value!;
    }

    for (var i in stationList) {
      debugPrint('STATION: ${i.toString()}');
    }

    // Find the data for the current station from stationList and update state.
    currentStation = _findStation(stationList, state.value!.currentStation.name);
    state = _buildNewState(stationList, currentStation);

    // Send notification if appropriate (NotificationManager checks conditions).
    ref.read(notificationManagerProvider.notifier).sendNotification(currentStation.name, currentStation.activity);

    return StationsData(stations: stationList, currentStation: currentStation, timerString: _buildTimerString());
  }

  AsyncValue<StationsData> _buildNewState(List<Station> stations, Station currentStation) {
    return AsyncValue.data(StationsData(stations: stations, currentStation: currentStation, timerString: _buildTimerString()));
  }

  /// Separates the JavaScript arrays containing the data for each station from
  /// the HTML/JavaScript response and decodes them into iterable objects. The
  /// latest entry in the iterable is the activity value which is used to construct a
  /// Station that is then added to a list, which is returned after all stations have been added.
  List<Station> _parseDataFromResponse(String responseBody) {
    List<Station> stationList = [];
    // Parse activity data for each station and add that data to stationList.
    for (var station in _stationCodes) {
      String delimiter = '${station.code}\\":{\\"dataSeries\\":'; // Data starts after this string.
      List<String> splitData = responseBody.split(delimiter);

      // If data for station was not found.
      if (splitData.length < 2) {
        stationList.add(_errorStation(station.name,
          'Aseman ${station.name} havainnot ovat tilapäisesti pois käytöstä.',
        ));

        continue;
      }

      splitData = splitData[1].split('}');
      String stationDataString = splitData[0];
      var deSerializedData = json.decode(stationDataString);
      var latestData = deSerializedData[deSerializedData.length - 1]; // Latest data point.

      // If the data for the station is valid add it to stationList. The first
      // element of latestData is time information which we don't use, second
      // element contains the activity data we want.
      if (latestData.length == 2 && latestData[1] is double) {
        stationList.add(Station(
          name: station.name,
          callback: setStation,
          activity: latestData[1],
        ));
      }
      // Sometimes current activity data for a station is null.
      else {
        // Try the previous data point.
        latestData = deSerializedData[deSerializedData.length - 2];

        if (latestData.length == 2 && latestData[1] is double) {
          stationList.add(Station(
            name: station.name,
            callback: setStation,
            activity: latestData[1],
          ));
        } 
        else {
          stationList.add(_errorStation(station.name,
            'Aseman ${station.name} tiedot eivät tilapäisesti ole saatavilla, yritä myöhemmin uudelleen.',
          ));
        }
      }
    }

    return stationList;
  }

  /// Takes a List of Stations and finds the Station with name [stationName].
  Station _findStation(List<Station> stations, String stationName) {
    Station currentStation = stations.firstWhere((element) => element.name == stationName);

    return currentStation;
  }

  /// Returns a Station object with the error property set to [error]. Sometimes 
  /// a station's data is temporarily unavailable, error stations are used to 
  /// convey that information to the user.
  Station _errorStation(String name, String error) {
    return Station(name: name, callback: setStation, error: error);
  }

  /// Calculates the number of seconds until the next time _fetchData() should be called.
  /// That time is specified as time.minute % 10 == 1 && time.second == 0, that is,
  /// 1 minute past the hour, 11 min past, 21 min, and so on.
  int _secondsToNextUpdate() {
    DateTime time = DateTime.now();

    // Since the offsets below never sum to zero, check for it specifically.
    if (time.minute % 10 == 1 && time.second == 0) {
      return 0;
    }
    
    // Calculate how many minutes to the next time minutes are divisible by 10 (ie. 00, 10, 20 etc.).
    int offsetMinutes = 10 - (time.minute % 10 == 0 ? 10 : time.minute % 10);
    // How many seconds to a full minute? By adding this to offsetMinutes we give the data source
    // a 1 minute buffer to update.
    int offsetSeconds = 60 - time.second;

    // Return the total time left in seconds.
    return offsetMinutes * 60 + offsetSeconds;
  }

  /// Returns the time remaining until the next data update as a String in mm:ss format.
  String _buildTimerString() {
    int secondsToNextUpdate = _secondsToNextUpdate();
    int minutes = (secondsToNextUpdate / 60).floor();
    int seconds = secondsToNextUpdate - minutes * 60;
    String minutesString = minutes < 10 ? '0$minutes' : '$minutes';
    String secondsString = seconds < 10 ? '0$seconds' : '$seconds';

    return '$minutesString:$secondsString';
  }

  /// Calls _buildNewAsyncState() in order to update [state.value.timerString].
  /// Checks if new data should be fetched and calls _fetchData().
  void _updateTimerString() async {
    state = _buildNewState(state.value!.stations, state.value!.currentStation);

    // Trigger data fetching  when the timer reaches 0.
    if (state.value!.timerString == '00:00') {
      await _fetchData();
    }
  }

  /// Starts a repeating timer that updates [state.value.timerString] at one second intervals. 
  void _startTimer() {
    _timer?.cancel();
    _updateTimerString(); // First UI update since the timer doesn't fire immediately.
    _timer = setRepeatingTimeout(1, (timer) => _updateTimerString());
  }

  /// Initializes the state object so we can access it in other functions safely.
  Future<void> _initState() async {
    String currentStationName = await user_settings.getCurrentStation();
    // Construct a temporary Station object and save it in state so we can display the
    // station's name in the main view even before remote data has been fetched.
    Station currentStation = Station(
      name: currentStationName,
      callback: setStation,
    );

    state = _buildNewState([], currentStation);
  }

  @override
  FutureOr<StationsData> build() async {
    ref.onDispose(() {
      _timer?.cancel();
    });

    await _initState();
    _startTimer();

    return _fetchData();
  }
}