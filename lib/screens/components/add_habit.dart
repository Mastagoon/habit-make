import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_maker/classes/SharedPrefs.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';
import 'package:habit_maker/model/habit.dart';
import 'package:habit_maker/utils/db.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sqflite/sqflite.dart';

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({Key? key}) : super(key: key);

  @override
  _AddHabitDialogState createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  // list
  static final List<String> frequency = <String>["Daily", "Weekly", "Monthly"];
  String habitFrequency = frequency.first,
      habitName = "",
      habitDescription = "";
  int habitHours = 0, habitMinutes = 0;

  @override
  void initState() {
    super.initState();
  }

  showSnackBar(String message, int color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: lightText(18),
      ),
      backgroundColor: Color(color),
    ));
  }

  void setNewHabit() async {
    // check if name is set
    if (habitName.length < 1) {
      showSnackBar("Habit name field is required!", dangerColor);
      return;
    }
    // check duration
    if (habitMinutes < 1 && habitHours < 1) {
      showSnackBar("Habit frequency and duration must be set!", dangerColor);
      return;
    }
    // passed all checks
    // save new habit
    var habit = Habit(
      name: habitName,
      description: habitDescription,
      frequency: habitFrequency,
      targetDuration: Duration(hours: habitHours, minutes: habitMinutes),
      practiceDuration: Duration(seconds: 0), // #TODO this shouldn't be needed
    );
    // save to DB
    await DB.instance.create(habit);
    // save to shared prefs
    // await SharedPrefs.set("habit1", habit.toJson());
    Navigator.of(context).pop(); // #TODO update home ui
    showSnackBar("Habit added successfully!", successColor);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              backgroundColor: Color(secondaryColorDark),
              child: Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // title
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                      child: Text(
                        "Add New Habit",
                        style: lightText(24),
                      ),
                    ),
                    TextField(
                      onChanged: (text) => setState(() => habitName = text),
                      style: lightText(18),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: Color(primaryColor)),
                        // ),
                        labelText: "Habit Name",
                        labelStyle: hintText(16),
                        fillColor: Colors.white,
                        // prefixIcon: Icon(Icons.description),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: lightText(18),
                      onChanged: (text) =>
                          setState(() => habitDescription = text),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: Color(primaryColor)),
                        // ),
                        labelText: "Description",
                        labelStyle: hintText(16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Habit Frequency",
                        style: lightText(18),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(secondaryColorDark),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButtonHideUnderline(
                            // #TODO create your own dropdown menu
                            child: DropdownButton(
                              isExpanded: true,
                              value: habitFrequency,
                              items: frequency
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      child: Text(
                                        item,
                                        style: lightText(16),
                                      ),
                                      value: item,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) => setState(() {
                                this.habitFrequency = value.toString();
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Container(
                    //   padding: EdgeInsets.only(top: 10, bottom: 10),
                    //   child: Text(
                    //     "Time",
                    //     style: lightText(18),
                    //   ),
                    // ),
                    // choose time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            // ElevatedButton(
                            //   style: RoundedButton(primaryColor, 20),
                            //   onPressed: () {},
                            //   child: Text(
                            //     "00",
                            //     style: lightText(18),
                            //   ),
                            // ),
                            Text(
                              "HOURS",
                              style: lightText(16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            NumberPicker(
                              minValue: 0,
                              maxValue: 23,
                              value: habitHours,
                              textStyle: lightText(16),
                              selectedTextStyle: lightText(18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: Color(primaryColor)),
                              ),
                              onChanged: (value) =>
                                  setState(() => habitHours = value),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            // ElevatedButton(
                            //   style: RoundedButton(primaryColor, 20),
                            //   onPressed: () {},
                            //   child: Text(
                            //     "00",
                            //     style: lightText(18),
                            //   ),
                            // ),
                            Text(
                              "MINUTES",
                              style: lightText(16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            NumberPicker(
                              minValue: 0,
                              maxValue: 59,
                              value: habitMinutes,
                              textStyle: lightText(16),
                              selectedTextStyle: lightText(18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: Color(primaryColor)),
                              ),
                              onChanged: (value) =>
                                  setState(() => habitMinutes = value),
                            ),
                          ],
                        )
                      ],
                    ),
                    // buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // save button
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "Cancel",
                            style: lightText(18),
                          ),
                          style: generalButtonStyle(dangerColor, 15, 10),
                        ),
                        ElevatedButton(
                          onPressed: setNewHabit,
                          child: Text(
                            "Save",
                            style: lightText(18),
                          ),
                          style: generalButtonStyle(primaryColor, 19, 10),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
