class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final int preparationTime; // minutes
  final int servings;
  final List<String> ingredients;
  final List<String> steps;
  final double rating;
  final bool isFavorite;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.preparationTime,
    required this.servings,
    required this.ingredients,
    required this.steps,
    this.rating = 0.0,
    this.isFavorite = false,
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? category,
    int? preparationTime,
    int? servings,
    List<String>? ingredients,
    List<String>? steps,
    double? rating,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      preparationTime: preparationTime ?? this.preparationTime,
      servings: servings ?? this.servings,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'preparationTime': preparationTime,
      'servings': servings,
      'ingredients': ingredients,
      'steps': steps,
      'rating': rating,
      'isFavorite': isFavorite,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      category: map['category'] as String,
      preparationTime: map['preparationTime'] as int,
      servings: map['servings'] as int,
      ingredients: List<String>.from(map['ingredients'] as List),
      steps: List<String>.from(map['steps'] as List),
      rating: (map['rating'] as num).toDouble(),
      isFavorite: map['isFavorite'] as bool? ?? false,
    );
  }
}
