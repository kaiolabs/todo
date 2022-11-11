import 'package:flutter/material.dart';
import 'package:todo/infra/repositories/db.dart';

class TasksTodasView extends StatefulWidget {
  final ValueNotifier<bool> isNovaTask;
  const TasksTodasView({super.key, required this.isNovaTask});

  @override
  State<TasksTodasView> createState() => _TasksTodasViewState();
}

class _TasksTodasViewState extends State<TasksTodasView> {
  final List _list = [];

  @override
  void initState() {
    super.initState();
    DB.getTasksTodas().then((value) {
      setState(() {
        _list.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(children: [
        ValueListenableBuilder(
          valueListenable: widget.isNovaTask,
          builder: (context, value, child) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: const BoxConstraints(minWidth: 30),
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _list[index].title,
                              style: const TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _list[index].description,
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ]),
    );
  }
}
