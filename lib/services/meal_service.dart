import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class MealService {
  static const String _baseUrl = 'www.themealdb.com';
  static const String _apiKey = '1'; // Usando la clave de prueba

  // Busca comidas por la primera letra
  Future<List<Meal>> getMealsByFirstLetter(String letter) async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/$_apiKey/search.php', {'f': letter});

    print('Consultando URL: $uri');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // La API devuelve {"meals": [...]} o {"meals": null}
        final data = json.decode(response.body);
        if (data['meals'] != null) {
          final List<dynamic> mealList = data['meals'];
          // Convertimos la lista de JSON a una lista de objetos Meal
          return mealList.map((json) => Meal.fromJson(json)).toList();
        }
        return []; // Devuelve una lista vacía si "meals" es nulo
      } else {
        // Error en la respuesta del servidor
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      // Error de red u otro problema
      print('Error en MealService: $e');
      throw Exception('No se pudo establecer conexión. Revisa tu red.');
    }
  }

  // Busca los detalles completos de una comida por su ID
  Future<Meal> getMealDetailsById(String id) async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/$_apiKey/lookup.php', {'i': id});
    print('Consultando URL: $uri');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
         if (data['meals'] != null && data['meals'].isNotEmpty) {
          return Meal.fromJson(data['meals'][0]); // El lookup devuelve una lista con un solo item
        } else {
          throw Exception('Comida no encontrada.');
        }
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en MealService: $e');
      throw Exception('No se pudo obtener el detalle. Inténtalo de nuevo.');
    }
  }
}
