import 'package:flutter/material.dart';
import '../services/local_db_service.dart';

class AppState extends ChangeNotifier {
  List<String> _favoriteRecipeIds = [];

  List<String> get favoriteRecipeIds => _favoriteRecipeIds;

  Future<void> loadFavorites() async {
    _favoriteRecipeIds = await LocalDBService.getFavoriteRecipes();
    notifyListeners();
  }

  bool isFavorite(String recipeId) {
    return _favoriteRecipeIds.contains(recipeId);
  }

  Future<void> toggleFavorite(String recipeId) async {
    if (_favoriteRecipeIds.contains(recipeId)) {
      _favoriteRecipeIds.remove(recipeId);
      await LocalDBService.removeFavorite(recipeId);
    } else {
      _favoriteRecipeIds.add(recipeId);
      await LocalDBService.addFavorite(recipeId);
    }
    notifyListeners();
  }
}
