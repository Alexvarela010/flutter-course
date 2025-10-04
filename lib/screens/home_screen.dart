import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/data_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Widget para el primer tab (contenido de HomePage adaptado)
class _HomeTab extends StatefulWidget {
  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  String title = 'Hola, Flutter';

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://raw.githubusercontent.com/Klerith/mas-talento/refs/heads/main/angular/angular-logo.png',
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/springboot.png'),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.check),
                    title: Text('Desarrollador Backend'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check),
                    title: Text('Desarrollador Frontend'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check),
                    title: Text('Desarrollador Mobile'),
                  ),
                ],
              ),
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
                  const SnackBar(content: Text('Título actualizado (no visible en AppBar)')),
                );
              },
              child: const Text('Cambiar título'),
            ),
          ],
        ),
      );
  }
}

class _AsyncTab extends StatefulWidget {
  const _AsyncTab({super.key});

  @override
  State<_AsyncTab> createState() => _AsyncTabState();
}

class _AsyncTabState extends State<_AsyncTab> {
  final DataService _dataService = DataService();
  String _dataState = 'Sin datos';
  String? _data;
  String? _error;

  Future<void> _fetchData() async {
    print('Antes de la llamada asíncrona.');
    setState(() {
      _dataState = 'Cargando...';
      _data = null;
      _error = null;
    });

    try {
      print('Durante la espera del Future...');
      final data = await _dataService.fetchData();
      setState(() {
        _dataState = 'Éxito';
        _data = data;
      });
      print('Después de la llamada asíncrona (Éxito).');
    } catch (e) {
      setState(() {
        _dataState = 'Error';
        _error = e.toString();
      });
       print('Después de la llamada asíncrona (Error).');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Estado: $_dataState', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            if (_dataState == 'Cargando...')
              const CircularProgressIndicator()
            else if (_data != null)
              Text(_data!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16))
            else if (_error != null)
              Text(_error!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red, fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('Consultar Datos'),
            ),
          ],
        ),
      ),
    );
  }
}


class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    print('HomeScreen: initState');
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    print('HomeScreen: didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('HomeScreen: build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Principal'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Home'),
            Tab(text: 'Grid'),
            Tab(text: 'Async'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _HomeTab(),

          GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print('HomeScreen: setState (al tocar item)');
                  // setState(() {}); // This setState is in the parent, not ideal.
                },
                child: Card(
                  child: Center(child: Text('Elemento $index')),
                ),
              );
            },
          ),
          
          const _AsyncTab(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'timer',
            child: const Icon(Icons.timer),
            onPressed: () => context.push('/timer'),
          ),
          const SizedBox(height: 12),

          FloatingActionButton.extended(
            heroTag: 'go',
            label: const Text('go'),
            onPressed: () {
              context.go('/detail/go');
            },
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'push',
            label: const Text('push'),
            onPressed: () {
              context.push('/detail/push');
            },
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'replace',
            label: const Text('replace'),
            onPressed: () {
              context.replace('/detail/replace');
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print('HomeScreen: dispose');
    _tabController.dispose();
    super.dispose();
  }
}
