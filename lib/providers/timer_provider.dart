// timer is attached on one habit only
import 'package:flutter/material.dart';
import 'package:habit_maker/classes/Habit.dart';

class TimerProvider extends ChangeNotifier {
  Habit? activeHabit;
  getActiveHabit() => activeHabit ?? null;
  getPracticeTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes =
        twoDigits(activeHabit!.practiceDuration.inMinutes.remainder(60));
    final seconds =
        twoDigits(activeHabit!.practiceDuration.inSeconds.remainder(60));
    final hours = twoDigits(activeHabit!.practiceDuration.inHours);
    return "$hours:$minutes:$seconds";
  }

  updateHabitPracticeTime() {
    final secs = activeHabit!.practiceDuration.inSeconds + 1;
    activeHabit!.practiceDuration = Duration(seconds: secs);
    notifyListeners();
  }
}
