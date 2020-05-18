import 'dart:io';

import 'package:acharlarim/models/credential.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const TABLE = 'credential';
  static const COL_ID = 'id';
  static const COL_ICON = 'icon';
  static const COL_TITLE = 'title';
  static const COL_KEY = 'key';

  static DatabaseService _databaseService;
  static Database _database;

  DatabaseService._createInstance();

  factory DatabaseService() {
    if (_databaseService == null) {
      _databaseService = DatabaseService._createInstance();
    }
    return _databaseService;
  }

  Future<Database> get database async {
    if (_database == null) _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "acharlar.db";
    return await openDatabase(path, version: 1, onCreate: createDatabase);
  }

  void createDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE($COL_ID INTEGER PRIMARY KEY AUTOINCREMENT, $COL_ICON INTEGER, $COL_TITLE TEXT, $COL_KEY TEXT);");
  }

  Future<List<Credential>> getCredentialList() async {
    Database db = await this.database;
    List<Map<String, dynamic>> credentialsMap = await db.query(TABLE);
    List<Credential> credentials = List<Credential>();
    for (int i = 0; i < credentialsMap.length; i++) {
      credentials.add(Credential.fromMap(credentialsMap[i]));
    }
    return credentials;
  }

  Future<int> insert(Credential credential) async {
    Database db = await this.database;
    return await db.insert(TABLE, credential.toMap());
  }

  Future<int> delete(int id) async {
    Database db = await this.database;
    return await db.delete(TABLE, where: "id = ?", whereArgs: [id]);
  }
}
