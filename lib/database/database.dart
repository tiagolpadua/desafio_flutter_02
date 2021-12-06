import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._privateConstructor();

  /// Evita que a classe seja instânciada mais de uma vez
  static final DBProvider instance = DBProvider._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ?? await initDB();

  /// Esse método é responsável por inicializar o banco de dados
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "TestDB1.db";

    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE favorites ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "character_name TEXT UNIQUE"
          ")");
    });
  }
}