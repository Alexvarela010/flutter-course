import 'dart:async';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  int _milliseconds = 0;
  bool _isRunning = false;
  bool _isPaused = false;

  @override
  void dispose() {
    // cancelar el timer al salir de la pantalla para evitar fugas de memoria.
    _timer?.cancel();
    print('TimerScreen: dispose -> Timer cancelado.');
    super.dispose();
  }

  void _startTimer() {
    if (_isRunning || _isPaused) return; // No hacer nada si ya está corriendo o pausado

    print('Iniciando cronómetro...');
    _isRunning = true;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _milliseconds += 100;
      });
    });
  }

  void _pauseTimer() {
    if (!_isRunning || _isPaused) return;

    print('Pausando cronómetro...');
    _timer?.cancel();
    _isPaused = true;
  }

  void _resumeTimer() {
    if (!_isRunning || !_isPaused) return;

    print('Reanudando cronómetro...');
    _isPaused = false;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _milliseconds += 100;
      });
    });
  }

  void _resetTimer() {
    print('Reiniciando cronómetro...');
    _timer?.cancel();
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
      _isPaused = false;
    });
  }

  String _formatTime() {
    int seconds = (_milliseconds / 1000).floor();
    int hundreds = ((_milliseconds % 1000) / 100).floor();
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$secondsStr.$hundreds s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronómetro con Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontFamily: 'monospace'),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Iniciar'),
                  onPressed: _isRunning ? null : _startTimer,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.pause),
                  label: const Text('Pausar'),
                  onPressed: _isRunning && !_isPaused ? _pauseTimer : null,
                   style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
                 ElevatedButton.icon(
                  icon: const Icon(Icons.play_circle_outline),
                  label: const Text('Reanudar'),
                  onPressed: _isPaused ? _resumeTimer : null,
                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reiniciar'),
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
