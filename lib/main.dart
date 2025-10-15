import 'package:flutter/material.dart';
import 'database_helper.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('sqflite')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: _insert, child: const Text('insert')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _query, child: const Text('query')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _update, child: const Text('update')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _delete, child: const Text('delete')),
          ],
        ),
      ),
    );
  }

  static void _insert() async {
    final row = {
      DatabaseHelper.columnName: 'Anakin Skywalker',
      DatabaseHelper.columnAge: 23,
    };
    final id = await dbHelper.insert(row);
    debugPrint('inserted row id: $id');
  }

  static void _query() async {
    final allRows = await dbHelper.queryAllRows();
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

// will update later
  static void _update() async {}
  static void _delete() async {}
}
