final String tableHabits = "habits";

class HabitField {
  static final String id = "_id";
  static final String name = "name";
  static final String frequency = "frequency";
  static final String practiceDuration = "practiceDuration";
  static final String targetDuration = "targetDuration";
  static final String description = "description";

  static final List<String> values = [
    id,
    name,
    frequency,
    practiceDuration,
    targetDuration,
    description
  ];
}

class Habit {
  final int? id;
  final String name;
  final String description;
  final String frequency;
  final Duration practiceDuration;
  final Duration targetDuration;

  Habit copy(
          {int? id,
          String? name,
          String? description,
          String? frequency,
          Duration? practiceDuration,
          Duration? targetDuration}) =>
      Habit(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        frequency: frequency ?? this.frequency,
        practiceDuration: practiceDuration ?? this.practiceDuration,
        targetDuration: targetDuration ?? this.targetDuration,
      );

  Habit(
      {this.id,
      required this.name,
      required this.description,
      required this.frequency,
      required this.practiceDuration,
      required this.targetDuration});

  static Habit fromJson(Map<String, Object?> json) => Habit(
      name: json[HabitField.name] as String,
      description: json[HabitField.description] as String,
      frequency: json[HabitField.frequency] as String,
      practiceDuration:
          Duration(seconds: json[HabitField.practiceDuration] as int),
      targetDuration:
          Duration(seconds: json[HabitField.targetDuration] as int));

  Map<String, Object?> toJson() => {
        HabitField.id: id,
        HabitField.name: name,
        HabitField.description: description,
        HabitField.frequency: frequency,
        HabitField.practiceDuration: practiceDuration.inSeconds.toString(),
        HabitField.targetDuration: targetDuration.inSeconds.toString(),
      };
}
