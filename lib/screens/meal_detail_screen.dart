import 'package:flutter/material.dart';
import '../services/meal_service.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;

  const MealDetailScreen({super.key, required this.mealId});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final MealService _mealService = MealService();
  late Future<Meal> _mealDetailFuture;

  @override
  void initState() {
    super.initState();
    // Buscamos los detalles de la comida usando el ID que recibimos.
    _mealDetailFuture = _mealService.getMealDetailsById(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la Receta'),
      ),
      body: FutureBuilder<Meal>(
        future: _mealDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No se encontraron detalles para esta receta.'));
          }

          final meal = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: meal.id, // Mismo tag que en la lista para la animación
                  child: Image.network(
                    meal.thumbnail,
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.category, size: 20, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(meal.category ?? 'N/A', style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(width: 16),
                          const Icon(Icons.public, size: 20, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(meal.area ?? 'N/A', style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Instrucciones',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        meal.instructions ?? 'No hay instrucciones disponibles.',
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 24),
                       Text(
                        'Ingredientes',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      // Mapeamos la lista de ingredientes a una lista de Widgets
                      ...meal.ingredients.map((ingredient) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text('• $ingredient'),
                      )).toList(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
