import 'package:flutter/material.dart';
import 'package:todo/infra/repositories/db.dart';
import 'package:todo/view/components/input_drop_down.dart';
import 'package:todo/view/components/input_field.dart';
import 'package:todo/view/taks_feitas_view.dart';
import 'package:todo/view/taks_nao_feitas_view.dart';
import 'package:todo/view/taks_todas_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);
  final PageController _pageController = PageController();
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerDropDown = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _dropDownItems = <String>['Todos', 'Feitas', 'Não Feitas'];
  ValueNotifier<bool> isNovaTaskTodas = ValueNotifier<bool>(false);
  ValueNotifier<bool> isNovaTaskFeitas = ValueNotifier<bool>(false);
  ValueNotifier<bool> isNovaTaskNaoFeitas = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // abrir um modal para adicionar uma nova task

          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 50, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Adicionar nova task', style: TextStyle(fontSize: 20)),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                              child: InputField(
                                controller: _controllerTitle,
                                label: 'Título',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: InputField(
                                controller: _controllerDescription,
                                label: 'Descrição',
                              ),
                            ),
                            InputDropDown(
                              controller: _controllerDropDown,
                              list: _dropDownItems,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_controllerDropDown.text == 'Todos') {
                                  DB.addTaskTodas(_controllerTitle.text, _controllerDescription.text);
                                  isNovaTaskTodas.value = !isNovaTaskTodas.value;
                                } else if (_controllerDropDown.text == 'Feitas') {
                                  DB.addTaskFeitas(_controllerTitle.text, _controllerDescription.text);
                                  isNovaTaskFeitas.value = !isNovaTaskFeitas.value;
                                } else if (_controllerDropDown.text == 'Não Feitas') {
                                  DB.addTaskNaoFeitas(_controllerTitle.text, _controllerDescription.text);
                                  isNovaTaskNaoFeitas.value = !isNovaTaskNaoFeitas.value;
                                }
                                _controllerTitle.clear();
                                _controllerDescription.clear();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Task adicionada com sucesso!'),
                                  ),
                                );

                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Adicionar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _index,
        builder: (context, index, child) {
          return BottomNavigationBar(
            currentIndex: _index.value,
            onTap: (int index) {
              _index.value = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Todas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box),
                label: 'Feitas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box_outline_blank),
                label: 'Não Feitas',
              ),
            ],
          );
        },
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int index) => _index.value = index,
        children: [
          TasksTodasView(isNovaTask: isNovaTaskTodas),
          TasksFeitasView(isNovaTask: isNovaTaskFeitas),
          TasksNaoFeitasView(isNovaTask: isNovaTaskNaoFeitas),
        ],
      ),
    );
  }
}
