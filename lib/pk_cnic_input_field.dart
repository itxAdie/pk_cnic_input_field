library pk_cnic_input_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PKCNICInputField extends StatelessWidget {
  final onChanged;
  final _mobileFormatter = NumberTextInputFormatter();
  final cursorColor;
  final prefixIconColor;
  PKCNICInputField(
      {required this.onChanged,
      this.cursorColor = Colors.black,
      this.prefixIconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: this.cursorColor,
      keyboardType: TextInputType.number,
      maxLength: 15,
      decoration: InputDecoration(
        icon: Icon(
          Icons.person,
          color: prefixIconColor,
        ),
        hintText: "Your CNIC",
        border: InputBorder.none,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _mobileFormatter
      ],
    );
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 6) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 5) + '-');
      if (newValue.selection.end >= 5) selectionIndex += 1;
    }
    if (newTextLength >= 13) {
      newText.write(newValue.text.substring(5, usedSubstringIndex = 12) + '-');
      if (newValue.selection.end >= 12) selectionIndex += 1;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
