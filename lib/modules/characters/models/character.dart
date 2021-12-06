class Character {
  late final String image;
  final String name;
  final String house;
  final String actor;
  final bool hogwartsStudent;
  final String dateOfBirth;
  final String eyeColour;

  Character(this.image, this.name, this.house, this.dateOfBirth, this.eyeColour, this.actor, this.hogwartsStudent);

  Character.fromJson(Map json) :
      image = json["image"],
      name = json["name"],
      house = json["house"],
      actor = json["actor"],
      hogwartsStudent = json["hogwartsStudent"],
      dateOfBirth = json["dateOfBirth"],
      eyeColour = json["eyeColour"];
}