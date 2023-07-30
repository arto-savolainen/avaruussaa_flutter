import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import '../components/titlebar.dart';
import '../components/footer.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSettings = ref.watch(asyncSettingsProvider);

    return asyncSettings.when(
      loading: () => const Text('Ladataan...'),
      error: (err, stack) => Text('Virhe: $err'),
      data: (settings) {
        const titleBar = TitleBar('settings');

        final notificationSwitch = SizedBox(
          width: 46,
          height: 26,
          child: Switch(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              inactiveThumbColor: Theme.of(context).primaryColor,
              inactiveTrackColor: Colors.blueGrey,
              value: settings.notificationsEnabled,
              onChanged: (value) => ref
                  .read(asyncSettingsProvider.notifier)
                  .setNotificationsEnabled(value)),
        );
        final notificationRow = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Notifikaatiot'),
            notificationSwitch,
          ],
        );

        final minimizeSwitch = SizedBox(
          width: 46,
          height: 26,
          child: Switch(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              inactiveThumbColor: Theme.of(context).primaryColor,
              inactiveTrackColor: Colors.blueGrey,
              value: settings.minimizeToTray,
              onChanged: (value) => ref
                  .read(asyncSettingsProvider.notifier)
                  .setMinimizeToTray(value)),
        );
        final minimizeRow = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Minimoi ilmaisinalueelle'),
            minimizeSwitch,
          ],
        );

        final settingsView = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleBar,
            notificationRow,
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
