import 'package:flutter/material.dart';
import '../models/habit.dart';

class AddHabitScreen  extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<StatefulWidget> createState()  => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final nameCtrl = TextEditingController();
  Color selectedColor = Colors.teal;
  IconData selectedIcon = Icons.star;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Habit"),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Habit Name"),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                const Text("Color: "),
                const SizedBox(width: 10,),
                CircleAvatar(
                  backgroundColor: selectedColor,
                ),
                IconButton(onPressed: () async {
                  final color = await showDialog<Color>(context: context, builder: (_) =>
                  AlertDialog(
                    title: const Text("Pick Color"),
                    content: Wrap(
                      children: Colors.primaries.map((c) {
                        return InkWell(
                          onTap: () => Navigator.pop(context, c),
                          child: CircleAvatar(
                            backgroundColor: c,
                            radius: 20,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                  );
                  if(color != null) {
                    setState(() {
                      selectedColor = color;
                    });
                  }
                }, icon: const Icon(Icons.edit))
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              if(nameCtrl.text.isEmpty) return;

              final habit = Habit(
                name: nameCtrl.text,
                color: selectedColor.value,
                icon: "star"
              );

              Navigator.pop(context, habit);
            }, child: const Text("Add"))
          ],
        ),

      ),


    );
  }
}