import 'dart:convert';

import 'package:desafio02/modules/characters/models/character.dart';
import 'package:desafio02/modules/characters/services/characters_webclient.dart';

class CharactersController {
  late final CharactersWebClient? _charactersWebClient;

  CharactersController.withService(CharactersWebClient service) {
    this._charactersWebClient = service;
  }

  CharactersController() {
    this._charactersWebClient = new CharactersWebClient();
  }

  Future<List<Character>> getCharactersList() async {
    final response = await _charactersWebClient!.getCharacters();

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Character.fromJson(model)).toList();
    }

    return [];
  }
}