import '../models/recipe.dart';

/// Repository centralisé – aucune donnée hardcodée dans les widgets.
class RecipeRepository {
  static final RecipeRepository _instance = RecipeRepository._internal();
  factory RecipeRepository() => _instance;
  RecipeRepository._internal();

  final List<Recipe> _recipes = [
    Recipe(
      id: '1',
      title: 'Pâtes Carbonara',
      description:
          'Un classique italien crémeux avec lardons, œufs et parmesan. Prêt en 20 minutes.',
      imageUrl: 'https://images.unsplash.com/photo-1612874742237-6526221588e3?w=800',
      category: 'Italien',
      preparationTime: 20,
      servings: 4,
      ingredients: [
        '400 g de spaghetti',
        '200 g de lardons',
        '4 œufs',
        '100 g de parmesan râpé',
        'Poivre noir',
        'Sel',
      ],
      steps: [
        'Faire cuire les pâtes dans une grande casserole d\'eau salée.',
        'Faire revenir les lardons jusqu\'à ce qu\'ils soient croustillants.',
        'Battre les œufs avec le parmesan et le poivre.',
        'Égoutter les pâtes et les mélanger hors du feu avec les lardons et la préparation aux œufs.',
        'Servir immédiatement avec du parmesan supplémentaire.',
      ],
      rating: 4.8,
    ),
    Recipe(
      id: '2',
      title: 'Salade César',
      description:
          'Salade fraîche et croquante avec poulet grillé, croûtons et sauce césar maison.',
      imageUrl: 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?w=800',
      category: 'Salade',
      preparationTime: 25,
      servings: 2,
      ingredients: [
        '1 laitue romaine',
        '2 filets de poulet',
        '50 g de parmesan',
        'Croûtons',
        'Sauce césar',
        'Huile d\'olive',
      ],
      steps: [
        'Griller les filets de poulet et les couper en lanières.',
        'Laver et couper la laitue.',
        'Mélanger la laitue avec la sauce césar.',
        'Ajouter le poulet, les croûtons et le parmesan.',
        'Servir frais.',
      ],
      rating: 4.5,
    ),
    Recipe(
      id: '3',
      title: 'Tarte Tatin',
      description:
          'Dessert français emblématique aux pommes caramélisées, servi tiède avec de la crème.',
      imageUrl: 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=800',
      category: 'Dessert',
      preparationTime: 60,
      servings: 6,
      ingredients: [
        '6 pommes Golden',
        '100 g de beurre',
        '150 g de sucre',
        '1 pâte feuilletée',
        'Crème fraîche (pour servir)',
      ],
      steps: [
        'Préparer le caramel avec le beurre et le sucre.',
        'Disposer les pommes dans le moule.',
        'Recouvrir de pâte feuilletée.',
        'Cuire 40 minutes à 180°C.',
        'Retourner et servir tiède.',
      ],
      rating: 4.9,
    ),
    Recipe(
      id: '4',
      title: 'Poulet Tikka Masala',
      description:
          'Plat indien épicé et crémeux, parfait avec du riz basmati ou du naan.',
      imageUrl: 'https://images.unsplash.com/photo-1565557623262-b51c2513f308?w=800',
      category: 'Indien',
      preparationTime: 45,
      servings: 4,
      ingredients: [
        '600 g de poulet',
        'Yaourt nature',
        'Épices tikka',
        'Tomates concassées',
        'Crème fraîche',
        'Oignon, ail, gingembre',
      ],
      steps: [
        'Mariner le poulet dans le yaourt et les épices.',
        'Faire revenir oignon, ail et gingembre.',
        'Ajouter les tomates et laisser mijoter.',
        'Incorporer le poulet et la crème.',
        'Servir avec du riz.',
      ],
      rating: 4.7,
    ),
    Recipe(
      id: '5',
      title: 'Ratatouille Provençale',
      description:
          'Légumes méditerranéens mijotés longuement pour un plat coloré et savoureux.',
      imageUrl: 'https://images.unsplash.com/photo-1572451479139-6a308211d8be?w=800',
      category: 'Végétarien',
      preparationTime: 50,
      servings: 4,
      ingredients: [
        '1 aubergine',
        '2 courgettes',
        '2 poivrons',
        '4 tomates',
        '1 oignon',
        'Ail, herbes de Provence',
      ],
      steps: [
        'Couper tous les légumes en dés.',
        'Faire revenir l\'oignon et l\'ail.',
        'Ajouter les légumes progressivement.',
        'Laisser mijoter 30 minutes avec les herbes.',
        'Servir chaud ou tiède.',
      ],
      rating: 4.6,
    ),
    Recipe(
      id: '6',
      title: 'Burger Maison',
      description:
          'Burger juteux avec steak haché, fromage fondant, salade et sauce maison.',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
      category: 'Américain',
      preparationTime: 30,
      servings: 2,
      ingredients: [
        '2 pains à burger',
        '300 g de bœuf haché',
        '2 tranches de cheddar',
        'Salade, tomate, oignon',
        'Sauce burger',
      ],
      steps: [
        'Former les steaks et les cuire.',
        'Toaster les pains.',
        'Monter le burger avec les garnitures.',
        'Ajouter la sauce et servir chaud.',
      ],
      rating: 4.4,
    ),
    Recipe(
      id: '7',
      title: 'Soupe à l\'Oignon',
      description:
          'Soupe traditionnelle française gratinée au fromage, réconfortante en hiver.',
      imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800',
      category: 'Soupe',
      preparationTime: 55,
      servings: 4,
      ingredients: [
        '1 kg d\'oignons',
        '1 L de bouillon de bœuf',
        'Beurre',
        'Pain de campagne',
        'Gruyère râpé',
      ],
      steps: [
        'Faire revenir les oignons longuement.',
        'Ajouter le bouillon et laisser mijoter.',
        'Verser dans des bols, ajouter pain et fromage.',
        'Gratiner au four.',
      ],
      rating: 4.7,
    ),
    Recipe(
      id: '8',
      title: 'Crêpes Suzette',
      description:
          'Crêpes fines flambées au grand marnier et beurre d\'orange.',
      imageUrl: 'https://images.unsplash.com/photo-1519676867240-f03562e64548?w=800',
      category: 'Dessert',
      preparationTime: 40,
      servings: 4,
      ingredients: [
        'Farine, œufs, lait',
        'Beurre',
        'Sucre',
        'Oranges',
        'Grand Marnier',
      ],
      steps: [
        'Préparer la pâte à crêpes.',
        'Cuire les crêpes.',
        'Préparer le beurre d\'orange.',
        'Flamber avec le Grand Marnier.',
        'Servir immédiatement.',
      ],
      rating: 4.9,
    ),
  ];

  List<Recipe> getAll() => List.unmodifiable(_recipes);

  Recipe? getById(String id) {
    try {
      return _recipes.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Recipe> search(String query) {
    if (query.isEmpty) return getAll();
    final lower = query.toLowerCase();
    return _recipes
        .where((r) =>
            r.title.toLowerCase().contains(lower) ||
            r.description.toLowerCase().contains(lower) ||
            r.category.toLowerCase().contains(lower) ||
            r.ingredients.any((i) => i.toLowerCase().contains(lower)))
        .toList();
  }

  List<Recipe> filterByCategory(String category) {
    if (category.isEmpty || category == 'Toutes') return getAll();
    return _recipes.where((r) => r.category == category).toList();
  }

  List<String> getCategories() {
    final cats = _recipes.map((r) => r.category).toSet().toList();
    cats.sort();
    return ['Toutes', ...cats];
  }

  List<Recipe> getFavorites() {
    return _recipes.where((r) => r.isFavorite).toList();
  }

  void toggleFavorite(String id) {
    final index = _recipes.indexWhere((r) => r.id == id);
    if (index != -1) {
      final recipe = _recipes[index];
      _recipes[index] = recipe.copyWith(isFavorite: !recipe.isFavorite);
    }
  }

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }

  void updateRecipe(Recipe recipe) {
    final index = _recipes.indexWhere((r) => r.id == recipe.id);
    if (index != -1) {
      _recipes[index] = recipe;
    }
  }
}
