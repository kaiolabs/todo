import 'package:todo/infra/enums/db_types_variables.dart';

extension DBTypesVariablesExtension on DBTypesVariables {
  String get name {
    switch (this) {
      case DBTypesVariables.idType:
        return 'INTEGER PRIMARY KEY AUTOINCREMENT';
      case DBTypesVariables.varcharType:
        return 'VARCHAR(250) DEFAULT \'\'';
      case DBTypesVariables.booleanType:
        return 'BOOLEAN DEFAULT FALSE';
      case DBTypesVariables.intType:
        return 'INT DEFAULT 0';
      case DBTypesVariables.doubleType:
        return 'DOUBLE DEFAULT 0.0';
      case DBTypesVariables.charType:
        return 'CHAR(10) DEFAULT \'\'';
      case DBTypesVariables.dateType:
        return 'DATE';
      case DBTypesVariables.dateTimeType:
        return 'DATETIME';
      case DBTypesVariables.textType:
        return 'TEXT';
    }
  }
}
