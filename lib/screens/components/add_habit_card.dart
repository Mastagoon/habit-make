import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';

import 'add_habit.dart';

class NewHabit extends StatelessWidget {
  const NewHabit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DottedBorder(
        dashPattern: [8, 8],
        strokeWidth: 3,
        color: Colors.white.withOpacity(0.3),
        borderType: BorderType.RRect,
        radius: Radius.circular(15),
        child: Container(
          decoration: BoxDecoration(
              color: Color(secondaryColorDark).withOpacity(0.7),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color(secondaryColor).withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 4,
                  offset: Offset(4, 4),
                )
              ]),
          child: OutlinedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AddHabitDialog(),
            ),
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 32, vertical: 16))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Color(primaryColor).withOpacity(0.5),
                        size: 50,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Add New",
                      overflow: TextOverflow.ellipsis,
                      style: lightText(20, true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
