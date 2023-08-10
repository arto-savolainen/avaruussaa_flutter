// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncSettingsHash() => r'daa5f9ce99dc4ebfc1cc8059568f534e66f407bb';

/// AsyncNotifier which exposes app settings to UI components and saves changes
/// to SharedPreferences by calling the user_settings library. Generates an
/// AsyncNotifierProvider for accessing the Notifier.
///
/// Copied from [AsyncSettings].
@ProviderFor(AsyncSettings)
final asyncSettingsProvider =
    AsyncNotifierProvider<AsyncSettings, Settings>.internal(
  AsyncSettings.new,
  name: r'asyncSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncSettings = AsyncNotifier<Settings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
