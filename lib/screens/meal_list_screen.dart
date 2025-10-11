import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/meal_service.dart';
import '../models/meal.dart';

class MealListScreen extends StatefulWidget {
  const MealListScreen({super.key});

  @override
  State<MealListScreen> createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  final MealService _mealService = MealService();
  late Future<List<Meal>> _mealsFuture;

  @override
  void initState() {
    super.initState();
    // Iniciamos la petición a la API aquí, para que solo se ejecute una vez.
    _fetchMeals();
  }

  void _fetchMeals() {
    setState(() {
      _mealsFuture = _mealService.getMealsByFirstLetter('a');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas de Comida'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchMeals, // Permite recargar los datos
          ),
        ],
      ),
      body: FutureBuilder<List<Meal>>(
        future: _mealsFuture,
        builder: (context, snapshot) {
          // Estado: Cargando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Estado: Error
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error al cargar las recetas: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            );
          }

          // Estado: Éxito (pero sin datos)
          final meals = snapshot.data;
          if (meals == null || meals.isEmpty) {
            return const Center(child: Text('No se encontraron recetas.'));
          }

          // Estado: Éxito (con datos)
          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: Hero(
                    tag: meal.id, // Tag único para la animación
                    child: Image.network(
                      meal.thumbnail,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        return progress == null ? child : const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50);
                      },
                    ),
                  ),
                  title: Text(meal.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(meal.category ?? 'Sin categoría'),
                  onTap: () {
                    // Navegación a la pantalla de detalle
                     context.go('/meals/${meal.id}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
