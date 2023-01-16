import 'package:sqflite/sqflite.dart';

import '../models/reminder_model.dart';
import '../models/water_reminder_model.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _remindersTableName = "reminders";
  static final String _waterReminderTableName = "waterReminders";

  static Future<void> initDb() async {
    String _path = await getDatabasesPath() + 'reminders.db';

    deleteDatabase(_path);

    _db = await openDatabase(
      _path,
      version: _version,
      onCreate: _onCreate,
    );
  }

  static Future<void> deleteDatabase(String path) async {
    print("deleting");
    databaseFactory.deleteDatabase(path);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $_remindersTableName("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "title STRING, reminder TEXT, date STRING, "
      "time STRING, remindBefore STRING, repeat STRING, "
      "interval INTEGER, color STRING, isReminded STRING, label STRING)",
    );
    await db.execute(
      "CREATE TABLE $_waterReminderTableName("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "goal DOUBLE, date STRING, "
      "remindPeriod INTEGER, isValid INTEGER, totalDrink DOUBLE)",
    );
  }

  //Reminder Functions
  static Future<int> insert(Reminder? reminder) async {
    print("insert function called");
    return await _db?.insert(_remindersTableName, reminder!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("reminder query function called");
    return await _db!.query(_remindersTableName);
  }

  static delete(Reminder reminder) async {
    await _db!
        .delete(_remindersTableName, where: 'id=?', whereArgs: [reminder.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
    UPDATE reminders
    SET isCompleted = ?
    WHERE id =?
    ''', [1, id]);
  }
  //Water Reminder Functions

  static Future<List<Map<String, dynamic>>> waterReminderQuery() async {
    print("water query function called");
    return await _db!.query(_waterReminderTableName);
  }

  static Future<int> waterReminderInsert(WaterReminder? waterReminder) async {
    print("insert function called");
    return await _db?.insert(
            _waterReminderTableName, waterReminder!.toJson()) ??
        1;
  }

  static waterReminderAddDrink(int id, double drinkAmount) async {
    print("update");
    return await _db!.rawUpdate('''
    UPDATE waterReminders
    SET totalDrink = ?
    WHERE id =?
    ''', [drinkAmount, id]);
  }
}
