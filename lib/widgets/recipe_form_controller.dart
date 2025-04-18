import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import '../models/recipe.dart';

class RecipeFormController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ingredientsController = TextEditingController();
  final stepsController = TextEditingController();
  final imageUrlController = TextEditingController();

  File? _imageFile; // This will hold the selected image

  RecipeFormController({Recipe? recipe}) {
    if (recipe != null) {
      titleController.text = recipe.title;
      descriptionController.text = recipe.description;
      ingredientsController.text = recipe.ingredients.join(', ');
      stepsController.text = recipe.steps;
      imageUrlController.text = recipe.imageUrl;
    }
  }

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    ingredientsController.dispose();
    stepsController.dispose();
    imageUrlController.dispose();
  }

  // Method to pick an image from the gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      final uploadedImageUrl = await _uploadImage(_imageFile!);
      imageUrlController.text = uploadedImageUrl; // Update image URL
    }
  }

  // Method to upload image to Firebase Storage
  Future<String> _uploadImage(File image) async {
    final storageRef = FirebaseStorage.instance.ref();
    final fileName = Uuid().v4(); // Create a unique filename
    final imageRef = storageRef.child('recipe_images/$fileName.jpg');

    await imageRef.putFile(image); // Upload the file
    return await imageRef.getDownloadURL(); // Get the image URL
  }

  // Convert the form data to a Recipe object
  Recipe toRecipe({required String id}) {
    return Recipe(
      id: id,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      ingredients:
          ingredientsController.text.split(',').map((e) => e.trim()).toList(),
      steps: stepsController.text.trim(),
      imageUrl:
          imageUrlController.text
              .trim(), // Use the image URL stored in the controller
    );
  }
}
