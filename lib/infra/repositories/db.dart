// ignore_for_file: avoid_print

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/infra/tables/table_task_feitas_nao_feitas.dart';
import 'package:todo/infra/tables/table_task_todas.dart';

import '../tables/table_task_feitas.dart';

class DB {
  static const String databaseName = "todo_list.db";
  static Database? db;

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await initizateDb();
  }

  static Future<Database> initizateDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } on FileSystemException catch (e) {
        print(e.toString());
      }
      await openDatabase(
        path,
        version: 1,
      );
    }
    db = await openDatabase(path, readOnly: false);

    return db ??
        await openDatabase(
          path,
          version: 1,
          onCreate: (Database db, int version) async {
            await createTables(db);
          },
        );
  }

  static Future<void> createTables(Database database) async {}

  static Future<void> createTableTaskTodas() async {
    await TabelaTaskTodas.createTable(db!);
  }

  static Future<void> createTableTaskFeitas() async {
    await TabelaTaskFeitas.createTable(db!);
  }

  static Future<void> createTableTaskNaoFeitas() async {
    await TabelaTaskNaoFeitas.createTable(db!);
  }

  // verificar se tabela existe
  static Future<bool> tableChecker(String nameTable) async {
    var table = await db!.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='$nameTable'");
    return table.isNotEmpty; // retorna true se a tabela existe
  }
}
