class Meal {
  final String id;
  final String name;
  final String thumbnail;
  final String? instructions;
  final String? category;
  final String? area;
  final List<String> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.instructions,
    this.category,
    this.area,
    this.ingredients = const [],
  });

  // Factory constructor para crear una instancia de Meal desde un mapa JSON.
  factory Meal.fromJson(Map<String, dynamic> json) {

    // La API devuelve hasta 20 ingredientes y medidas en campos separados.
    // Los procesamos para crear una sola lista.
    final ingredients = <String>[];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      // Añadir solo si el ingrediente no es nulo ni está vacío.
      if (ingredient != null && ingredient.trim().isNotEmpty) {
        ingredients.add('${measure ?? ''} $ingredient'.trim());
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      instructions: json['strInstructions'],
      category: json['strCategory'],
      area: json['strArea'],
      ingredients: ingredients,
    );
  }
}
