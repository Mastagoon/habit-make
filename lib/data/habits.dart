import 'package:habit_maker/classes/Habit.dart';
import 'package:habit_maker/screens/components/habit_card.dart';

// a list of habits

List<Habit> unfinishedHabits = [
  Habit(
    name: "Dance Tango",
    description: "the activity of dancing the dances of tango",
    frequency: "daily",
    practiceDuration: Duration(seconds: 3000),
    targetDuration: Duration(seconds: 3600),
  ),
  Habit(
    name: "Dance",
    description: "the activity of dancing the dances of tango",
    frequency: "daily",
    practiceDuration: Duration(seconds: 0),
    targetDuration: Duration(hours: 2),
  ),
  Habit(
    name: "Meditation",
    description: "the activity of dancing the dances of tango",
    frequency: "Daily",
    practiceDuration: Duration(seconds: 5642),
    targetDuration: Duration(hours: 1),
  ),
];

// List<HabitCard> unfinishedCards = [
//   HabitCard(
//     completed: false,
//     name: "Dance  tango tanogrn qgoreng",
//     practicedTime: "00:34:12",
//     goal: "1:00:00 Daily",
//     lorem: "lorem epsum dolor",
//   ),
// ];

// List<HabitCard> finishedCards = [
//   HabitCard(
//       completed: true,
//       name: "Meditation",
//       practicedTime: "1:24:12",
//       goal: "1:00:00 Daily",
//       lorem: "lorem epsum dolor"),
//   HabitCard(
//       completed: true,
//       name: "Run 21 miles",
//       practicedTime: "3:14:12",
//       goal: "2:00:00 Daily",
//       lorem: "lorem epsum dolor"),
//   HabitCard(
//       completed: true,
//       name: "Naked Twister",
//       practicedTime: "4:15:11",
//       goal: "3:00:00 Daily",
//       lorem: "lorem epsum dolor"),
//   HabitCard(
//       completed: true,
//       name: "Naked Twister",
//       practicedTime: "4:15:11",
//       goal: "3:00:00 Daily",
//       lorem: "lorem epsum dolor"),
//   HabitCard(
//       completed: true,
//       name: "Naked Twister",
//       practicedTime: "4:15:11",
//       goal: "3:00:00 Daily",
//       lorem: "lorem epsum dolor"),
// ];
