import 'package:flutter/material.dart';

/// A Row with a text label and the given widget [settingWidget].
class LabeledSetting extends StatelessWidget {
  const LabeledSetting({
    required this.settingWidget,
    required this.labelText,
    this.width = 46,
    this.height = 26,
    this.alignment = MainAxisAlignment.center,
    super.key,
  });

  final dynamic settingWidget;
  final String labelText;
  final double width;
  final double height;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final settingContainer = SizedBox(
        width: width,
        height: height,
        child: settingWidget,
    );

    return Row(
      mainAxisAlignment: alignment,
      children: [
        Text(labelText),
        settingContainer,
      ],
    );
  }
}