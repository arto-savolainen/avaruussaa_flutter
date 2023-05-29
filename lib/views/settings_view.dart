import 'package:flutter/material.dart';
import '../components/titlebar.dart';
import '../storage/user_settings.dart';
import '../components/footer.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  SettingsViewState createState() => SettingsViewState();
}

class SettingsViewState extends State {
  bool _notificationsEnabled = true;

  @override
  initState() {
    super.initState();
    _loadSettings();
  }

  _loadSettings() async {
    bool notificationsEnabled = await UserSettings.getNotificationsEnabled();

    setState(() {
      _notificationsEnabled = notificationsEnabled;
    });
  }

  _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });

    UserSettings.setNotificationsEnabled(_notificationsEnabled);
  }

  @override
  Widget build(BuildContext context) {
    const titleBar = TitleBar('settings');

    final notificationSwitch = SizedBox(
      width: 46,
      height: 26,
      child: Switch(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        inactiveThumbColor: Theme.of(context).primaryColor,
        inactiveTrackColor: Colors.blueGrey,
        value: _notificationsEnabled,
        onChanged: _toggleNotifications,
      ),
    );
    final notificationRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Notifikaatiot'),
        notificationSwitch,
      ],
    );

    final settingsView = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        titleBar,
        notificationRow,
      ],
    );

    return Scaffold(
      body: SafeArea(child: settingsView),
      bottomSheet: const Footer(),
    );
  }
}
