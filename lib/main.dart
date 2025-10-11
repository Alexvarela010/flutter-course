import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/isolate_screen.dart'; 
import 'screens/meal_list_screen.dart';
import 'screens/meal_detail_screen.dart'; // Importar la pantalla de detalle

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/meals', // Definimos la nueva ruta inicial
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'detail/:value',
          builder: (context, state) {
            final value = state.pathParameters['value']!;
            return DetailScreen(value: value);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/timer',
      builder: (context, state) => const TimerScreen(),
    ),
    GoRoute(
      path: '/isolate',
      builder: (context, state) => const IsolateScreen(),
    ),
    // --- Rutas para el nuevo módulo de Comidas ---
    GoRoute(
      path: '/meals',
      builder: (context, state) => const MealListScreen(),
      routes: [
        // Ruta para el detalle que crearemos después
        GoRoute(
          path: ':id', // Recibe el ID como parámetro de ruta
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return MealDetailScreen(mealId: id);
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Workshops',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    );
  }
}
