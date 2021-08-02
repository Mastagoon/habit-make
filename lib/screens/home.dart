import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';
import 'package:habit_maker/data/habits.dart';
import 'package:habit_maker/model/habit.dart';
import 'package:habit_maker/screens/components/active_habit_card.dart';
import 'package:habit_maker/screens/components/add_habit_card.dart';
import 'package:habit_maker/utils/db.dart';
// components
import 'components/add_habit.dart';
import 'components/habit_card.dart';
import 'components/bottom_controller.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  ActiveHabitCard? activeHabit;
  late bool isActive;
  List<HabitCard> habitList = [];

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    Timer(Duration(milliseconds: 200), () => _animationController.forward());
    isActive = true;
    getHabits();
    super.initState();
  }

  void getHabits() async {
    var habits = await DB.instance.readAllHabits();
    setState(() {
      habitList = habits.map((h) => HabitCard(h, startTimerCallback)).toList();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
        child: buildHabitCards(),
      ),
      // bottom controller thingy
      // bottomSheet: BottomController(),
    );
  }

  SingleChildScrollView buildHabitCards() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Container(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 5),
            child: Text(
              "Active",
              style: lightText(22),
              textAlign: TextAlign.left,
            ),
            // #TODO seperator or smth
          ),
          // active timer
          if (activeHabit != null) activeHabitCardBuilder(activeHabit),

          // activeHabitCardBuilder(),
          // create: (context) => TimerProvider(),
          // child:
          Wrap(
            runSpacing: 10,
            children: [
              // active card
              // ActiveHabitCard(unfinishedHabits[0]),
              // seperator
              Container(
                padding: EdgeInsets.only(left: 5, top: 15, bottom: 10),
                child: Text(
                  "Unfinished",
                  style: hintText(16),
                ),
              ),
              SlideTransition(
                position: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
                    .animate(_animationController),
                child: FadeTransition(
                  opacity: _animationController,
                  child: Wrap(
                    runSpacing: 10,
                    children: [
                      ...habitList,
                      // HabitCard(unfinishedHabits[0], startTimerCallback),
                      // HabitCard(unfinishedHabits[1], startTimerCallback),
                      NewHabit(),
                    ],
                  ),
                ),
              ),

              // add a new habit card
            ],
          ),
          // ),
          // unfinished habits for the day
        ],
      ),
    );
  }

  ActiveHabitCard activeHabitCardBuilder(activeHabit) {
    return activeHabit;
  }

  startTimerCallback(habit) {
    setState(() {
      activeHabit = ActiveHabitCard(habit, endTimerCallback);
    });
  }

  endTimerCallback(habit) async {
    // update habit
    print(habit);
    await DB.instance.update(habit);
    setState(() {
      activeHabit = null;
    });
  }
}
