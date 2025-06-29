class Task {
  //Default config for a task

  String taskName = "";
  int strength = 0;
  int xp = 0;
  int agility = 0;
  int mind = 0;
  int willpower = 0;
  int charisma = 0;
  bool completed = false;
  DateTime date = DateTime.now();

  //Auto inited with his default values
  Task();

  /// All json conversion - Quickly built by Gemini
  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'strength': strength,
      'agility': agility,
      'mind': mind,
      'willpower': willpower,
      'charisma': charisma,
      'xp': xp,
      'date': date.toIso8601String(),
      'completed': completed,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task()
      ..taskName = json['taskName'] as String
      ..strength = json['strength'] as int
      ..agility = json['agility'] as int
      ..mind = json['mind'] as int
      ..willpower = json['willpower'] as int
      ..charisma = json['charisma'] as int
      ..xp = json['xp'] as int
      ..date = DateTime.parse(json['date'] as String)
      ..completed = json['completed'] as bool;
  }
}
