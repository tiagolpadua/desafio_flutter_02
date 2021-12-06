import 'package:flutter/material.dart';

class CharacterInfo extends StatelessWidget {
  final String label;
  final dynamic value;

  CharacterInfo({Key? key, required this.label, required this.value}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          value is String ? Text(value, style: TextStyle(fontSize: 20)) : value
        ],
      ),
    );
  }
}
