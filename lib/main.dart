import 'package:flutter/material.dart';
import 'package:todolistapp/screens/add_task/add_task.dart';
import 'package:todolistapp/screens/main_screen/main_screen.dart';
import 'package:todolistapp/utils/app_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondary),
        useMaterial3: true,
      ),
      home: const MainScreen(),
      routes: {
        '/AddTaskScreen': (context) => const AddTaskScreen(),
      },
    );
  }
}


// MainScreen