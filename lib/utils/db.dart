// db manager
import 'package:habit_maker/model/habit.dart';
import 'package:habit_maker/model/timer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';


class DB {
  static final DB instance = DB._initDB();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('habits.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final requiredInt = "INTEGER NOT NULL";
    final requiredText = "TEXT NOT NULL";
    final text = "TEXT";

    await db.execute('''
    CREATE TABLE $tableHabits(
      ${HabitField.id} $idType,
      ${HabitField.name} $requiredText,
      ${HabitField.description} $text,
      ${HabitField.frequency} $requiredText,
      ${HabitField.practiceDuration} $requiredText,
      ${HabitField.targetDuration} $requiredText
    )
    CREATE TABLE $tableTimer(
      ${TimerField.id} $idType,
      ${TimerField.habitId} $requiredInt,
      ${TimerField.startTime} $text,
      ${TimerField.endTime} $text,
      ${TimerField.status} $requiredInt
    )
    ''');
  }

  Future<Habit> createHabit(Habit habit) async {
    final db = await instance.database;
    final id = await db.insert(tableHabits, habit.toJsonInsert());
    habit = habit.copy(newId: id);
    return habit;
  }

  Future<HabitTimer> createTimer(HabitTimer timer) async {
    final db = await instance.database;
    final id = await db.insert(tableTimer, timer.toJsonInsert());
    timer = timer.copy(id: id);
    return timer;
  }

  Future<Habit?> readHabit(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableHabits,
        columns: HabitField.values,
        where: "${HabitField.id} = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) return Habit.fromJson(maps.first);
    return null;
  }

  Future<HabitTimer?> getHabitTimer(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableHabits,
        columns: TimerField.values,
        where: "${TimerField.id} = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) return HabitTimer.fromJson(maps.first);
    return null;
  }

  Future<List<Habit>> readAllHabits() async {
    final db = await instance.database;
    final result = await db.query(tableHabits);
    return result.map((json) => Habit.fromJson(json)).toList();
  }

  Future<List<HabitTimer>?> getHabitTimers(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableTimer,
        columns: TimerField.values,
        where: "${TimerField.habitId} = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      final timers = maps.map((timer) => HabitTimer.fromJson(timer)).toList();
      return timers;
    }
    return null;
  }

  Future<List<HabitTimer>?> getTimerByDate(DateTime date) async {
    final db = await instance.database;
    final result = await db.query(tableTimer);
    final timerList = result.map((json) => HabitTimer.fromJson(json)).toList();
    final timers = timerList
        .map((timer) =>
            timer.startTime?.difference(date).inDays == 0 ? timer : null)
        .whereNotNull()
        .toList();
    if (timers.isNotEmpty) return timers;
    return null;
  }

  Future<int> updateHabit(Habit habit) async {
    final db = await instance.database;
    return db.update(tableHabits, habit.toJson(),
        where: "${HabitField.id} = ?", whereArgs: [habit.id]);
  }

  Future<int> updateHabitTimer(HabitTimer htimer) async {
    final db = await instance.database;
    return db.update(tableTimer, htimer.toJson(),
        where: "${TimerField.id} = ?", whereArgs: [htimer.id]);
  }

  Future<int> deleteHabit(int id) async {
    final db = await instance.database;
    return db
        .delete(tableHabits, where: "${HabitField.id} = ?", whereArgs: [id]);
  }

  Future<int> deleteHabitTimer(int id) async {
    final db = await instance.database;
    return db
        .delete(tableTimer, where: "${TimerField.id} = ?", whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  DB._initDB();
}
