import 'package:flutter/material.dart';

class TasksFeitasView extends StatefulWidget {
  const TasksFeitasView({super.key});

  @override
  State<TasksFeitasView> createState() => _TasksFeitasViewState();
}

class _TasksFeitasViewState extends State<TasksFeitasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks Feitas'),
      ),
      
      body: const Center(
        child: Text('Tasks Feitas'),
      ),
    );
  }
}
