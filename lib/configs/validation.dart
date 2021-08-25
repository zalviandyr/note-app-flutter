import 'package:note_app/configs/configs.dart';

class Validation {
  static String? inputRequired(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }

    return ValidationWord.cannotEmpty;
  }
}
