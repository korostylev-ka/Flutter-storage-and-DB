import 'package:flutter/services.dart';

class NumberFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    text = '+${text.replaceAll(RegExp(r'\D'), '')}';
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length)
    );
  }




}