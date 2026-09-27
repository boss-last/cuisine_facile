import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/recipe_repository.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_chip.dart';
import '../widgets/responsive_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecipeRepository _repo = RecipeRepository();
  final TextEditingController _searchController = TextEditingController();

  List<Recipe> _filteredRecipes = [];
  String _selectedCategory = 'Toutes';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredRecipes = _repo.getAll();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    setState(() {
      var results = _repo.search(_searchQuery);
      if (_selectedCategory != 'Toutes') {
        results = results.where((r) => r.category == _selectedCategory).toList();
      }
      _filteredRecipes = results;
    });
  }

  void _onSearchChanged(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _onCategorySelected(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void _toggleFavorite(String id) {
    setState(() {
      _repo.toggleFavorite(id);
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = _repo.getCategories();
    final isWide = isTablet(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuisine Facile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favoris',
            onPressed: () => context.go('/favorites'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Paramètres',
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Recherche
          SearchBarWidget(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
          // Filtres catégories (ListView horizontal)
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                return CategoryChip(
                  label: cat,
                  isSelected: _selectedCategory == cat,
                  onSelected: () => _onCategorySelected(cat),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Liste / Grille responsive
          Expanded(
            child: _filteredRecipes.isEmpty
                ? _buildEmptyState(context)
                : isWide
                    ? _buildGridView()
                    : _buildListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/add'),
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: _filteredRecipes.length,
      itemBuilder: (context, index) {
        final recipe = _filteredRecipes[index];
        return RecipeCard(
          recipe: recipe,
          onTap: () => context.go('/recipe/${recipe.id}'),
          onFavoriteToggle: () => _toggleFavorite(recipe.id),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 80),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCrossAxisCount(context),
        childAspectRatio: 0.75,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _filteredRecipes.length,
      itemBuilder: (context, index) {
        final recipe = _filteredRecipes[index];
        return RecipeCard(
          recipe: recipe,
          isCompact: true,
          onTap: () => context.go('/recipe/${recipe.id}'),
          onFavoriteToggle: () => _toggleFavorite(recipe.id),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucune recette trouvée',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Essayez une autre recherche ou catégorie',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}
