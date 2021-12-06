import 'dart:async';
import 'package:desafio02/database/database.dart';
import 'package:desafio02/modules/characters/models/favorite_character.dart';

class FavoriteRepository {
  FavoriteRepository._privateConstructor();

  /// Evita que a classe seja instânciada mais de uma vez
  static final FavoriteRepository instance = FavoriteRepository._privateConstructor();

  static DBProvider? _dbProvider;
  DBProvider get dbProvider => _dbProvider ?? DBProvider.instance;

  Future<List<FavoriteCharacter>> getFavorites() async {
    var dbClient = await dbProvider.database;

    var res = await dbClient.query('favorites', columns: ['id', 'character_name']);
    List<FavoriteCharacter> list = res.isNotEmpty ? res.map((c) => FavoriteCharacter.fromMap(c)).toList() : [];

    return list;
  }

  /// Esse método é responsável por obter um personagem pelo nome
  Future<FavoriteCharacter?> getFavoriteByName(String characterName) async {
    var dbClient = await dbProvider.database;

    var res = await dbClient.query('favorites',
        columns: ['id', 'character_name'],
        where: 'character_name = ?',
        whereArgs: [characterName]);

    if (res.isNotEmpty) {
      return FavoriteCharacter.fromMap(res.first);
    }

    return null;
  }

  /// Esse método é responsável por criar um novo personagem, porém se ele existir os dados dele são atualizados
  Future<FavoriteCharacter?> saveOrUpdate(FavoriteCharacter favoriteCharacter) async {
    var existingFavorite = await getFavoriteByName(favoriteCharacter.characterName);

    if (existingFavorite == null) {
      return create(favoriteCharacter);
    }

    return favoriteCharacter;
  }

  /// Esse método é responsável por salvar um novo personagem
  Future<FavoriteCharacter> create(FavoriteCharacter favoriteCharacter) async {
    var dbClient = await dbProvider.database;
    favoriteCharacter.id = (await dbClient.insert('favorites', favoriteCharacter.toMap()));

    return favoriteCharacter;
  }

  /// Esse método é responsável por remover um personagem
  Future<int> delete(int id) async {
    var dbClient = await dbProvider.database;
    return await dbClient.delete('favorites', where: "id = ?", whereArgs: [id]);
  }

  /// Esse método é responsável por atualizar um personagem
  Future<int> update(FavoriteCharacter favoriteCharacter) async {
    var dbClient = await dbProvider.database;

    return await dbClient.update('favorites', favoriteCharacter.toMap(), where: "id = ?", whereArgs: [favoriteCharacter.id]);
  }
}