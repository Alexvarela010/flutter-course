import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String value;
  const DetailScreen({required this.value, super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // Se llama una vez al crear el widget.
    print('DetailScreen: initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // Se llama cuando el widget depende de un InheritedWidget.
    print('DetailScreen: didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Se llama cada vez que se construye el widget.
    print('DetailScreen: build');
    return Scaffold(
      appBar: AppBar(title: Text('Detalle')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Valor recibido: ${widget.value}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                print('DetailScreen: setState (al presionar botón)');
                setState(() {}); // Solo para evidenciar setState
              },
              child: Text('setState'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Se llama al destruir el widget.
    print('DetailScreen: dispose');
    super.dispose();
  }
}

