import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String viewName;
  final TextStyle titleStyle;
  
  MyAppBar(this.viewName, {this.titleStyle = const TextStyle(), super.key});

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
        title = 'Valitse havaintoasema';
        leadingIcon = const Icon(Icons.arrow_back);
        onIconClick = () => Navigator.pop(context);
        break;

      default:
        break;
    }

    return AppBar(
      leading: IconButton(
        icon: leadingIcon,
        onPressed: onIconClick,
      ),
      centerTitle: true,
      title: Text(title, style: titleStyle),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}