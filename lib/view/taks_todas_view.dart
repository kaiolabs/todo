import 'package:flutter/material.dart';

class TasksTodasView extends StatefulWidget {
  const TasksTodasView({super.key});

  @override
  State<TasksTodasView> createState() => _TasksTodasViewState();
}

class _TasksTodasViewState extends State<TasksTodasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks Todas'),
      ),
      body: const Center(
        child: Text('Tasks Todas'),
      ),
    );
  }
}
