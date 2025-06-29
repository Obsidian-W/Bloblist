class Blob {
  //Default config for a blob
  String name = "Tamagoblob";
  int level = 1;
  int strength = 0;
  int xp = 0;
  int agility = 0;
  int mind = 0;
  int willpower = 0;
  int charisma = 0;

  //Auto inited with his default values
  //Data is retrieved over the network / From local storage (In local mode)
  Blob();

  /// All json conversion - Copied from Task model
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
      'strength': strength,
      'agility': agility,
      'mind': mind,
      'willpower': willpower,
      'charisma': charisma,
      'xp': xp,
    };
  }

  factory Blob.fromJson(Map<String, dynamic> json) {
    return Blob()
      ..name = json['name'] as String
      ..level = json['level'] as int
      ..xp = json['xp'] as int
      ..strength = json['strength'] as int
      ..agility = json['agility'] as int
      ..mind = json['mind'] as int
      ..willpower = json['willpower'] as int
      ..charisma = json['charisma'] as int;
  }
}
