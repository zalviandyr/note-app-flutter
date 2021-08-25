import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/configs/configs.dart';

class Helper {
  static Color getNoteBackgroundColor() {
    Random random = Random();
    int len = Pallette.colorsNote.length;
    return Pallette.colorsNote[random.nextInt(len)];
  }

  static String formatTime(DateTime dateTime) {
    DateFormat format = DateFormat('dd MMMM yyyy - h:mm a');
    return format.format(dateTime);
  }
}
