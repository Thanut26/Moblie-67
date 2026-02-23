import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get db async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'databaseapp.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tbUsers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT
      )
    ''');
  }

  Future<int> insertUser(User user) async {
    final db = await instance.db;
    return await db.insert('tbUsers', user.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    final db = await instance.db;
    return await db.query('tbUsers');
  }

  Future<int> updateUser(User user) async {
    final db = await instance.db;
    return await db.update(
      'tbUsers',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.db;
    return await db.delete(
      'tbUsers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllUsers() async {
    final db = await instance.db;
    await db.delete('tbUsers');
  }
}
