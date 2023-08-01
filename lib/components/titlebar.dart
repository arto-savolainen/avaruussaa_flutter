import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/settings_provider.dart';
import '../system/window_manager.dart';

/// Builds a draggable title bar with a clickable icon. Parameter [viewId] is used to determine
/// the title and icon used. 'main' creates the title bar for the main view, 'settings' for
/// the settings view, and 'stations' for the stations view.
class TitleBar extends StatelessWidget {
  const TitleBar({required this.viewId, super.key});

  final String viewId;
  final double topBarWidth = 225;
  final double topBarHeight = 30;

  @override
  Widget build(BuildContext context) {
    String title = '';
    Icon icon = const Icon(Icons.menu);
    VoidCallback? handleClick; // Called when the user presses the icon in the top left corner.

    TextStyle? titleStyle = Theme.of(context).textTheme.titleLarge;

    // Determine title, icon graphic and icon onPressed function based on [viewId].
    switch (viewId) {
      case 'main':
        title = 'Aktiivisuus';
        icon = const Icon(Icons.menu);
        handleClick = () => Navigator.pushNamed(context, '/settings');

      case 'settings':
        title = 'Asetukset';
        icon = const Icon(Icons.arrow_back);
        handleClick = () => Navigator.pop(context);
        break;

      case 'stations':
        title = 'Valitse havaintoasema';
        titleStyle = Theme.of(context).textTheme.titleMedium;
        icon = const Icon(Icons.arrow_back);
        handleClick = () => Navigator.pop(context);
        break;

      default:
        break;
    }

    // bitsdojo_window allows us to define a draggable window area with MoveWindow().
    final draggableArea = SizedBox(
      width: topBarWidth,
      height: topBarHeight,
      child: MoveWindow(),
    );

    final windowButtons = WindowButtons();

    // The top bar consists of a clickable icon on the left, then a draggable area, then the
    // minimize and close buttons on the right.
    final topBar = Row(children: [
      IconButton(
        color: const Color(0xff404040),
        iconSize: topBarHeight,
        padding: const EdgeInsets.all(0),
        icon: icon,
        onPressed: handleClick,
      ),
      Expanded(child: draggableArea),
      SizedBox(width: 93, height: topBarHeight, child: windowButtons),
    ]);

    final titleWidget = Text(title, style: titleStyle);

    // The finished title bar is a Column which consists of the top bar and the view's title.
    return Column(children: [topBar, titleWidget]);
  }
}

class WindowButtons extends ConsumerWidget {
  final minimizeBtnColors = WindowButtonColors(
    iconNormal: const Color(0xff404040),
    mouseOver: const Color(0xff343434),
  );

  final closeBtnColors = WindowButtonColors(
    iconNormal: const Color(0xff404040),
    mouseOver: const Color(0xffE81123),
  );

  WindowButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get app settings from the provider to see if the minimize button
    // should hide or minimize the window.
    final settings = ref.watch(asyncSettingsProvider);

    return Row(children: [
      MinimizeWindowButton(
        colors: minimizeBtnColors,
        onPressed: () {
          // Check the value of the minimizeToTray setting.
          if (settings.hasValue && (settings.value?.minimizeToTray)!) {
            hideWindow(); // Send app to tray.
          } 
          else {
            minimizeWindow(); // Else minimize to taskbar.
          }
        },
      ),
      CloseWindowButton(
          colors: closeBtnColors,
          onPressed: () async {
            closeWindow(); // Exits the app.
          }),
    ]);
  }
}
