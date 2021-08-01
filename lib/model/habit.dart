final String tableHabits = "habits";

class HabitField {
  static final String id = "_id";
  static final String name = "name";
  static final String frequency = "frequency";
  static final String practiceDuration = "practiceDuration";
  static final String targetDuration = "targetDuration";
  static final String description = "description";
}

class Habit {
  final String name;
  final String description;
  final String frequency;
  final Duration practiceDuration;
  final Duration targetDuration;

  Habit(this.name, this.description, this.frequency, this.practiceDuration,
      this.targetDuration);
}
