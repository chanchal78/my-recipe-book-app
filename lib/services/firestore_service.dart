import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe.dart';

class FirestoreService {
  final CollectionReference _recipesCollection = FirebaseFirestore.instance
      .collection('recipes');

  // Create
  Future<void> addRecipe(Recipe recipe) async {
    try {
      await _recipesCollection.add(recipe.toMap());
    } catch (e) {
      print('Error adding recipe: $e');
      rethrow; // Propagate the error for better error handling in UI layer
    }
  }

  // Read (stream) - Get real-time updates of the recipes collection
  Stream<List<Recipe>> getRecipes() {
    return _recipesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Recipe.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Update
  Future<void> updateRecipe(Recipe recipe) async {
    try {
      await _recipesCollection.doc(recipe.id).update(recipe.toMap());
    } catch (e) {
      print('Error updating recipe: $e');
      rethrow;
    }
  }

  // Delete
  Future<void> deleteRecipe(String id) async {
    try {
      await _recipesCollection.doc(id).delete();
    } catch (e) {
      print('Error deleting recipe: $e');
      rethrow;
    }
  }
}
