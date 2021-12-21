import 'package:desafio02/modules/characters/controllers/characters_controller.dart';
import 'package:desafio02/modules/characters/models/character.dart';
import 'package:desafio02/modules/characters/screens/characters_list_details.dart';
import 'package:flutter/material.dart';
import 'favorite_characters_list.dart';

class CharactersListScreen extends StatefulWidget {
  final CharactersController controller;

  CharactersListScreen({Key? key, required this.controller}) : super(key: key);

  @override
  createState() => _CharactersListScreenState(controller: controller);
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  final CharactersController controller;
  var characters = new List<Character>.empty();

  _CharactersListScreenState({required this.controller}) : super();

  /// Esse método obtém os personagens da API
  _getCharacters() async {
    final response = await controller.getCharactersList();

    setState(() {
      characters = response;
    });
  }

  initState() {
    super.initState();
    _getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Harry Challenge',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
      ),
      body: Column(children: [
        Container(
            child: Image(
          key: Key('bgBackground'),
          image: AssetImage('./assets/images/harry_bg.jpg'),
        )),
        Expanded(
            child: ListView.builder(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                shrinkWrap: true,
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  var characterImage = characters[index].image == ""
                      ? "https://via.placeholder.com/130x180"
                      : characters[index].image;
                  var identifier =
                      'charactersListViewItem_${characters[index].name.replaceAll(' ', '_')}'
                          .toLowerCase();

                  return GestureDetector(
                    key: Key(identifier),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CharactersListDetailsScreen(
                              character: characters[index]),
                        ),
                      );
                    },
                    child: Container(
                      child: Card(
                        // shadowColor: Colors.red,
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(characterImage),
                              backgroundColor: Colors.transparent,
                              radius: 20.0,
                            ),
                            title: Text(characters[index].name),
                            subtitle: Text(characters[index].house)),
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
                })),
      ]),
      floatingActionButton: FloatingActionButton(
        key: Key('favoriteCharactersBtn'),
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FavoriteCharactersListScreen()))
        },
        tooltip: 'Favorites',
        child: Icon(Icons.favorite),
        backgroundColor: Colors.black,
      ),
    );
  }
}
