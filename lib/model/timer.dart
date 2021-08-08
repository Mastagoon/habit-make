final String tableTimer = "timers";

class TimerField {
  static final String id = "_id";
  static final String habitId = "habit_id";
  static final String startTime = "start_time";
  static final String endTime = "end_time";
  static final String isActive = "isActive";

  static final List<String> values = [
    id,
    habitId,
    startTime,
    endTime,
    isActive,
  ];
}

class HabitTimer {
  final int? id;
  final int? habitId;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool? isActive;

  HabitTimer(
      {this.id,
      required this.habitId,
      required this.startTime,
      this.endTime,
      required this.isActive});

  HabitTimer copy({
    int? id,
    int? habitId,
    DateTime? startTime,
    DateTime? endTime,
    bool? isActive,
  }) =>
      HabitTimer(
          id: id ?? this.id,
          habitId: habitId ?? this.habitId,
          startTime: startTime ?? this.startTime,
          endTime: endTime ?? this.endTime,
          isActive: isActive ?? this.isActive);

  static HabitTimer fromJson(Map<String, Object?> json) => HabitTimer(
      id: json[TimerField.id] as int,
      habitId: json[TimerField.habitId] as int,
      startTime: DateTime.fromMillisecondsSinceEpoch(
          int.parse(json[TimerField.startTime] as String)),
      endTime: DateTime.fromMillisecondsSinceEpoch(
          int.parse(json[TimerField.endTime] as String)),
      isActive: json[TimerField.isActive] == 0 ? false : true);

  Map<String, Object?> toJson() => {
        TimerField.id: id,
        TimerField.habitId: habitId,
        TimerField.startTime: startTime?.millisecondsSinceEpoch.toString(),
        TimerField.endTime: endTime?.millisecondsSinceEpoch.toString(),
        TimerField.isActive: isActive == true ? 1 : 0
      };
  Map<String, Object?> toJsonInsert() => {
        TimerField.habitId: habitId,
        TimerField.startTime: startTime?.millisecondsSinceEpoch.toString(),
        TimerField.endTime: endTime?.millisecondsSinceEpoch.toString(),
        TimerField.isActive: isActive == true ? 1 : 0
      };
}
