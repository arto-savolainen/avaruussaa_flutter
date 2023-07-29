import 'package:avaruussaa_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/titlebar.dart';
import '../storage/user_settings.dart';
import '../components/footer.dart';
import '../models/settings.dart';


// Pass data to this view instead of retrieving in the view
// Keep the data model in main or mainview 
// Call the data model to update itself on pop https://api.flutter.dev/flutter/widgets/Navigator/pop.html
// Step 1 - Create SettingsModel _settingsModel instance in MainView. 
// 1.2 - SettingsModel initState should call async function to populate instance data fields using UserSettings class
// Step 2 - UserSettings.subscribe(_settingsModel)
// Step 3 - pass _settingsModel to SettingsView through Navigator
// Step 4 - populate SettingsView with SettingsModel data
// Step 5 - User actions trigger calls to UserSettings to update data in storage and in model
// STEP OMEGA: USE RIVERPOD https://www.geeksforgeeks.org/flutter-introduction-to-state-management-using-riverpod/

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => SettingsViewState();
}

class SettingsViewState extends ConsumerState<SettingsView> {
  double _notificationThreshold = 0.4;
  double _notificationInterval = 1;
  bool _notificationsEnabled = true;
  bool _minimizeToTray = true;

  @override
  initState() {
    super.initState();
    // _loadSettings();
    print('INITIALIZING SETTINGSVIEW!!!!!!!!!!!!!!!!!!!!!!');
  }

  @override
  void dispose() {
    super.dispose();
  }

  // _loadSettings() async {
  //   bool notificationsEnabled = await UserSettings.getNotificationsEnabled();
  //   bool minimizeToTray = await UserSettings.getMinimizeToTray();
  //   double notificationThreshold = await UserSettings.getNotificationThreshold();
  //   double notificationInterval = await UserSettings.getNotificationInterval();

  //   setState(() {
  //     _notificationThreshold = notificationThreshold;
  //     _notificationInterval = notificationInterval;
  //     _notificationsEnabled = notificationsEnabled;
  //     _minimizeToTray = minimizeToTray;
  //   });
  // }

  _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });

    UserSettings.setNotificationsEnabled(_notificationsEnabled);
  }

  _toggleMinimize(bool value) {
    setState(() {
      _minimizeToTray = value;
    });

    UserSettings.setNotificationsEnabled(_notificationsEnabled);
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<Settings> settings = ref.read(settingsProvider);
    settings.when(
      loading: () {},
      error: (err, stack) {},
      data: (settings) {
        print('SETTINGS: $settings');
        _toggleNotifications(settings.notificationsEnabled);
        _toggleMinimize(settings.minimizeToTray);
      },
    );
   
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

    final minimizeSwitch = SizedBox(
      width: 46,
      height: 26,
      child: Switch(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        inactiveThumbColor: Theme.of(context).primaryColor,
        inactiveTrackColor: Colors.blueGrey,
        value: _minimizeToTray,
        onChanged: _toggleMinimize,
      ),
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
  }
}
