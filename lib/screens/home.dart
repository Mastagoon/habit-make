import 'package:flutter/material.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';
// components
import 'components/habit_card.dart';
import 'components/bottom_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(color: Color(mainBackgroundColor)),
        margin: MediaQuery.of(context).padding,
        padding: EdgeInsets.only(left: 15, right: 15),
        // #TODO reduce col's width (too wide)
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                  "Overview",
                  style: lightText(22),
                  textAlign: TextAlign.left,
                ),
                // #TODO seperator or smth
              ),
              // unfinished habits for the day
              HabitCard(
                  completed: false,
                  name: "Dance tango",
                  practicedTime: "Practiced for 00:34:12 today",
                  goal: "1:00:00 Daily",
                  lorem: "lorem epsum dolor"),
              // seperator
              Text("Completed Today"),
              Divider(),
              // finished habits for the day
              HabitCard(
                  completed: true,
                  name: "Meditation",
                  practicedTime: "Practiced for 1:24:12 today",
                  goal: "1:00:00 Daily",
                  lorem: "lorem epsum dolor"),
              HabitCard(
                  completed: true,
                  name: "Run 21 miles",
                  practicedTime: "Practiced for 3:14:12 today",
                  goal: "2:00:00 Daily",
                  lorem: "lorem epsum dolor"),
              HabitCard(
                  completed: true,
                  name: "Naked Twister",
                  practicedTime: "Practiced for 4:15:11 today",
                  goal: "3:00:00 Daily",
                  lorem: "lorem epsum dolor"),

              // Card(
              //   child: ,
              // )
            ],
          ),
        ),
      ),
      // bottom controller thingy
      bottomSheet: BottomController(),
    );
  }
}
