import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/recipe_repository.dart';
import '../models/recipe.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final RecipeRepository _repo = RecipeRepository();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _servingsController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();

  String _selectedCategory = 'Italien';
  final List<String> _categories = [
    'Italien',
    'Salade',
    'Dessert',
    'Indien',
    'Végétarien',
    'Américain',
    'Soupe',
    'Autre',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _prepTimeController.dispose();
    _servingsController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final newRecipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrl: 'https://images.unsplash.com/photo-1495521821757-a1efb6729352?w=800',
      category: _selectedCategory,
      preparationTime: int.parse(_prepTimeController.text),
      servings: int.parse(_servingsController.text),
      ingredients: _ingredientsController.text
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      steps: _stepsController.text
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      rating: 0.0,
    );

    _repo.addRecipe(newRecipe);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recette "${newRecipe.title}" ajoutée !'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );

    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une recette'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Titre
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titre de la recette *',
                prefixIcon: Icon(Icons.restaurant_menu),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Le titre est obligatoire';
                }
                if (value.trim().length < 3) {
                  return 'Le titre doit contenir au moins 3 caractères';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description *',
                prefixIcon: Icon(Icons.description),
                alignLabelWithHint: true,
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'La description est obligatoire';
                }
                if (value.trim().length < 10) {
                  return 'La description doit contenir au moins 10 caractères';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Catégorie
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Catégorie *',
                prefixIcon: Icon(Icons.category),
              ),
              items: _categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _selectedCategory = value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Choisissez une catégorie';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Temps + Portions (Row)
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _prepTimeController,
                    decoration: const InputDecoration(
                      labelText: 'Temps (min) *',
                      prefixIcon: Icon(Icons.timer),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Obligatoire';
                      }
                      final n = int.tryParse(value);
                      if (n == null || n <= 0) {
                        return 'Nombre > 0';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _servingsController,
                    decoration: const InputDecoration(
                      labelText: 'Portions *',
                      prefixIcon: Icon(Icons.people),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Obligatoire';
                      }
                      final n = int.tryParse(value);
                      if (n == null || n <= 0) {
                        return 'Nombre > 0';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Ingrédients
            TextFormField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                labelText: 'Ingrédients * (un par ligne)',
                prefixIcon: Icon(Icons.shopping_basket),
                alignLabelWithHint: true,
                hintText: '400 g de spaghetti\n200 g de lardons\n...',
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Ajoutez au moins un ingrédient';
                }
                final lines = value
                    .split('\n')
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty)
                    .toList();
                if (lines.length < 2) {
                  return 'Ajoutez au moins 2 ingrédients';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Étapes
            TextFormField(
              controller: _stepsController,
              decoration: const InputDecoration(
                labelText: 'Étapes de préparation * (une par ligne)',
                prefixIcon: Icon(Icons.format_list_numbered),
                alignLabelWithHint: true,
                hintText: 'Faire cuire les pâtes...\nFaire revenir les lardons...',
              ),
              maxLines: 6,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Ajoutez au moins une étape';
                }
                final lines = value
                    .split('\n')
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty)
                    .toList();
                if (lines.length < 2) {
                  return 'Ajoutez au moins 2 étapes';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            // Bouton submit
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.check),
                label: const Text(
                  'Enregistrer la recette',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '* Champs obligatoires',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
