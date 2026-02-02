import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user.dart';

class DatabaseHelper {
  // Singleton
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Get database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Create database
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'databaseapp.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Create table
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tbUsers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
  }

  // ================= CRUD =================

  // INSERT
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(
      'tbUsers',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // SELECT ALL
  Future<List<User>> getAllUsers() async {
    final db = await database;
    final result = await db.query(
      'tbUsers',
      orderBy: 'id DESC',
    );
    return result.map((e) => User.fromMap(e)).toList();
  }

  // UPDATE
  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      'tbUsers',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // DELETE ONE
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'tbUsers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE ALL
  Future<int> deleteAllUsers() async {
    final db = await database;
    return await db.delete('tbUsers');
  }

  // CLOSE DB (optional)
  Future close() async {
    final db = await database;
    db.close();
  }
}
