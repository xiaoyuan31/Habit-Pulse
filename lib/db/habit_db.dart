import 'package:hive/hive.dart';

class HabitDb {
  static const String boxName = 'habitsBox';

  static Future<void> init() async {
    await Hive.openBox(boxName);
  }

  static Box get box => Hive.box(boxName);

  static List getHabits() {
    return box.get('habits', defaultValue: []);
  }

  static void saveHabits(List habits) {
    box.put('habits', habits);
  }

}
