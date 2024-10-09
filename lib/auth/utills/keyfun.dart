import 'package:flutter/material.dart';

class KeyboardUtils {

  static dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
