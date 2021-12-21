import 'dart:io';

import 'package:desafio02/modules/characters/controllers/characters_controller.dart';
import 'package:desafio02/modules/characters/screens/characters_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../services/characters_webclient.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);

  group('CharactersListScreen', () {
    testWidgets('should render the screen correctly',
        (WidgetTester tester) async {
      final controller = new CharactersController();

      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: new CharactersListScreen(controller: controller)));

      await tester.pumpWidget(testWidget);

      expect(find.byKey(Key('bgBackground')), findsOneWidget);
      expect(find.byKey(Key('favoriteCharactersBtn')), findsOneWidget);
    });

    // testWidgets('should navigate to the character details and then add it to the favorite', (WidgetTester tester) async {
    //   final service =  new CharactersWebClientMock();
    //   final controller = new CharactersController.withService(service);
    //
    //   Widget testWidget = new MediaQuery(
    //       data: new MediaQueryData(),
    //       child: new MaterialApp(home: new CharactersListScreen(controller: controller))
    //   );
    //
    //   await tester.pumpWidget(testWidget);
    //   await tester.pumpAndSettle(Duration(seconds: 40));
    //
    //   // await tester.tap(find.byType(GestureDetector));
    //   expect(find.byKey(Key('charactersListViewItem_harry_potter')), findsOneWidget);
    // });

    testWidgets(
        'should navigate to the character details and then add it to the favorite',
        (WidgetTester tester) async {
      final charactersWebClient = new CharactersWebClientMock();
      final charactersController =
          new CharactersController.withService(charactersWebClient);

      final charactersListScreen =
          CharactersListScreen(controller: charactersController);

      // Widget testWidget = new MediaQuery(
      //     data: new MediaQueryData(),
      //     child: new MaterialApp(home: new CharactersListScreen(controller: controller))
      // );
      //
      // await tester.pumpWidget(testWidget);
      // await tester.pumpAndSettle(Duration(seconds: 40));

      // await tester.tap(find.byType(GestureDetector));

      await tester.pumpWidget(MaterialApp(home: charactersListScreen));

      await tester.pumpAndSettle();

      expect(find.text('Harry Challenge'), findsOneWidget);

      expect(find.text('Harry Potter'), findsOneWidget);

      await tester.tap(find.text('Harry Potter'));

      await tester.pumpAndSettle();

      expect(find.byKey(Key('title_character_detail')), findsOneWidget);
    });
  });
}
