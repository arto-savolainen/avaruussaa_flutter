// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stations_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StationsData {
  ///Data cache containing the names, activity values and error states of weather stations.
  List<Station> get stations =>
      throw _privateConstructorUsedError; // Data for the currently selected station which is shown in the main view.
  Station get currentStation =>
      throw _privateConstructorUsedError; // Used to display time remaining to the next data update in the main view.
  String get timerString => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StationsDataCopyWith<StationsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationsDataCopyWith<$Res> {
  factory $StationsDataCopyWith(
          StationsData value, $Res Function(StationsData) then) =
      _$StationsDataCopyWithImpl<$Res, StationsData>;
  @useResult
  $Res call(
      {List<Station> stations, Station currentStation, String timerString});
}

/// @nodoc
class _$StationsDataCopyWithImpl<$Res, $Val extends StationsData>
    implements $StationsDataCopyWith<$Res> {
  _$StationsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stations = null,
    Object? currentStation = null,
    Object? timerString = null,
  }) {
    return _then(_value.copyWith(
      stations: null == stations
          ? _value.stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<Station>,
      currentStation: null == currentStation
          ? _value.currentStation
          : currentStation // ignore: cast_nullable_to_non_nullable
              as Station,
      timerString: null == timerString
          ? _value.timerString
          : timerString // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StationsDataCopyWith<$Res>
    implements $StationsDataCopyWith<$Res> {
  factory _$$_StationsDataCopyWith(
          _$_StationsData value, $Res Function(_$_StationsData) then) =
      __$$_StationsDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Station> stations, Station currentStation, String timerString});
}

/// @nodoc
class __$$_StationsDataCopyWithImpl<$Res>
    extends _$StationsDataCopyWithImpl<$Res, _$_StationsData>
    implements _$$_StationsDataCopyWith<$Res> {
  __$$_StationsDataCopyWithImpl(
      _$_StationsData _value, $Res Function(_$_StationsData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stations = null,
    Object? currentStation = null,
    Object? timerString = null,
  }) {
    return _then(_$_StationsData(
      stations: null == stations
          ? _value._stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<Station>,
      currentStation: null == currentStation
          ? _value.currentStation
          : currentStation // ignore: cast_nullable_to_non_nullable
              as Station,
      timerString: null == timerString
          ? _value.timerString
          : timerString // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_StationsData implements _StationsData {
  _$_StationsData(
      {required final List<Station> stations,
      required this.currentStation,
      required this.timerString})
      : _stations = stations;

  ///Data cache containing the names, activity values and error states of weather stations.
  final List<Station> _stations;

  ///Data cache containing the names, activity values and error states of weather stations.
  @override
  List<Station> get stations {
    if (_stations is EqualUnmodifiableListView) return _stations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stations);
  }

// Data for the currently selected station which is shown in the main view.
  @override
  final Station currentStation;
// Used to display time remaining to the next data update in the main view.
  @override
  final String timerString;

  @override
  String toString() {
    return 'StationsData(stations: $stations, currentStation: $currentStation, timerString: $timerString)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StationsData &&
            const DeepCollectionEquality().equals(other._stations, _stations) &&
            (identical(other.currentStation, currentStation) ||
                other.currentStation == currentStation) &&
            (identical(other.timerString, timerString) ||
                other.timerString == timerString));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_stations),
      currentStation,
      timerString);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StationsDataCopyWith<_$_StationsData> get copyWith =>
      __$$_StationsDataCopyWithImpl<_$_StationsData>(this, _$identity);
}

abstract class _StationsData implements StationsData {
  factory _StationsData(
      {required final List<Station> stations,
      required final Station currentStation,
      required final String timerString}) = _$_StationsData;

  @override

  ///Data cache containing the names, activity values and error states of weather stations.
  List<Station> get stations;
  @override // Data for the currently selected station which is shown in the main view.
  Station get currentStation;
  @override // Used to display time remaining to the next data update in the main view.
  String get timerString;
  @override
  @JsonKey(ignore: true)
  _$$_StationsDataCopyWith<_$_StationsData> get copyWith =>
      throw _privateConstructorUsedError;
}
