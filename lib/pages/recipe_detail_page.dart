import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              recipe.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(recipe.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text(
              'Ingredients:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...recipe.ingredients.map((item) => Text('• $item')).toList(),
            const SizedBox(height: 16),
            const Text('Steps:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(recipe.steps),
            const SizedBox(height: 16),
            if (recipe.imageUrl.isNotEmpty)
              Image.network(recipe.imageUrl, height: 200, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
