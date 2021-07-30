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
  String? _name, _practicedTime, _goal, _lorem;
  bool? _completed;
  bool _newHabit = true;

  @override
  void initState() {
    super.initState();

    if (this.mounted)
      setState(() {
        _name = widget.name ?? null;
        _practicedTime = widget.practicedTime ?? null;
        _goal = widget.goal ?? null;
        _lorem = widget.lorem ?? null;
        _completed = widget.completed ?? null;
        _newHabit = widget.newHabit;
      });
  }

  @override
  Widget build(BuildContext context) {
    if (_newHabit == true) {
      print("yes");
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
            children: [
              // left side
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          _name ?? "Null",
                          style: lightText(22),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        child: Text(
                          _practicedTime ?? "00:00:00",
                          style: lightText(12),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        child: Text(
                          "Goal: $_goal",
                          style: lightText(12),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        child: Text(
                          _lorem ?? "lorem",
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
                width: 40,
              ),
              // right side
              // progress bar
              // #TODO logic to change its appearnce when active
              // #TODO add text inside
              CircularPercentIndicator(
                radius: 75,
                lineWidth: 5,
                percent: 0.53,
                center: Text(
                  "53%",
                  style: lightText(16),
                ),
                progressColor: Color(progressBarLight),
                backgroundColor: Color(progressBarBg),
              ),
              const SizedBox(
                width: 20,
              ),
              // buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
