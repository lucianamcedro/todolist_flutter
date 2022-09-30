import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static FormFieldValidator compare(
      TextEditingController? valueEC, String message) {
    return (value) {
      final valuCompare = valueEC?.text ?? '';
      if (value == null || value != null && value != valuCompare) {
        return message;
      }
      return null;
    };
  }
}
