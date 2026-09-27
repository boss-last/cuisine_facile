import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/recipe_repository.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import '../widgets/responsive_layout.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final RecipeRepository _repo = RecipeRepository();
  List<Recipe> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      _favorites = _repo.getFavorites();
    });
  }

  void _toggleFavorite(String id) {
    setState(() {
      _repo.toggleFavorite(id);
      _loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWide = isTablet(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Favoris'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aucun favori pour le moment',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Appuyez sur le cœur pour ajouter des recettes',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.home),
                    label: const Text('Voir les recettes'),
                  ),
                ],
              ),
            )
          : isWide
              ? GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridCrossAxisCount(context),
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _favorites.length,
                  itemBuilder: (context, index) {
                    final recipe = _favorites[index];
                    return RecipeCard(
                      recipe: recipe,
                      isCompact: true,
                      onTap: () => context.go('/recipe/${recipe.id}'),
                      onFavoriteToggle: () => _toggleFavorite(recipe.id),
                    );
                  },
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: _favorites.length,
                  itemBuilder: (context, index) {
                    final recipe = _favorites[index];
                    return RecipeCard(
                      recipe: recipe,
                      onTap: () => context.go('/recipe/${recipe.id}'),
                      onFavoriteToggle: () => _toggleFavorite(recipe.id),
                    );
                  },
                ),
    );
  }
}
