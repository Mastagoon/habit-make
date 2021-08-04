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
      {int? newId,
      String? name,
      String? description,
      String? frequency,
      Duration? practiceDuration,
      Duration? targetDuration}) {
    print("recieved id: $newId");
    return Habit(
      id: newId,
      name: name ?? this.name,
      description: description ?? this.description,
      frequency: frequency ?? this.frequency,
      practiceDuration: practiceDuration ?? this.practiceDuration,
      targetDuration: targetDuration ?? this.targetDuration,
    );
  }

  Habit(
      {this.id,
      required this.name,
      required this.description,
      required this.frequency,
      required this.practiceDuration,
      required this.targetDuration});

  static Habit fromJson(Map<String, Object?> json) => Habit(
      id: json[HabitField.id] as int,
      name: json[HabitField.name] as String,
      description: json[HabitField.description] as String,
      frequency: json[HabitField.frequency] as String,
      practiceDuration: Duration(
          seconds: int.parse(json[HabitField.practiceDuration] as String)),
      targetDuration: Duration(
          seconds: int.parse(json[HabitField.targetDuration] as String)));

  Map<String, Object?> toJson() => {
        HabitField.id: id,
        HabitField.name: name,
        HabitField.description: description,
        HabitField.frequency: frequency,
        HabitField.practiceDuration: practiceDuration.inSeconds.toString(),
        HabitField.targetDuration: targetDuration.inSeconds.toString(),
      };
  Map<String, Object?> toJsonInsert() => {
        HabitField.name: name,
        HabitField.description: description,
        HabitField.frequency: frequency,
        HabitField.practiceDuration: practiceDuration.inSeconds.toString(),
        HabitField.targetDuration: targetDuration.inSeconds.toString(),
      };
}
