import 'package:flutter/material.dart';
import 'package:todo/view/home.dart';
import 'package:todo/infra/repositories/db.dart';

import 'infra/services/create_tables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.initizateDb();
  await CreateTables.createTables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(primarySwatch: Colors.blue), home: const Home());
  }
}
