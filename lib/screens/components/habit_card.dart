import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:habit_maker/model/habit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';

import 'add_habit.dart';

class HabitCard extends StatefulWidget {
  Habit habit;
  var startTimerCallback, editHabitCallback;
  HabitCard(this.habit, this.startTimerCallback, this.editHabitCallback);

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  String? _name, _frequency, _percentageString;
  String _practiceString = "00:00:00", _centerString = "0%";
  Duration _practiceDuration = Duration(seconds: 0),
      _targetDuration = Duration(seconds: 0);
  bool? _completed;
  TextStyle? _animationStyle;
  Timer? _animationTimer, _clockTimer;
  bool large = false;
  bool _timerState = false;
  double _progressPercentage = 0;

  void editHabit() {
    print("PRESSED");
    this.widget.editHabitCallback(this.widget.habit);
  }

  void toggleTimer() {
    widget.startTimerCallback(widget.habit);
    return;
  }

  void updateTimer() {
    setState(() {
      final secs = _practiceDuration.inSeconds + 1;
      _practiceDuration = Duration(seconds: secs);
      _practiceString = formatDuration(_practiceDuration);
      _centerString = _practiceString;
    });
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    final hours = twoDigits(d.inHours);
    return "$hours:$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();

    if (this.mounted)
      setState(() {
        _name = widget.habit.name;
        _frequency = widget.habit.frequency;
        _practiceDuration = widget.habit.practiceDuration;
        _targetDuration = widget.habit.targetDuration;
        _practiceString = formatDuration(_practiceDuration);
        _animationStyle = lightText(16);
        _completed = _practiceDuration >= _targetDuration;
        _progressPercentage =
            (_practiceDuration.inSeconds / _targetDuration.inSeconds);
        _percentageString = "${(_progressPercentage * 100).round()}%";
        _centerString = _percentageString ?? "0%";
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // card
      child: Container(
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
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // left side
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          _name ?? "Null",
                          overflow: TextOverflow.ellipsis,
                          style: lightText(22),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        child: Text(
                          "$_practiceString",
                          overflow: TextOverflow.ellipsis,
                          style: lightText(12),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        child: Text(
                          "Goal: ${formatDuration(_targetDuration)} $_frequency",
                          overflow: TextOverflow.ellipsis,
                          style: lightText(12),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        child: Text(
                          "lorem epsum dolor",
                          overflow: TextOverflow.ellipsis,
                          style: lightText(12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Divider
              const VerticalDivider(
                color: Color(0xff707070),
                thickness: 1,
                indent: 14,
                endIndent: 14,
                width: 20,
              ),
              // right side
              // progress bar
              // #TODO logic to change its appearnce when active
              Expanded(
                flex: 3,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: toggleTimer,
                  child: CircularPercentIndicator(
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 1000,
                    radius: 90,
                    lineWidth: 8,
                    percent: _progressPercentage,
                    center: Container(
                      child: AnimatedDefaultTextStyle(
                        duration: Duration(seconds: 1),
                        style: _animationStyle ?? lightText(16),
                        child: Text(
                          _centerString,
                        ),
                      ),
                    ),
                    progressColor: Color(progressBarLight),
                    backgroundColor: Color(progressBarBg),
                  ),
                ),
              ),
              // const SizedBox(
              //   width: 25,
              // ),
              // buttons
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // clock btn
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: cardButton(true),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.timer,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // settings button
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: cardButton(true),
                        onPressed: editHabit,
                        child: IconButton(
                          onPressed: editHabit,
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ), // #TOOD check if icons good
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
