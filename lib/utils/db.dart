// db manager
import 'package:habit_maker/model/habit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static final DB instance = DB._init();

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
    final requiredText = "TEXT NOT NULL";
    final text = "TEXT";

    await db.execute('''
    CREATE TABLE $tableHabits(
      ${HabitField.id} $idType,
      ${HabitField.name} $requiredText,
      ${HabitField.description} $text,
      ${HabitField.frequency} $requiredText,
      ${HabitField.practiceDuration} $requiredText,
      ${HabitField.targetDuration} $requiredText,
    )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  DB._init();
}
