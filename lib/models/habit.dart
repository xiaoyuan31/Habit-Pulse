class Habit {
  String name;
  String icon;
  int color;
  int streak;
  bool doneToday;

  Habit({
     required this.name,
    required this.icon,
    required this.color,
     this.streak = 0,
     this.doneToday = false
  });

  Map<String, dynamic> toJson() => {
    'name' : name,
    'icon' : icon,
    'color' : color,
    'streak' : streak,
    'doneToday' : doneToday,
  };

  factory Habit.fromJson(Map<String, dynamic> json) => Habit (
    name: json['name'],
    icon: json['icon'],
    color: json['color'],
    streak: json['streak'],
    doneToday: json['doneToday'],
  );
}