import 'package:flutter/material.dart';

import 'styled_switch.dart';
import 'labeled_setting.dart';

/// A toggleable switch with a text label.
class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    required this.labelText,
    required this.value,
    required this.callback,
    super.key,
  });

  final String labelText;
  final bool value;
  final Future<void> Function(bool) callback;
  static const double defaultSwitchWidth = 46;
  static const double defaultSwitchHeight = 30;

  @override
  Widget build(BuildContext context) {
    StyledSwitch settingSwitch = StyledSwitch(
      value: value,
      callback: callback,
    );
    
    return LabeledSetting(
      settingWidget: settingSwitch,
      labelText: labelText,
      width: defaultSwitchWidth,
      height: defaultSwitchHeight,
    );
  }
}