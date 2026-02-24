import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration _duration;
  Timer? _timer;

  Debouncer({Duration duration = const Duration(milliseconds: 300)})
    : _duration = duration;

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }

    _timer = Timer(_duration, action);
  }

  void cancel() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
  }
}
