import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoey_flutter/screens/tasks.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/taskData.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'models/tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);
  // Hive.registerAdapter(TasksAdapter()); // Register your TypeAdapter
  // //await Hive.initFlutter();
  // await Hive.openBox<List>('myBox'); // Opening a Hive box
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: TaskScreen(),
      ),
    );
  }
}
