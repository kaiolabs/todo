import '../repositories/db.dart';

class CreateTables {
  static taksTodas() async {
    final userDados = await DB.tableChecker('TASKSTODAS');
    if (userDados == false) {
      await DB.createTableTaskTodas();
    }
  }

  static taksNaoFeitas() async {
    final userDados = await DB.tableChecker('TASKSNAOFEITAS');
    if (userDados == false) {
      await DB.createTableTaskNaoFeitas();
    }
  }

  static taksFeitas() async {
    final userDados = await DB.tableChecker('TASKSFEITAS');
    if (userDados == false) {
      await DB.createTableTaskFeitas();
    }
  }

  static createTables() async {
    await taksTodas();
    await taksNaoFeitas();
    await taksFeitas();
  }
}
