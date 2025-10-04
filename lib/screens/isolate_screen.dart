import 'dart:isolate';
import 'package:flutter/material.dart';

void heavyTask(SendPort sendPort) {
  print('[Isolate] Iniciando tarea pesada...');
  double result = 0;
  for (var i = 0; i < 1000000000; i++) {
    result += i;
  }
  print('[Isolate] Tarea completada. Enviando resultado...');
  sendPort.send(result);
}

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  bool _isRunning = false;
  String _status = 'En espera';
  String? _result;
  Isolate? _isolate;

  @override
  void dispose() {
    _isolate?.kill(priority: Isolate.immediate);
    print('IsolateScreen: dispose -> Isolate detenido.');
    super.dispose();
  }

  Future<void> _startHeavyTask() async {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _status = 'Procesando en Isolate...';
      _result = null;
    });

    final receivePort = ReceivePort();
    
    try {
       print('[UI] Creando Isolate...');
      _isolate = await Isolate.spawn(heavyTask, receivePort.sendPort);

      final result = await receivePort.first;

      print('[UI] Resultado recibido del Isolate.');
      setState(() {
        _status = 'Tarea completada';
        _result = 'Resultado: ${result.toStringAsFixed(0)}';
        _isRunning = false;
      });

    } catch (e) {
      print('[UI] Error al ejecutar el Isolate: $e');
      setState(() {
         _status = 'Error';
         _result = 'Ocurrió un error: $e';
         _isRunning = false;
      });
    } finally {
       _isolate?.kill(priority: Isolate.immediate);
       _isolate = null;
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cómputo con Isolate'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _status,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              if (_isRunning)
                const CircularProgressIndicator()
              else if (_result != null)
                Text(_result!, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isRunning ? null : _startHeavyTask,
                child: const Text('Iniciar Tarea Pesada'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
