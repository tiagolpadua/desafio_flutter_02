import 'package:desafio02/modules/characters/models/favorite_character.dart';
import 'package:desafio02/modules/characters/repository/favorite_repository.dart';
import 'package:flutter/material.dart';

class FavoriteCharactersListScreen extends StatefulWidget {
  FavoriteCharactersListScreen({Key? key}) : super(key: key);

  @override
  createState() => _FavoriteCharactersListScreenState();
}

class _FavoriteCharactersListScreenState extends State {
  var favorites = new List<FavoriteCharacter>.empty();

  /// Esse método é responsável por obter todos os personagens favoritados
  _getFavoriteCharacters() async {
    List<FavoriteCharacter> list = await FavoriteRepository.instance.getFavorites();

    setState(() {
      favorites = list;
    });
  }

  initState() {
    super.initState();
    _getFavoriteCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Personagens Favoritos', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
      ),
      body: Column(children: [
        Container(
          child: Image(
            image: AssetImage('./assets/images/harry_bg.jpg'),
          ),
        ),
        Expanded(
            child: ListView.builder(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                shrinkWrap: true,
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      child: Card(
                        // shadowColor: Colors.red,
                        child: ListTile(
                            title: Text(favorites[index].characterName),
                        ),
                      ),
                      decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(.1),
                            blurRadius: 0, // soften the shadow
                            spreadRadius: 3.0, //extend the shadow
                            offset: Offset(
                              0.70, // Move to right 10  horizontally
                              0.70, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
            )
        ),
      ]),
    );
  }
}
