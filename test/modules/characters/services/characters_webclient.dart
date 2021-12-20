import 'dart:async';
import 'package:desafio02/modules/characters/services/characters_webclient.dart';
import 'package:http/http.dart';

class CharactersWebClientMock extends CharactersWebClient {
  @override
  Future getCharacters() async {
    final data = '[{'
        '"name":"Harry Potter",'
        '"house":"Gryffindor",'
        '"dateOfBirth":"31-07-1980",'
        '"yearOfBirth":1980,'
        '"eyeColour":"green",'
        '"image":""}'
    ']';

    return Future.delayed(Duration(seconds: 30), () => new Response(data, 200));
  }
}