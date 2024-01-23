import 'dart:async';

import 'package:flutter/cupertino.dart';

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.microsecondsPerMillisecond),
      action,
    );
  }
}