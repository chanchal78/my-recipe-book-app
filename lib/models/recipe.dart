class Recipe {
  String id;
  String title;
  String description;
  List<String> ingredients;
  String steps;
  String imageUrl;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.imageUrl,
  });

  // Convert Firestore doc to Recipe
  factory Recipe.fromMap(Map<String, dynamic> data, String documentId) {
    return Recipe(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      ingredients: List<String>.from(data['ingredients'] ?? []),
      steps: data['steps'] ?? '',
      imageUrl: data['imageUrl'] ?? '', // Ensure image URL is correctly mapped
    );
  }

  // Convert Recipe to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'steps': steps,
      'imageUrl': imageUrl, // Save the image URL to Firestore
    };
  }
}
