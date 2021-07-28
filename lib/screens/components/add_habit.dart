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
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Dialog(
        backgroundColor: Color(secondaryColor),
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // title
              Text(
                "Add New Habit",
                style: lightText(22),
              ),
              TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
