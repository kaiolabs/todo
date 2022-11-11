// ignore_for_file: avoid_print

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/infra/models/teks.dart';
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

  // adicionar uma nova task na tabela task_todas
  static Future<void> addTaskTodas(String title, String description) async {
    await db!.insert(
      'TASKSTODAS',
      {
        'TITLE': title,
        'DESCRIPTION': description,
      },
    );
  }

  // adicionar uma nova task na tabela task_feitas
  static Future<void> addTaskFeitas(String title, String description) async {
    await db!.insert(
      'TASKSFEITAS',
      {
        'TITLE': title,
        'DESCRIPTION': description,
      },
    );
  }

  // adicionar uma nova task na tabela task_nao_feitas
  static Future<void> addTaskNaoFeitas(String title, String description) async {
    await db!.insert(
      'TASKSNAOFEITAS',
      {
        'TITLE': title,
        'DESCRIPTION': description,
      },
    );
  }

  // pegar todas as tasks da tabela task_todas
  static Future<List<Task>> getTasksTodas() async {
    final List<Map<String, dynamic>> maps = await db!.query('TASKSTODAS');

    return List.generate(maps.length, (i) {
      return Task(
        title: maps[i]['TITLE'],
        description: maps[i]['DESCRIPTION'],
      );
    });
  }

  // pegar todas as tasks da tabela task_feitas
  static Future<List<Task>> getTasksFeitas() async {
    final List<Map<String, dynamic>> maps = await db!.query('TASKSFEITAS');

    return List.generate(maps.length, (i) {
      return Task(
        title: maps[i]['TITLE'],
        description: maps[i]['DESCRIPTION'],
      );
    });
  }

  // pegar todas as tasks da tabela task_nao_feitas
  static Future<List<Task>> getTasksNaoFeitas() async {
    final List<Map<String, dynamic>> maps = await db!.query('TASKSNAOFEITAS');

    return List.generate(maps.length, (i) {
      return Task(
        title: maps[i]['TITLE'],
        description: maps[i]['DESCRIPTION'],
      );
    });
  }
}
