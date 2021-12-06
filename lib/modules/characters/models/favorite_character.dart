class FavoriteCharacter {
  FavoriteCharacter();

  late int id;
  late String characterName;

  FavoriteCharacter.fromMap(Map<String, dynamic> map):
      id = map["id"],
      characterName = map["character_name"];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      "character_name": characterName
    };

    return map;
  }
}