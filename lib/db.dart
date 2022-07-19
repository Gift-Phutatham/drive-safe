import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:drive_safe/record_model.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static Database? _database;

  Future<Database> get database async => _database ??= await initDB();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "record_db.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Record ("
          "_id INTEGER,"
          "accident_date TEXT,"
          "accident_time TEXT,"
          "expw_step TEXT,"
          "weather_state TEXT,"
          "injur_man int,"
          "injur_femel int,"
          "dead_man int,"
          "dead_femel int,"
          "cause TEXT"
          ")");
    });
  }

  Future<void> insertRecord(Record record) async {
    Database db = await database;
    await db.insert("Record", record.toJson());
  }

  Future<List<Map<String, dynamic>>> getAllRecords() async {
    Database db = await database;
    return await db.query("Record");
  }

  Future<List<Map<String, dynamic>>> getRecordByExpw(String expw) async {
    Database db = await database;
    return await db.query("Record", where: 'expw_step = ?', whereArgs: [expw]);
  }

  Future<int> deleteAllRecords() async {
    Database db = await database;
    return await db.delete("Record");
  }
}
