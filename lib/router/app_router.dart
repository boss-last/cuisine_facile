import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/recipe_detail_screen.dart';
import '../screens/add_recipe_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/recipe/:id',
      name: 'recipeDetail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return RecipeDetailScreen(recipeId: id);
      },
    ),
    GoRoute(
      path: '/add',
      name: 'addRecipe',
      builder: (context, state) => const AddRecipeScreen(),
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Erreur')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Page introuvable',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(state.error?.toString() ?? 'Route inconnue'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Retour à l\'accueil'),
          ),
        ],
      ),
    ),
  ),
);
