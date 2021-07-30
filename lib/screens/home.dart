import 'package:flutter/material.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';
import 'package:habit_maker/data/habits.dart';
// components
import 'components/add_habit.dart';
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
      appBar: AppBar(
        title: Text("Habit Builder"),
        leading: Icon(
          Icons.menu,
        ),
        actions: [
          Container(
            child: IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AddHabitDialog(),
              ),
              icon: Icon(Icons.add_circle_outline_outlined),
              iconSize: 30,
            ),
            padding: EdgeInsets.only(right: 5),
          ),
          Container(
            child: IconButton(
              onPressed: () => showModalBottomSheet(
                  context: context, builder: (context) => BottomController()),
              icon: Icon(Icons.calendar_today_outlined),
            ),
            padding: EdgeInsets.only(right: 5),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Color(mainBackgroundColor)),
        // margin: MediaQuery.of(context).padding,
        padding: EdgeInsets.only(left: 15, right: 15),
        // #TODO reduce col's width (too wide)
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 10),
          child: Wrap(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            runSpacing: 10,
            children: [
              // title
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 5),
                child: Text(
                  "Overview",
                  style: lightText(22),
                  textAlign: TextAlign.left,
                ),
                // #TODO seperator or smth
              ),
              // unfinished habits for the day
              ...unfinishedCards,
              // seperator
              Container(
                padding: EdgeInsets.only(left: 5, top: 15, bottom: 10),
                child: Text(
                  "Practiced Today",
                  style: hintText(16),
                ),
              ),
              // Divider(
              //   color: Colors.white,
              // ),
              // finished habits for the day
              ...finishedCards,

              // add a new habit card
              HabitCard.addHabit(),

              // HabitCard(
              //     completed: completed,
              //     name: name,
              //     practicedTime: practicedTime,
              //     goal: goal,
              //     lorem: lorem)
            ],
            
          ),
        ),
      ),
      // bottom controller thingy
      // bottomSheet: BottomController(),
    );
  }
}
