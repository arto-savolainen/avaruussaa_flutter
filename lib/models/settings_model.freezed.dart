// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Settings {
  double get notificationThreshold => throw _privateConstructorUsedError;
  double get notificationInterval => throw _privateConstructorUsedError;
  bool get notificationsEnabled => throw _privateConstructorUsedError;
  bool get minimizeToTray => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsCopyWith<Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res, Settings>;
  @useResult
  $Res call(
      {double notificationThreshold,
      double notificationInterval,
      bool notificationsEnabled,
      bool minimizeToTray});
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res, $Val extends Settings>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationThreshold = null,
    Object? notificationInterval = null,
    Object? notificationsEnabled = null,
    Object? minimizeToTray = null,
  }) {
    return _then(_value.copyWith(
      notificationThreshold: null == notificationThreshold
          ? _value.notificationThreshold
          : notificationThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      notificationInterval: null == notificationInterval
          ? _value.notificationInterval
          : notificationInterval // ignore: cast_nullable_to_non_nullable
              as double,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      minimizeToTray: null == minimizeToTray
          ? _value.minimizeToTray
          : minimizeToTray // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$$_SettingsCopyWith(
          _$_Settings value, $Res Function(_$_Settings) then) =
      __$$_SettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double notificationThreshold,
      double notificationInterval,
      bool notificationsEnabled,
      bool minimizeToTray});
}

/// @nodoc
class __$$_SettingsCopyWithImpl<$Res>
    extends _$SettingsCopyWithImpl<$Res, _$_Settings>
    implements _$$_SettingsCopyWith<$Res> {
  __$$_SettingsCopyWithImpl(
      _$_Settings _value, $Res Function(_$_Settings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationThreshold = null,
    Object? notificationInterval = null,
    Object? notificationsEnabled = null,
    Object? minimizeToTray = null,
  }) {
    return _then(_$_Settings(
      notificationThreshold: null == notificationThreshold
          ? _value.notificationThreshold
          : notificationThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      notificationInterval: null == notificationInterval
          ? _value.notificationInterval
          : notificationInterval // ignore: cast_nullable_to_non_nullable
              as double,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      minimizeToTray: null == minimizeToTray
          ? _value.minimizeToTray
          : minimizeToTray // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Settings implements _Settings {
  _$_Settings(
      {required this.notificationThreshold,
      required this.notificationInterval,
      required this.notificationsEnabled,
      required this.minimizeToTray});

  @override
  final double notificationThreshold;
  @override
  final double notificationInterval;
  @override
  final bool notificationsEnabled;
  @override
  final bool minimizeToTray;

  @override
  String toString() {
    return 'Settings(notificationThreshold: $notificationThreshold, notificationInterval: $notificationInterval, notificationsEnabled: $notificationsEnabled, minimizeToTray: $minimizeToTray)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Settings &&
            (identical(other.notificationThreshold, notificationThreshold) ||
                other.notificationThreshold == notificationThreshold) &&
            (identical(other.notificationInterval, notificationInterval) ||
                other.notificationInterval == notificationInterval) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.minimizeToTray, minimizeToTray) ||
                other.minimizeToTray == minimizeToTray));
  }

  @override
  int get hashCode => Object.hash(runtimeType, notificationThreshold,
      notificationInterval, notificationsEnabled, minimizeToTray);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingsCopyWith<_$_Settings> get copyWith =>
      __$$_SettingsCopyWithImpl<_$_Settings>(this, _$identity);
}

abstract class _Settings implements Settings {
  factory _Settings(
      {required final double notificationThreshold,
      required final double notificationInterval,
      required final bool notificationsEnabled,
      required final bool minimizeToTray}) = _$_Settings;

  @override
  double get notificationThreshold;
  @override
  double get notificationInterval;
  @override
  bool get notificationsEnabled;
  @override
  bool get minimizeToTray;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsCopyWith<_$_Settings> get copyWith =>
      throw _privateConstructorUsedError;
}
