import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String viewName;
  final TextStyle titleStyle;
  
  const MyAppBar(this.viewName, {this.titleStyle = const TextStyle(), super.key});

  @override
  Widget build(BuildContext context) {
    String title = '';
    Icon leadingIcon = const Icon(Icons.menu);
    VoidCallback onIconClick = () {};

    switch (viewName) {
      case 'main':
        title = 'Aktiivisuus';
        leadingIcon = const Icon(Icons.menu);
        onIconClick = () => Navigator.pushNamed(context, '/settings');
        break;

      case 'settings':
        title = 'Asetukset';
        leadingIcon = const Icon(Icons.arrow_back);
        onIconClick = () => Navigator.pop(context);
        break;

      case 'stations':
        title = 'Havaintoasema';
        leadingIcon = const Icon(Icons.arrow_back);
        onIconClick = () => Navigator.pop(context);
        break;

      default:
        break;
    }

    var minimizeBtn = IconButton(onPressed: () => {}, icon: Icon(Icons.minimize));
    var closeBtn = IconButton(onPressed: () {}, icon: Icon(Icons.close));

    return MoveWindow(child: AppBar(
      leading: IconButton(
        icon: leadingIcon,
        onPressed: onIconClick,
      ),
      centerTitle: true,
      // title: SizedBox(width: 100, height: 30, child: MoveWindow(child:Text(title, style: titleStyle))),
      title: Text(title, style: titleStyle),
      actions: [minimizeBtn, closeBtn],
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}