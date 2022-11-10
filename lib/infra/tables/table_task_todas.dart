import 'package:sqflite/sqflite.dart';

import '../enums/db_types_variables.dart';

// O aplicativo deve ser capaz de criar tarefas que contenham titulo, descrição e uma data de expiração.

class TabelaTaskTodas {
  static Future createTable(Database db) async {
    await db.execute('''CREATE TABLE TASKSTODAS (
        ID ${DBTypesVariables.idType.name},
        TITLE ${DBTypesVariables.varcharType.name},
        DESCRIPTION ${DBTypesVariables.varcharType.name}
      )''');
  }
}
