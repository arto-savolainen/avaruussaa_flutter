import 'package:flutter/material.dart';

import 'number_input_field.dart';
import 'labeled_setting.dart';

/// A TextFormField with a text label that accepts decimal numbers only.
class LabeledNumberInput extends StatelessWidget {
  const LabeledNumberInput({
    required this.labelText,
    required this.value,
    required this.callback,
    super.key,
  });

  final String labelText;
  final double value;
  final Future<void> Function(double) callback;
  static const double defaultInputWidth = 55;
  static const double defaultInputHeight = 30;

  @override
  Widget build(BuildContext context) {
    NumberInputField numberInput = NumberInputField(
      initialValue: value,
      callback: callback,
    );
    
    return LabeledSetting(
      settingWidget: numberInput,
      labelText: labelText,
      width: defaultInputWidth,
      height: defaultInputHeight,
    );
  }
}