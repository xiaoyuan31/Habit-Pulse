import 'package:flutter/material.dart';
import 'package:habitplus/screens/add_habit_screen.dart';
import '../db/habit_db.dart';
import '../models/habit.dart';

class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Habit> habits = [];

  @override
  void initState() {
    super.initState();
    loadHabits();
  }

  void loadHabits() {
    final stored = HabitDb.getHabits();
    habits = stored.map<Habit>((e) => Habit.fromJson(Map<String, dynamic>.from(e))).toList();
    setState(() {});
  }

  void toggleHabit(Habit habit) {
    setState(() {
      habit.doneToday = !habit.doneToday;
      if (habit.doneToday) {
        habit.streak++;
      } else {
        habit.streak = (habit.streak > 0) ? habit.streak - 1 : 0;
      }
      saveAll();
    });
  }

  void saveAll() {
    HabitDb.saveHabits(habits.map((e) => e.toJson()).toList());
  }


  // Card Widget
  Widget habitCard(Habit h) {

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: h.doneToday ? Color(h.color).withOpacity(0.15) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 6)
            )
          ],
          border: Border.all(
              color: h.doneToday ? Color(h.color) : Colors.grey.shade200
          )
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                color: Color(h.color),
                borderRadius: BorderRadius.circular(12)
            ),
            child: const Icon(Icons.check, color: Colors.white,),
          ),
          const SizedBox(width: 20,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                h.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight:  FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4,),
              Text(
                "Streak : ${h.streak}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              )
            ],
          )),
          GestureDetector(
            onTap: () => toggleHabit(h),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: h.doneToday ? Color(h.color) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(14)
              ),
              child: Icon(
                h.doneToday ? Icons.check : Icons.circle_outlined,
                color: h.doneToday ? Colors.white : Colors.grey.shade500,
                size: 22,
              ),
            ),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        title: const Text(
          "HabitPulse",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.tealAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      )
        ,
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.teal, Colors.tealAccent]),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6)
            ),
          ],
        ),
        child: FloatingActionButton(onPressed: () async {
          final newHabit = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddHabitScreen()));
          if (newHabit != null) {
            habits.add(newHabit);
            saveAll();
            setState(() {});
          }
        },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, size: 30),
        ),
      ),
      body: habits.isEmpty
          ? const Center(
              child: Text(
                "No habits yet.\nTap + to add one!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            )
          : ListView(
        children: habits.map((h) => habitCard(h)).toList(),
      )
    );
  }
}




