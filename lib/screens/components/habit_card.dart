import 'package:flutter/material.dart';

class HabitCard extends StatefulWidget {
  late final String name, practicedTime, goal, lorem;
  late final bool completed;

  HabitCard(bool completed, String name, String practicedTime, String goal,
      String lorem) {
    this.name = name;
    this.practicedTime = practicedTime;
    this.goal = goal;
    this.lorem = lorem;
    this.completed = completed;
  }

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  late String _name, _practicedTime, _goal, _lorem;

  @override
  void initState() {
    super.initState();

    if (this.mounted)
      setState(() {
        _name = this.widget.name;
        _practicedTime = this.widget.practicedTime;
        _goal = this.widget.goal;
        _lorem = this.widget.lorem;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        // card
        child: IntrinsicHeight(
          child: Row(
            children: [
              // left side
              Column(
                children: [
                  Text(_name),
                  Text(_practicedTime),
                  Text("Goal: $_goal"),
                  Text(_lorem)
                ],
              ),
              // Divider
              const VerticalDivider(
                color: Colors.grey,
                thickness: 1,
                indent: 14,
                endIndent: 14,
                width: 100,
              ),
              // right side
              // progress bar
              // #TODO logic to change its appearnce when active
              // #TODO add text inside
              CircularProgressIndicator(
                value: 53,
              ),
              // buttons
              Column(
                children: [
                  // clock btn
                  IconButton(onPressed: () {}, icon: Icon(Icons.timer)),
                  // settings button
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.settings)) // #TOOD check if icons good
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
