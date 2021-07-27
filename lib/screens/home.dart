import 'package:flutter/material.dart';
import 'components/habit_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        // #TODO reduce col's width (too wide)
        child: Column(
          children: [
            // title
            Text("Overview"),
            // unfinished habits for the day
            HabitCard(false, "Dance tango", "Practiced for 00:34:12 today",
                "1:00:00 Daily", "lorem epsum dolor"),
            // seperator
            Text("Completed Today"),
            Divider(),
            // finished habits for the day
            HabitCard(true, "Meditation", "Practiced for 1:24:12 today",
                "1:00:00 Daily", "lorem epsum dolor"),
            HabitCard(true, "Run 21 miles", "Practiced for 3:14:12 today",
                "2:00:00 Daily", "lorem epsum dolor"),
            HabitCard(true, "Naked Twister", "Practiced for 4:15:11 today",
                "3:00:00 Daily", "lorem epsum dolor"),
            // bottom controller thingy
            // Card(
            //   child: ,
            // )
          ],
        ),
      ),
      // bottomNavigationBar: ,
    );
  }
}
