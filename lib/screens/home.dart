import 'package:flutter/material.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';
import 'package:habit_maker/data/habits.dart';
import 'package:habit_maker/providers/timer_provider.dart';
import 'package:habit_maker/screens/components/add_habit_card.dart';
import 'package:provider/provider.dart';
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
              "Overview",
              style: lightText(22),
              textAlign: TextAlign.left,
            ),
            // #TODO seperator or smth
          ),

          // create: (context) => TimerProvider(),
          // child:
          Wrap(
            spacing: 10,
            children: [
              ChangeNotifierProvider(
                create: (context) => TimerProvider(),
                child: HabitCard(unfinishedHabits[0]),
              ),
              // seperator
              Container(
                padding: EdgeInsets.only(left: 5, top: 15, bottom: 10),
                child: Text(
                  "Practiced Today",
                  style: hintText(16),
                ),
              ),

              // add a new habit card
              NewHabit(),
            ],
          ),
          // ),
          // unfinished habits for the day
        ],
      ),
    );
  }
}
