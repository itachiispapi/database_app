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
      debugShowCheckedModeBanner: false,
      title: 'Database Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.light,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const double buttonSpacing = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite CRUD Demo'
            , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromARGB(255, 121, 54, 255),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9FACE6), Color(0xFF74EBD5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 10,
            color: const Color.fromARGB(165, 255, 255, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  _buildButton(context, 'Insert', const Color.fromARGB(255, 121, 54, 255), _insert),
                  const SizedBox(height: buttonSpacing),
                  _buildButton(context, 'Query', const Color.fromARGB(255, 113, 129, 236), _query),
                  const SizedBox(height: buttonSpacing),
                  _buildButton(context, 'Update', const Color.fromARGB(255, 142, 197, 255), _update),
                  const SizedBox(height: buttonSpacing),
                  _buildButton(context, 'Delete', const Color.fromARGB(255, 145, 228, 254), _delete),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildButton(
      BuildContext context, String label, Color color, Function() onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }

  static void _insert() async {
    final row = {
      DatabaseHelper.columnName: 'Anakin Skywalker',
      DatabaseHelper.columnAge: 23,
    };
    final id = await dbHelper.insert(row);
    debugPrint('Inserted row id: $id');
  }

  static void _query() async {
    final rows = await dbHelper.queryAllRows();
    debugPrint('All rows:');
    for (final row in rows) {
      debugPrint(row.toString());
    }
  }

  static void _update() async {
    final row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnName: 'Padme Amidala',
      DatabaseHelper.columnAge: 32,
    };
    final updated = await dbHelper.update(row);
    debugPrint('Updated $updated row(s)');
  }

  static void _delete() async {
    final id = await dbHelper.queryRowCount();
    final deleted = await dbHelper.delete(id);
    debugPrint('Deleted $deleted row(s) with id $id');
  }
}
