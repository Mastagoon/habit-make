import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';
import 'package:habit_maker/model/habit.dart';
import 'package:habit_maker/utils/db.dart';
import 'package:habit_maker/utils/formatDuration.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// ignore: must_be_immutable
class ActiveHabitCard extends StatefulWidget {
  Habit habit;
  var endTimerCallback;
  ActiveHabitCard(this.habit, this.endTimerCallback);

  @override
  _ActiveHabitCardState createState() => _ActiveHabitCardState();
}

class _ActiveHabitCardState extends State<ActiveHabitCard> {
  String _percentageString = "0%", _timerString = "00:00:00";
  double _progressPercentage = 0;
  Duration? _practiceDuration;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _progressPercentage = (widget.habit.practiceDuration.inSeconds /
        widget.habit.targetDuration.inSeconds);
    _percentageString = "${(_progressPercentage * 100).round()}%";
    _timerString = formatDuration(widget.habit.practiceDuration);
    _timer = Timer.periodic(Duration(seconds: 1), (_) => updateTimer());
    _practiceDuration = widget.habit.practiceDuration;
  }

  void updateTimer() {
    setState(() {
      final secs = _practiceDuration!.inSeconds + 1;
      _practiceDuration = Duration(seconds: secs);
      _progressPercentage = (_practiceDuration!.inSeconds /
          widget.habit.targetDuration.inSeconds);
      _percentageString = "${(_progressPercentage * 100).round()}%";
      _timerString = formatDuration(_practiceDuration);
    });
  }

  void stopTimer() {
    _timer?.cancel();
    Habit updatedHabit = Habit(
        id: widget.habit.id,
        description: widget.habit.description,
        name: widget.habit.name,
        frequency: widget.habit.frequency,
        targetDuration: widget.habit.targetDuration,
        practiceDuration: _practiceDuration ?? widget.habit.practiceDuration);
    print(updatedHabit.id);
    this.widget.endTimerCallback(updatedHabit);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // card
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(secondaryColor),
            boxShadow: [
              BoxShadow(
                color: Color(secondaryColor).withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 4,
                offset: Offset(4, 4),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // text left side
                Container(
                  child: Text(
                    widget.habit.name,
                    style: lightText(28, true),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                  ),
                  onPressed: () {},
                  child: CircularPercentIndicator(
                    animation: true,
                    animationDuration: 2000,
                    radius: 45,
                    progressColor: Color(progressBarLight),
                    backgroundColor: Color(progressBarBg),
                    lineWidth: 8,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: _progressPercentage,
                    footer: Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        _percentageString,
                        style: lightText(14),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    _timerString,
                    style: lightText(26, true),
                  ),
                ),
                ElevatedButton(
                  onPressed: stopTimer,
                  child: Text(
                    "Stop",
                    style: lightText(18),
                  ),
                  style: generalButtonStyle(primaryColor, 19, 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
