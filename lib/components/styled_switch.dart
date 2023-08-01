import 'package:flutter/material.dart';

/// A simple Switch with a bit of styling.
class StyledSwitch extends StatelessWidget {
  const StyledSwitch({required this.value, required this.callback, super.key});

  final bool value;
  final Future<void> Function(bool) callback;

  @override
  Widget build(BuildContext context) {
    return Switch(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        inactiveThumbColor: Theme.of(context).primaryColor,
        inactiveTrackColor: Colors.blueGrey,
        value: value,
        onChanged: (newValue) => callback(newValue));
  }
}