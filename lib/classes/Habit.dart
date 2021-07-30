import 'package:flutter/material.dart';

class Habit {
  String name, description, frequency;
  int hours, minutes;

  Habit({
    required this.name,
    required this.description,
    required this.frequency,
    required this.hours,
    required this.minutes,
  });

  Habit.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        hours = json['hours'],
        minutes = json['minutes'],
        frequency = json['frequency'];

  //debug
  printDate() {
    print("$name, $description, $frequency, $hours, $minutes");
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'frequency': frequency,
        'hours': hours,
        'minutes': minutes,
      };
}
