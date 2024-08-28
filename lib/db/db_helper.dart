import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/tasks.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            taskdes TEXT,
            isDone INTEGER
          )
          ''',
        );
      },
    );
  }

  Future<int> insertTask(Tasks task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Tasks>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Tasks(
        id: maps[i]['id'],
        taskdes: maps[i]['taskdes'],
        isDone: maps[i]['isDone'] == 1,
      );
    });
  }

  Future<int> updateTask(Tasks task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
