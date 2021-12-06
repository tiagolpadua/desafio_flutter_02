import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterEye extends StatelessWidget {
  final String color;

  CharacterEye({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var eyeColor = Colors.grey;

    switch(color) {
      case "green":
        eyeColor = Colors.green;
        break;
      case "blue":
        eyeColor = Colors.blue;
        break;
      case "brown":
        eyeColor = Colors.brown;
        break;
    }

    return Icon(Icons.visibility, color: eyeColor);
  }
}


