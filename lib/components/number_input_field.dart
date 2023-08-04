import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A TextFormField that only accepts decimal numerals as input. Sends valid
/// input to [callback] as a double.
class NumberInputField extends StatefulWidget {
  const NumberInputField({
    required this.initialValue,
    required this.callback,
    super.key,
  });

  final double initialValue;
  final Future<void> Function(double) callback;

  @override
  State<NumberInputField> createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  late TextEditingController _controller;

  /// Validates user input of the TextFormField and passes valid values to callback
  /// function. Input must be a valid double.
  void _validateInputAndUpdateAppState() {
    double valueAsDouble;

    // Check that the value can be cast to double.
    try {
      valueAsDouble = double.parse(_controller.text);
    } on FormatException {
      // Otherwise, revert the text to the previous valid value.
      _controller.text = widget.initialValue.toString();
      return;
    }

    // Highest allowed value is 99.99.
    if (valueAsDouble > 99.99) {
      valueAsDouble = 99.99;
    }

    _controller.text = valueAsDouble.toString();

    // Update app state with the valid value by sending it to asyncSettingsProvider.
    widget.callback(valueAsDouble);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    // Handle submit event with a listener function that triggers when the
    // TextFormField loses focus.
    final FocusNode focusNode = FocusNode();
    focusNode.addListener(() { 
      if (!focusNode.hasFocus) {
        _validateInputAndUpdateAppState();
      }
    });

    final inputField = TextFormField(
      focusNode: focusNode,
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(0, 12.4, 0, 0),
        border: InputBorder.none,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d*.{0,1}\d*$'), // Only allow digits and a decimal separator.
          replacementString: _controller.text,
        ),
        LengthLimitingTextInputFormatter(5),
      ],
      controller: _controller,
    );

    return inputField;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}