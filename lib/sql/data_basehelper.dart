import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  late Database database;
  static String tableName = "user";
  init() async {
// Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'db_crud.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, name TEXT, content TEXT, Description TEXT)');
    });
  }

  Future<void> insert(Map<String, dynamic> row) async {
    database.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> query() {
    return database.query(tableName);
  }

  Future<void> update(Map<String, dynamic> row) async {
    int id = row["id"];
    database.update(tableName, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> delet(int id) async {
    database.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
