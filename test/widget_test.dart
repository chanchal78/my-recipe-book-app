import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recipe_book_app/main.dart';

void main() {
  testWidgets('Navigation bar taps update screen', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(RecipeBookApp());

    // Check that HomePage (default page) is visible
    expect(
      find.text('Home'),
      findsOneWidget,
    ); // Adjust depending on your widget contents

    // Tap on the 'Recipes' BottomNavigationBar item
    await tester.tap(find.byIcon(Icons.book));
    await tester.pump();

    // You might want to check some widget that uniquely identifies RecipeListPage here
    // For example:
    // expect(find.text('Your Recipes'), findsOneWidget);

    // Tap on the 'Add' BottomNavigationBar item
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Again, check for some widget from AddEditRecipePage if possible
    // expect(find.text('Add New Recipe'), findsOneWidget);
  });
}
