import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';

import 'add_habit.dart';

class HabitCard extends StatefulWidget {
  String? name, practicedTime, goal, lorem;
  bool? completed;
  bool newHabit = false;

  HabitCard({
    required this.completed,
    required this.name,
    required this.practicedTime,
    required this.goal,
    required this.lorem,
    Key? key,
  }) : super(key: key);

  HabitCard.addHabit({
    this.completed,
    this.name,
    this.practicedTime,
    this.goal,
    this.lorem,
    this.newHabit = true,
    Key? key,
  }) : super(key: key);

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  String? _name, _practicedTimeString, _goal, _lorem;
  String _percentageString = "0%",
      _practiceString = "00:00:00",
      _centerString = "0%";
  Duration _practiceDuration = Duration(seconds: 0);
  bool? _completed;
  bool _newHabit = true;
  TextStyle? _animationStyle;
  Timer? _animationTimer, _clockTimer;
  bool large = false;
  bool _timerState = false;

  // TODO end me
  void animateText() {
    if (large) {
      print("Enlarging text...");
      setState(() {
        _animationStyle = percentageCenterStartStyle(16);
        _centerString = _practiceString;
      });
    } else {
      print("Enlargingn't text...");
      setState(() {
        _animationStyle = percentageCenterStartStyle(16);
        _centerString = _percentageString;
      });
    }
    large = !large;
  }

  void toggleTimer() {
    if (!_timerState) {
      // start timer
      _timerState = true; // prevent spam
      _animationTimer?.cancel();
      _clockTimer = Timer.periodic(Duration(seconds: 1), (_) => updateTimer());
      _centerString = _practiceString;
    } else {
      _timerState = false;
      _clockTimer?.cancel();
      _animationTimer =
          Timer.periodic(Duration(seconds: 5), (_) => animateText());
    }
  }

  void updateTimer() {
    setState(() {
      final secs = _practiceDuration.inSeconds + 1;
      _practiceDuration = Duration(seconds: secs);
      _practicedTimeString = formatTime();
      _centerString = _practicedTimeString ?? "00:00:00";
    });
  }

  String formatTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(_practiceDuration.inMinutes.remainder(60));
    final seconds = twoDigits(_practiceDuration.inSeconds.remainder(60));
    final hours = twoDigits(_practiceDuration.inHours);
    return "$hours:$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();

    if (this.mounted)
      setState(() {
        _name = widget.name ?? null;
        _practicedTimeString = widget.practicedTime ?? null;
        _goal = widget.goal ?? null;
        _lorem = widget.lorem ?? null;
        _completed = widget.completed ?? null;
        _newHabit = widget.newHabit;
        _animationStyle = lightText(16);
        _animationTimer =
            Timer.periodic(Duration(seconds: 5), (_) => animateText());
      });
  }

  @override
  Widget build(BuildContext context) {
    if (_newHabit == true) {
      return newHabit();
    }
    return Center(
      // card
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(_completed == true ? secondaryColor : primaryColor),
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
                          "$_practicedTimeString",
                          overflow: TextOverflow.ellipsis,
                          style: lightText(12),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        child: Text(
                          "Goal: $_goal",
                          overflow: TextOverflow.ellipsis,
                          style: lightText(12),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        child: Text(
                          _lorem ?? "lorem",
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
                    animation: true,
                    animationDuration: 1000,
                    radius: 90,
                    lineWidth: 5,
                    percent: 0.53,
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
                        style: cardButton(_completed ?? true),
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
                        style: cardButton(_completed ?? true),
                        onPressed: () {},
                        child: IconButton(
                          onPressed: () {},
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

class newHabit extends StatelessWidget {
  const newHabit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DottedBorder(
        dashPattern: [8, 8],
        strokeWidth: 3,
        color: Colors.white.withOpacity(0.3),
        borderType: BorderType.RRect,
        radius: Radius.circular(15),
        child: Container(
          decoration: BoxDecoration(
              color: Color(secondaryColorDark).withOpacity(0.7),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color(secondaryColor).withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 4,
                  offset: Offset(4, 4),
                )
              ]),
          child: OutlinedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AddHabitDialog(),
            ),
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 32, vertical: 16))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Color(primaryColor).withOpacity(0.5),
                        size: 50,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Add New",
                      overflow: TextOverflow.ellipsis,
                      style: lightText(20, true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
