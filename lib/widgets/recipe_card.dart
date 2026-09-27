import 'package:flutter/material.dart';
import '../models/recipe.dart';

/// Widget réutilisable n°1 – Carte de recette
class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;
  final bool isCompact;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    this.onFavoriteToggle,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: isCompact ? 4 : 12,
        vertical: isCompact ? 4 : 8,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image avec Stack pour overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: isCompact ? 1.2 : 16 / 9,
                    child: Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: const Icon(Icons.restaurant, size: 48),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: const Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                ),
                // Badge catégorie
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      recipe.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Bouton favori
                if (onFavoriteToggle != null)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      icon: Icon(
                        recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: recipe.isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: onFavoriteToggle,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black45,
                      ),
                    ),
                  ),
              ],
            ),
            // Contenu
            Padding(
              padding: EdgeInsets.all(isCompact ? 8 : 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (!isCompact) ...[
                    const SizedBox(height: 4),
                    Text(
                      recipe.description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 16, color: theme.colorScheme.primary),
                      const SizedBox(width: 4),
                      Text(
                        '${recipe.preparationTime} min',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.people_outline, size: 16, color: theme.colorScheme.primary),
                      const SizedBox(width: 4),
                      Text(
                        '${recipe.servings} pers.',
                        style: theme.textTheme.bodySmall,
                      ),
                      const Spacer(),
                      Icon(Icons.star, size: 16, color: Colors.amber.shade700),
                      const SizedBox(width: 2),
                      Text(
                        recipe.rating.toStringAsFixed(1),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
