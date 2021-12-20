// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:desafio02/modules/characters/models/character.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Character Model -', (){
    test('should initialize a model with all required properties', () {
      final image = 'http://hp-api.herokuapp.com/images/harry.jpg';
      final name = 'Harry Potter';
      final house = 'Griffyndor';
      final dateOfBirth = '31-07-1980';
      final eyeColour = 'green';
      final actor = 'Daniel Radcliffe';
      final hogwartsStudent = true;

      final character = Character(image, name, house, dateOfBirth, eyeColour, actor, hogwartsStudent);

      expect(character.image, image);
      expect(character.name, name);
      expect(character.house, house);
      expect(character.dateOfBirth, dateOfBirth);
      expect(character.eyeColour, eyeColour);
      expect(character.actor, actor);
      expect(character.hogwartsStudent, hogwartsStudent);
    });
  });
}
