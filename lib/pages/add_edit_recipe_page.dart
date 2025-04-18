import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/firestore_service.dart';
import '../widgets/recipe_form_controller.dart';
import '../widgets/recipe_form.dart';

class AddEditRecipePage extends StatefulWidget {
  final Recipe? recipe;

  const AddEditRecipePage({Key? key, this.recipe}) : super(key: key);

  @override
  State<AddEditRecipePage> createState() => _AddEditRecipePageState();
}

class _AddEditRecipePageState extends State<AddEditRecipePage> {
  late RecipeFormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RecipeFormController(recipe: widget.recipe);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveRecipe() async {
    final recipe = _controller.toRecipe(id: widget.recipe?.id ?? '');
    if (widget.recipe == null) {
      await FirestoreService().addRecipe(recipe);
    } else {
      await FirestoreService().updateRecipe(recipe);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe == null ? 'Add Recipe' : 'Edit Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RecipeForm(controller: _controller, onSave: _saveRecipe),
      ),
    );
  }
}
