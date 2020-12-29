import 'package:flutter_app/models/note-item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DatabaseName = "simple_note_app_demo.db";
const TableName = "notes";

class DataAccess {
  static Future<void> addNote(NoteItem note) async {
    final Database db = await _openDb();

    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      TableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<NoteItem>> getAllWithoutContent() async {
    final Database db = await _openDb();

    final List<Map<String, dynamic>> maps = await db.query(TableName);

    return List.generate(maps.length, (i) {
      return NoteItem(
        id: maps[i]['id'],
        title: maps[i]['title']
      );
    });
  }

  static Future<Database> _openDb() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), DatabaseName),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $TableName(id INTEGER PRIMARY KEY, title TEXT, content TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    return database;
  }
}
