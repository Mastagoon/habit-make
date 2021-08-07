final String tableTimer = "timers";

class TimerField {
  static final String id = "_id";
  static final String habitId = "habit_id";
  static final String startTime = "start_time";
  static final String endTime = "end_time";
  static final String status = "status";

  static final List<String> values = [
    id,
    habitId,
    startTime,
    endTime,
    status,
  ];
}

class HabitTimer {
  final int? id;
  final int? habitId;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool? status;

  HabitTimer(
      {this.id,
      required this.habitId,
      required this.startTime,
      this.endTime,
      required this.status});

  HabitTimer copy({
    int? id,
    int? habitId,
    DateTime? startTime,
    DateTime? endTime,
    bool? status,
  }) =>
      HabitTimer(
          id: id ?? this.id,
          habitId: habitId ?? this.habitId,
          startTime: startTime ?? this.startTime,
          endTime: endTime ?? this.endTime,
          status: status ?? this.status);

  static HabitTimer fromJson(Map<String, Object?> json) => HabitTimer(
      id: json[TimerField.id] as int,
      habitId: json[TimerField.habitId] as int,
      startTime: DateTime.fromMillisecondsSinceEpoch(
          int.parse(json[TimerField.startTime] as String)),
      endTime: DateTime.fromMillisecondsSinceEpoch(
          int.parse(json[TimerField.endTime] as String)),
      status: json[TimerField.status] == 0 ? false : true);

  Map<String, Object?> toJson() => {
        TimerField.id: id,
        TimerField.habitId: habitId,
        TimerField.startTime: startTime?.millisecondsSinceEpoch.toString(),
        TimerField.endTime: endTime?.millisecondsSinceEpoch.toString(),
        TimerField.status: status == true ? 1 : 0
      };
  Map<String, Object?> toJsonInsert() => {
        TimerField.habitId: habitId,
        TimerField.startTime: startTime?.millisecondsSinceEpoch.toString(),
        TimerField.endTime: endTime?.millisecondsSinceEpoch.toString(),
        TimerField.status: status == true ? 1 : 0
      };
}
