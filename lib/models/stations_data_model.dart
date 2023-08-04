import 'package:freezed_annotation/freezed_annotation.dart';

import '../components/station.dart';

part 'stations_data_model.freezed.dart';

/// Data model for the AsyncStationsData AsyncNotifier.
@freezed
class StationsData with _$StationsData {
  factory StationsData({  
    ///Data cache containing the names, activity values and error states of weather stations.
    required List<Station> stations,
    // Data for the currently selected station which is shown in the main view.
    required Station currentStation,
    // Used to display time remaining to the next data update in the main view.
    required String timerString,
  }) = _StationsData;
}