import 'package:desafio02/modules/characters/components/character_eye.dart';
import 'package:desafio02/modules/characters/components/character_info.dart';
import 'package:desafio02/modules/characters/models/character.dart';
import 'package:desafio02/modules/characters/models/favorite_character.dart';
import 'package:desafio02/modules/characters/repository/favorite_repository.dart';
import 'package:flutter/material.dart';

class CharactersListDetailsScreen extends StatefulWidget {
  final Character character;

  CharactersListDetailsScreen({Key? key, required this.character}) : super(key: key);

  @override
  createState() => _CharactersListDetailsScreenState(character);
}

class _CharactersListDetailsScreenState extends State {
  var isFavorite = false;
  final Character character;
  _CharactersListDetailsScreenState(this.character);

  initState() {
    super.initState();
    _getCharacterDetails();
  }

  /// Esse método verifica se o personagem está favoritado
  _getCharacterDetails() async {
    var isAlreadyFavorite =
        await FavoriteRepository.instance.getFavoriteByName(character.name) !=
            null;

    setState(() {
      isFavorite = isAlreadyFavorite;
    });
  }

  /// Esse método é responsável por salvar e remover um personagem favorito
  _saveOrRemoveFavorite(String name) async {
    var alreadyFavorite =
        await FavoriteRepository.instance.getFavoriteByName(character.name);

    if (alreadyFavorite == null) {
      FavoriteCharacter favoriteCharacter = FavoriteCharacter();
      favoriteCharacter.characterName = name;

      FavoriteRepository.instance.saveOrUpdate(favoriteCharacter);
    } else {
      FavoriteRepository.instance.delete(alreadyFavorite.id);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isHogwartsStudentText = character.hogwartsStudent ? 'Sim' : 'Nao';
    var characterImage = character.image == "" ? "https://via.placeholder.com/130x180" : character.image;

    return Scaffold(
        appBar: AppBar(
          title: Text(character.name,
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.red.shade900,
        ),
        body: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Container(
                      width: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Image.network(characterImage, height: 180, width: 130)],
                      )
                  ),
                  Container(
                      width:  MediaQuery.of(context).size.width * 0.40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(character.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(character.house, style: TextStyle(fontSize: 18)),
                        ],
                      )
                  ),
                  Container(
                    width:  MediaQuery.of(context).size.width * 0.15,
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () => _saveOrRemoveFavorite(character.name),
                      icon: isFavorite ? Icon(Icons.favorite, color: Colors.red, size: 40) :  Icon(Icons.favorite, color: Colors.red.shade200, size: 40),
                      iconSize: 40,
                    ),
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Divider(
                  color: Colors.grey,
                ),
                CharacterInfo(label: 'Nome', value: character.name),
                CharacterInfo(label: 'Casa', value: character.house),
                CharacterInfo(label: 'Ator(a)', value: character.actor),
                CharacterInfo(label: 'Aluno(a)', value: isHogwartsStudentText),
                CharacterInfo(
                    label: 'Aniversário', value: character.dateOfBirth),
                CharacterInfo(
                    label: 'Cor dos olhos',
                    value: CharacterEye(color: character.eyeColour)),
              ],
            ),
          )
        ]));
  }
}
