import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';
import 'package:habit_maker/model/habit.dart';
import 'package:habit_maker/utils/db.dart';
import 'package:numberpicker/numberpicker.dart';

class EditHabitDialog extends StatefulWidget {
  Habit habit;
  var deleteHabitCallback, updateHabitCallback;
  EditHabitDialog(
      this.habit, this.deleteHabitCallback, this.updateHabitCallback);

  @override
  _EditHabitDialogState createState() => _EditHabitDialogState();
}

class _EditHabitDialogState extends State<EditHabitDialog> {
  static final List<String> frequency = <String>["Daily", "Weekly", "Monthly"];

  String? newName, newDescription, newFrequency;
  int newHours = 0, newMinuets = 0;

  updateHabit() {
    Duration targetDuration = (newHours + newMinuets > 0)
        ? Duration(hours: newHours, minutes: newMinuets)
        : widget.habit.practiceDuration;
    var habit = new Habit(
        id: widget.habit.id,
        name: newName ?? widget.habit.name,
        description: newDescription ?? widget.habit.description,
        frequency: newFrequency ?? widget.habit.frequency,
        practiceDuration: widget.habit.practiceDuration,
        targetDuration: targetDuration);
    //update
    Navigator.of(context).pop();
    return widget.updateHabitCallback(habit);
  }

  deleteHabitAlert() {
    print("PRESSEd");
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Confirm"),
            content: Text("Are you sure you want to delete this habit?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteHabit();
                },
                child: Text("Yes"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
              )
            ],
          );
        });
  }

  deleteHabit() {
    Navigator.of(context).pop();
    return widget.deleteHabitCallback(widget.habit.id);
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
                      onChanged: (text) => setState(() => newName = text),
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
                        hintText: widget.habit.name,
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
                          setState(() => newDescription = text),
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
                        hintText: widget.habit.description,
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
                              value: widget.habit.frequency,
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
                                newFrequency = value.toString();
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // choose time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
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
                              value: newHours,
                              textStyle: lightText(16),
                              selectedTextStyle: lightText(18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: Color(primaryColor)),
                              ),
                              onChanged: (value) =>
                                  setState(() => newHours = value),
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
                              value: newMinuets,
                              textStyle: lightText(16),
                              selectedTextStyle: lightText(18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: Color(primaryColor)),
                              ),
                              onChanged: (value) =>
                                  setState(() => newMinuets = value),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: deleteHabitAlert,
                      child: Text(
                        "Delete Habit",
                        style: lightText(18),
                      ),
                      style: generalButtonStyle(dangerColor, 19, 10),
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
                          onPressed: updateHabit,
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
