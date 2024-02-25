import 'dart:async';

import 'package:flutter/material.dart';

class Bounce {
  final int milliSeconds;
  Bounce({required this.milliSeconds});
  Timer? timer;

  void run(VoidCallbackAction action) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliSeconds), () {});
  }
}
