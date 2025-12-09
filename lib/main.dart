import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'db/habit_db.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HabitDb.init();
  runApp(const HabitPulseApp());
}

class HabitPulseApp extends StatelessWidget {
  const HabitPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HabitPulse",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true
      ),
      home: HomeScreen(),
    );
  }
}
