import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({Key? key}) : super(key: key);

  @override
  _AddHabitDialogState createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  // list
  static final List<String> frequency = <String>["Daily", "Weekly", "Monthly"];
  String dropdownChoice = frequency.first;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: SingleChildScrollView(
        child: Dialog(
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
                    style: lightText(22),
                  ),
                ),
                TextField(
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
                          value: dropdownChoice,
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
                            this.dropdownChoice = value.toString();
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "Time",
                    style: lightText(18),
                  ),
                ),
                // choose time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          style: RoundedButton(primaryColor, 20),
                          onPressed: () {},
                          child: Text(
                            "00",
                            style: lightText(18),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "HOURS",
                          style: lightText(16),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: RoundedButton(primaryColor, 20),
                          onPressed: () {},
                          child: Text(
                            "00",
                            style: lightText(18),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "MINUTES",
                          style: lightText(16),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
