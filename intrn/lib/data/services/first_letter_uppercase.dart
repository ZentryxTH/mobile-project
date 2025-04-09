import 'package:flutter/services.dart';

class FirstLetterUpperCase extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.isEmpty) return newValue;

    final first = text.substring(0, 1).toUpperCase();
    final rest = text.length > 1 ? text.substring(1) : "";

    return newValue.copyWith(
      text: '$first$rest',
      selection: newValue.selection,
    );
  }
}