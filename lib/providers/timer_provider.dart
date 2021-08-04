// timer is attached on one habit only
import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  Duration _duration = Duration(seconds: 0);

  Duration get duration => _duration;

  String getTimeString() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes =
        twoDigits(_duration.inMinutes.remainder(60));
    final seconds =
        twoDigits(_duration.inSeconds.remainder(60));
    final hours = twoDigits(_duration.inHours);
    return "$hours:$minutes:$seconds";
  }

  void incrementDuration() {
    final secs = _duration.inSeconds + 1;
    _duration = Duration(seconds: secs);
    notifyListeners();
  }

}
