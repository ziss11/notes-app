import 'package:sqflite/sqflite.dart';
import 'package:viapulsa_test/data/models/note_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  static const String _tblCache = 'cache';

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE $_tblCache (
        id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        createdAt TEXT,
        updatedAt TEXT
      );''',
    );
  }

  Future<Database> _initializeDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/viapulsa_test.db';

    final db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );

    return db;
  }

  Future<void> insertCacheTransaction(List<NoteModel> notes) async {
    final db = await database;
    for (var note in notes) {
      await db!.insert(
        _tblCache,
        note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getCachedNotes() async {
    final db = await database;
    final results = await db!.query(_tblCache);
    return results;
  }

  Future<int> clearCache() async {
    final db = await database;
    return await db!.delete(
      _tblCache,
      where: null,
      whereArgs: null,
    );
  }
}
