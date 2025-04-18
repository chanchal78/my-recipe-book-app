import 'package:flutter/material.dart';
import '../widgets/recipe_form_controller.dart';

class RecipeForm extends StatelessWidget {
  final RecipeFormController controller;
  final VoidCallback onSave;

  const RecipeForm({Key? key, required this.controller, required this.onSave})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: controller.titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter a title'
                        : null,
          ),
          TextFormField(
            controller: controller.descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter a description'
                        : null,
          ),
          TextFormField(
            controller: controller.ingredientsController,
            decoration: const InputDecoration(
              labelText: 'Ingredients (comma separated)',
            ),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter ingredients'
                        : null,
          ),
          TextFormField(
            controller: controller.stepsController,
            decoration: const InputDecoration(labelText: 'Steps'),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter steps'
                        : null,
          ),
          TextFormField(
            controller: controller.imageUrlController,
            decoration: const InputDecoration(labelText: 'Image URL'),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter an image URL'
                        : null,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                onSave();
              }
            },
            child: const Text('Save Recipe'),
          ),
        ],
      ),
    );
  }
}
