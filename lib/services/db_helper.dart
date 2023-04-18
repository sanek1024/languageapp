import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> getDatabase() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocDir.path, 'language_learning_app.db');

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }

  static Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE dictionaries (
        id TEXT PRIMARY KEY,
        name TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE words (
        id TEXT PRIMARY KEY,
        dictionary_id TEXT,
        word TEXT,
        translation TEXT,
        FOREIGN KEY (dictionary_id) REFERENCES dictionaries (id) ON DELETE CASCADE
      )
    ''');
  }
}
