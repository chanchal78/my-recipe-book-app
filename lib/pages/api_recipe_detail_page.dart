import 'package:flutter/material.dart';

class ApiRecipeDetailPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const ApiRecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe['strMeal'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (recipe['strMealThumb'] != null)
              Image.network(recipe['strMealThumb']),
            const SizedBox(height: 16),
            Text(
              recipe['strMeal'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Category: ${recipe['strCategory'] ?? 'N/A'}'),
            const SizedBox(height: 16),
            Text(recipe['strInstructions'] ?? 'No instructions available.'),
          ],
        ),
      ),
    );
  }
}
