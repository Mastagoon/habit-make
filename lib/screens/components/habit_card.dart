import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';

class HabitCard extends StatefulWidget {
  final String name, practicedTime, goal, lorem;
  final bool completed;

  const HabitCard({
    required this.completed,
    required this.name,
    required this.practicedTime,
    required this.goal,
    required this.lorem,
    Key? key,
  }) : super(key: key);

  // HabitCard(bool completed, String name, String practicedTime, String goal,
  //     String lorem) {
  //   this.name = name;
  //   this.practicedTime = practicedTime;
  //   this.goal = goal;
  //   this.lorem = lorem;
  //   this.completed = completed;
  // }

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  late String _name, _practicedTime, _goal, _lorem;
  late bool _completed;

  @override
  void initState() {
    super.initState();

    if (this.mounted)
      setState(() {
        _name = widget.name;
        _practicedTime = widget.practicedTime;
        _goal = widget.goal;
        _lorem = widget.lorem;
        _completed = widget.completed;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // card
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(_completed ? secondaryColor : primaryColor),
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
                          _name,
                          style: lightText(22),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        child: Text(
                          _practicedTime,
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
                          _lorem,
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
                width: 10,
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
                      style: cardButton(true),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.timer,
                          color: Colors.white,
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
                      onPressed: () {},
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
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
