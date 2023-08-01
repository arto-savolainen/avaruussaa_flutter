import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/settings_provider.dart';
import '../components/titlebar.dart';
import '../components/footer.dart';
import '../components/labeled_switch.dart';
import '../components/labeled_number_input.dart';

/// Displays controls for changing user settings, such as a notification toggle.
class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSettings = ref.watch(asyncSettingsProvider);

    return asyncSettings.when(
      loading: () => const Text('Ladataan...'),
      error: (err, stack) => Text('Virhe: $err'),
      data: (settings) {
        const titleBar = TitleBar(viewId: 'settings');

        final thresholdRow = LabeledNumberInput(
          labelText: 'Notifikaatiokynnys (nT/s): ',
          value: settings.notificationThreshold,
          callback: ref.read(asyncSettingsProvider.notifier).setNotificationsThreshold,
        );

        final intervalRow = LabeledNumberInput(
          labelText: 'Notifikaatioväli (h): ',
          value: settings.notificationInterval,
          callback: ref.read(asyncSettingsProvider.notifier).setNotificationsInterval,
        );

        final notificationsRow = LabeledSwitch(
          labelText: 'Notifikaatiot',
          value: settings.notificationsEnabled,
          callback: ref.read(asyncSettingsProvider.notifier).setNotificationsEnabled,
        );

        final minimizeRow = LabeledSwitch(
          labelText: 'Minimoi ilmaisinalueelle',
          value: settings.minimizeToTray,
          callback: ref.read(asyncSettingsProvider.notifier).setMinimizeToTray,
        );

        final settingsView = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleBar,
            thresholdRow,
            intervalRow,
            notificationsRow,
            minimizeRow,
          ],
        );

        return Scaffold(
          body: SafeArea(child: settingsView),
          bottomSheet: const Footer(),
        );
      },
    );
  }
}
