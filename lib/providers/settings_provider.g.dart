// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncSettingsHash() => r'ce00d31cd12d9a99c0259415a314c959043e8406';

/// AsyncNotifier which exposes app settings. Generates an AsyncNotifierProvider that
/// provides information to UI components and saves changes by calling user_settings,
/// which writes the settings to SharedPreferences.
///
/// Copied from [AsyncSettings].
@ProviderFor(AsyncSettings)
final asyncSettingsProvider =
    AutoDisposeAsyncNotifierProvider<AsyncSettings, Settings>.internal(
  AsyncSettings.new,
  name: r'asyncSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncSettings = AutoDisposeAsyncNotifier<Settings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
