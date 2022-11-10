import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TasksNaoFeitasView extends StatefulWidget {
  const TasksNaoFeitasView({super.key});

  @override
  State<TasksNaoFeitasView> createState() => _TasksNaoFeitasViewState();
}

class _TasksNaoFeitasViewState extends State<TasksNaoFeitasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks Nao Feitas'),
      ),
      body: const Center(
        child: Text('Tasks Nao Feitas'),
      ),
    );
  }
}