// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncSettingsHash() => r'ea130aa08039391ef0a91d13fb1843bdc070b447';

/// AsyncNotifier which exposes app settings to UI components and saves changes
/// to SharedPreferences by calling the user_settings library. Generates an
/// AsyncNotifierProvider for accessing the Notifier.
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
