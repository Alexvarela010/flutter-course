import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/isolate_screen.dart'; // Importar la nueva pantalla

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
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
        GoRoute(
          path: 'timer',
          builder: (context, state) => const TimerScreen(),
        ),
        GoRoute( // ruta para el Isolate
          path: 'isolate',
          builder: (context, state) => const IsolateScreen(),
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
      title: 'Demo GoRouter',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    );
  }
}
