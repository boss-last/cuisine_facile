import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/recipe_repository.dart';
import '../models/recipe.dart';
import '../widgets/responsive_layout.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final RecipeRepository _repo = RecipeRepository();
  late Recipe? _recipe;

  @override
  void initState() {
    super.initState();
    _recipe = _repo.getById(widget.recipeId);
  }

  void _toggleFavorite() {
    if (_recipe == null) return;
    setState(() {
      _repo.toggleFavorite(_recipe!.id);
      _recipe = _repo.getById(widget.recipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_recipe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recette introuvable')),
        body: const Center(child: Text('Cette recette n\'existe pas.')),
      );
    }

    final recipe = _recipe!;
    final theme = Theme.of(context);
    final isWide = isTablet(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar avec image
          SliverAppBar(
            expandedHeight: isWide ? 350 : 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe.title,
                style: const TextStyle(
                  shadows: [Shadow(blurRadius: 8, color: Colors.black54)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    recipe.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.restaurant, size: 80),
                    ),
                  ),
                  // Gradient overlay
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: recipe.isFavorite ? Colors.red : null,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
          ),
          // Contenu
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 48 : 16,
                vertical: 20,
              ),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildMainContent(recipe, theme)),
                        const SizedBox(width: 32),
                        Expanded(flex: 1, child: _buildSideInfo(recipe, theme)),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSideInfo(recipe, theme),
                        const SizedBox(height: 24),
                        _buildMainContent(recipe, theme),
                      ],
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _buildSideInfo(Recipe recipe, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Infos rapides
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                _InfoChip(
                  icon: Icons.timer_outlined,
                  label: '${recipe.preparationTime} min',
                ),
                _InfoChip(
                  icon: Icons.people_outline,
                  label: '${recipe.servings} pers.',
                ),
                _InfoChip(
                  icon: Icons.star,
                  label: recipe.rating.toStringAsFixed(1),
                  color: Colors.amber.shade700,
                ),
                _InfoChip(
                  icon: Icons.category_outlined,
                  label: recipe.category,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Description',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(recipe.description, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(Recipe recipe, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ingrédients
        Text(
          'Ingrédients',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recipe.ingredients.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 14,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                title: Text(recipe.ingredients[index]),
                dense: true,
              );
            },
          ),
        ),
        const SizedBox(height: 28),
        // Étapes
        Text(
          'Préparation',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...recipe.steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(step, style: theme.textTheme.bodyLarge),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _InfoChip({
    required this.icon,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: color ?? Theme.of(context).colorScheme.primary),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
