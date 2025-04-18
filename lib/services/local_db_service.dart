import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDBService {
  static const String favoritesKey = 'favorite_recipes';

  /// Save a list of recipe IDs as favorites
  static Future<void> saveFavoriteRecipes(List<String> recipeIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(favoritesKey, recipeIds);
  }

  /// Get the list of saved favorite recipe IDs
  static Future<List<String>> getFavoriteRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(favoritesKey) ?? [];
  }

  /// Add a single recipe ID to favorites
  static Future<void> addFavorite(String recipeId) async {
    final currentFavorites = await getFavoriteRecipes();
    if (!currentFavorites.contains(recipeId)) {
      currentFavorites.add(recipeId);
      await saveFavoriteRecipes(currentFavorites);
    }
  }

  /// Remove a single recipe ID from favorites
  static Future<void> removeFavorite(String recipeId) async {
    final currentFavorites = await getFavoriteRecipes();
    currentFavorites.remove(recipeId);
    await saveFavoriteRecipes(currentFavorites);
  }

  /// Check if a recipe is marked as favorite
  static Future<bool> isFavorite(String recipeId) async {
    final currentFavorites = await getFavoriteRecipes();
    return currentFavorites.contains(recipeId);
  }
}
