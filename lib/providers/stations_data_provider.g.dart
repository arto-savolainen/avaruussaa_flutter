// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stations_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncStationsDataHash() => r'dcc2d014ba81f5907bd54256751be1e0be66233d';

/// AsyncNotifier which fetches weather station data from the web and exposes
/// that data to UI components. Generates an AsyncNotifierProvider for
/// accessing the Notifier.
///
/// Copied from [AsyncStationsData].
@ProviderFor(AsyncStationsData)
final asyncStationsDataProvider =
    AutoDisposeAsyncNotifierProvider<AsyncStationsData, StationsData>.internal(
  AsyncStationsData.new,
  name: r'asyncStationsDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncStationsDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncStationsData = AutoDisposeAsyncNotifier<StationsData>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
