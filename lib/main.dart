import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intro Flutter',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'Hola, Flutter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Alex Stiben Varela Cabezas',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Reemplaza por tus assets o por NetworkImage
                Image.network(
                  'https://raw.githubusercontent.com/Klerith/mas-talento/refs/heads/main/angular/angular-logo.png',
                  width: 100,
                  height: 100,
                ),
                Image.asset(
                  'assets/img/springboot.png',
                  width: 100,
                  height: 100,
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  title = (title == 'Hola, Flutter')
                      ? '¡Título cambiado!'
                      : 'Hola, Flutter';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Título actualizado')),
                );
              },
              child: const Text('Cambiar título'),
            ),
          ],
        ),
      ),
    );
  }
}
