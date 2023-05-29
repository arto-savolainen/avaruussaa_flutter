import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:system_tray/system_tray.dart';

const double _width = 225;
const double _height = 30;

class TitleBar extends StatelessWidget {
  final String view;

  const TitleBar(this.view, {super.key});
  
  @override
  Widget build(BuildContext context) {
    String title = '';
    Icon icon = const Icon(Icons.menu);
    VoidCallback? onPressed;

    TextStyle? titleStyle = Theme.of(context).textTheme.titleLarge;

    switch(view) {
      case 'main':
        title = 'Aktiivisuus';
        icon = const Icon(Icons.menu);
        onPressed = () => Navigator.pushNamed(context, '/settings');
      
       case 'settings':
        title = 'Asetukset';
        icon = const Icon(Icons.arrow_back);
        onPressed = () => Navigator.pop(context);
        break;

      case 'stations':
        title = 'Valitse havaintoasema';
        titleStyle = Theme.of(context).textTheme.titleMedium;
        icon = const Icon(Icons.arrow_back);
        onPressed = () => Navigator.pop(context);
        break;

      default:
        break;
    }

    final draggableArea = SizedBox(
      width: _width,
      height: _height,
      child: MoveWindow(),
    );

    final windowButtons = WindowButtons();

    final topBar = Row(children: [
      IconButton(
        color: const Color(0xff404040),
        iconSize: _height,
        padding: const EdgeInsets.all(0),
        icon: icon,
        onPressed: onPressed,
      ),
      Expanded(child: draggableArea),
      SizedBox(width: 93, height: _height, child: windowButtons),
    ]);

    final titleWidget = Text(title, style: titleStyle);

    return Column(children: [topBar, titleWidget]);
  }
}

class WindowButtons extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Row(children: [
      MinimizeWindowButton( 
        colors: minimizeBtnColors,
        onPressed: () { 
          appWindow.minimize();
        },
      ),
      CloseWindowButton(
        colors: closeBtnColors,
        onPressed: () async {
          final SystemTray systemTray = SystemTray();
          await systemTray.destroy();
          appWindow.close();
        } ),
    ]);
  }
}