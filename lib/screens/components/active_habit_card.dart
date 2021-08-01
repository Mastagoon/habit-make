import 'package:flutter/material.dart';
import 'package:habit_maker/classes/Habit.dart';
import 'package:habit_maker/constants/colors.dart';
import 'package:habit_maker/constants/styles.dart';
import 'package:habit_maker/utils/formatDuration.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ActiveHabitCard extends StatefulWidget {
  Habit habit;
  ActiveHabitCard(this.habit);

  @override
  _ActiveHabitCardState createState() => _ActiveHabitCardState();
}

class _ActiveHabitCardState extends State<ActiveHabitCard> {
  String _percentageString = "0%", _timerString = "00:00:00";
  double _progressPercentage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progressPercentage = (widget.habit.practiceDuration.inSeconds /
        widget.habit.targetDuration.inSeconds);
    _percentageString = "${(_progressPercentage * 100).round()}%";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // card
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(secondaryColor),
            boxShadow: [
              BoxShadow(
                color: Color(secondaryColor).withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 4,
                offset: Offset(4, 4),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // text left side
                // Expanded(
                // child:
                Container(
                  child: Text(
                    widget.habit.name,
                    style: lightText(28, true),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Container(
                //   child: Text(
                //     "In Progress...$_percentageString",
                //     style: lightText(16),
                //   ),
                // ),
                // Container(
                //   child: Text(
                //       "Goal ${formatDuration(widget.habit.targetDuration)}",
                //       style: lightText(16)),
                // ),
                // indictaor
                // ),
                SizedBox(
                  height: 5,
                ),
                // child:
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                  ),
                  onPressed: () {},
                  child: CircularPercentIndicator(
                    animation: true,
                    animationDuration: 2000,
                    radius: 45,
                    progressColor: Color(progressBarLight),
                    backgroundColor: Color(progressBarBg),
                    lineWidth: 8,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: _progressPercentage,
                    footer: Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        _percentageString,
                        style: lightText(14),
                      ),
                    ),
                    // center: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       child: Text(
                    //         _timerString,
                    //         style: lightText(20),
                    //       ),
                    //     ),
                    //     Container(
                    //       child: Text(
                    //         _percentageString,
                    //         style: lightText(14),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    _timerString,
                    style: lightText(26, true),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Stop",
                    style: lightText(18),
                  ),
                  style: generalButtonStyle(primaryColor, 19, 10),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   // crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Expanded(
                //       child: Text(
                //         _timerString,
                //         style: lightText(30),
                //       ),
                //     ),
                //     Expanded(
                //         child: OutlinedButton(
                //       style: OutlinedButton.styleFrom(
                //         shape: CircleBorder(),
                //         padding: EdgeInsets.zero,
                //       ),
                //       onPressed: () {},
                //       child: CircularPercentIndicator(
                //         animation: true,
                //         animationDuration: 2000,
                //         radius: 45,
                //         progressColor: Color(progressBarLight),
                //         backgroundColor: Color(progressBarBg),
                //         lineWidth: 8,
                //         percent: _progressPercentage,
                //         // center: Container(
                //         //   child: Text(
                //         //     _timerString,
                //         //     style: lightText(16),
                //         //   ),
                //         // ),
                //       ),
                //     ))
                //   ],
                // ),
              ],
            ),
          ],
        ),

        // IntrinsicHeight(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       // left side
        //       Expanded(
        //         flex: 6,
        //         child: Container(
        //           padding: EdgeInsets.all(20),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Container(
        //                 child: Text(
        //                   _name ?? "Null",
        //                   overflow: TextOverflow.ellipsis,
        //                   style: lightText(22),
        //                 ),
        //               ),
        //               const SizedBox(height: 5),
        //               Container(
        //                 child: Text(
        //                   "$_practiceString",
        //                   overflow: TextOverflow.ellipsis,
        //                   style: lightText(12),
        //                 ),
        //               ),
        //               const SizedBox(height: 3),
        //               Container(
        //                 child: Text(
        //                   "Goal: ${formatDuration(_targetDuration)} $_frequency",
        //                   overflow: TextOverflow.ellipsis,
        //                   style: lightText(12),
        //                 ),
        //               ),
        //               const SizedBox(height: 3),
        //               Container(
        //                 child: Text(
        //                   "lorem epsum dolor",
        //                   overflow: TextOverflow.ellipsis,
        //                   style: lightText(12),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),

        //       // Divider
        //       const VerticalDivider(
        //         color: Color(0xff707070),
        //         thickness: 1,
        //         indent: 14,
        //         endIndent: 14,
        //         width: 20,
        //       ),
        //       // right side
        //       // progress bar
        //       // #TODO logic to change its appearnce when active
        //       Expanded(
        //         flex: 3,
        //         child: OutlinedButton(
        //           style: OutlinedButton.styleFrom(
        //             shape: CircleBorder(),
        //             padding: EdgeInsets.zero,
        //           ),
        //           onPressed: toggleTimer,
        //           child: CircularPercentIndicator(
        //             animation: true,
        //             animationDuration: 1000,
        //             radius: 90,
        //             lineWidth: 8,
        //             percent: _progressPercentage,
        //             center: Container(
        //               child: AnimatedDefaultTextStyle(
        //                 duration: Duration(seconds: 1),
        //                 style: _animationStyle ?? lightText(16),
        //                 child: Text(
        //                   _centerString,
        //                 ),
        //               ),
        //             ),
        //             progressColor: Color(progressBarLight),
        //             backgroundColor: Color(progressBarBg),
        //           ),
        //         ),
        //       ),
        //       // const SizedBox(
        //       //   width: 25,
        //       // ),
        //       // buttons
        //       Expanded(
        //         flex: 2,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             // clock btn
        //             SizedBox(
        //               width: 40,
        //               height: 40,
        //               child: ElevatedButton(
        //                 onPressed: () {},
        //                 style: cardButton(_completed ?? true),
        //                 child: IconButton(
        //                   onPressed: () {},
        //                   icon: Icon(
        //                     Icons.timer,
        //                     color: Colors.white,
        //                     size: 20,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             const SizedBox(height: 10),
        //             // settings button
        //             SizedBox(
        //               width: 40,
        //               height: 40,
        //               child: ElevatedButton(
        //                 style: cardButton(_completed ?? true),
        //                 onPressed: () {},
        //                 child: IconButton(
        //                   onPressed: () {},
        //                   icon: Icon(
        //                     Icons.settings,
        //                     color: Colors.white,
        //                     size: 20,
        //                   ),
        //                 ),
        //               ), // #TOOD check if icons good
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
