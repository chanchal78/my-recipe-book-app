import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'api_recipe_detail_page.dart';

class ApiRecipesPage extends StatefulWidget {
  const ApiRecipesPage({Key? key}) : super(key: key);

  @override
  State<ApiRecipesPage> createState() => _ApiRecipesPageState();
}

class _ApiRecipesPageState extends State<ApiRecipesPage> {
  late Future<List<Map<String, dynamic>>> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture = ApiService().fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More Recipes')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final recipes = snapshot.data!;
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return ListTile(
                leading: Image.network(
                  recipe['strMealThumb'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(recipe['strMeal']),
                subtitle: Text(recipe['strCategory'] ?? 'No category'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ApiRecipeDetailPage(recipe: recipe),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
