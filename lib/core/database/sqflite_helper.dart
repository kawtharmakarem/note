import 'dart:developer';
import 'dart:io';

import '/core/database/tables.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const String DB_NAME = "noteDB.db";
  Database? myDB;
  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String path = join(appDir.path, DB_NAME);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(Tables.userQuery);
        await db.execute(Tables.folderQuery);
        await db.execute(Tables.noteQuery);
        await db.execute(Tables.blogQuery);
        await db.execute(Tables.todoQuery);
        log("Database created successfully ............!");
      },
    );
  }
}
