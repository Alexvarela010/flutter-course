import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/springboot.png'),
                    ),
                  ),
                ),
              ],
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // Se llama una vez al crear el widget.
    print('HomeScreen: initState');
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    // Se llama cuando el widget depende de un InheritedWidget.
    print('HomeScreen: didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Se llama cada vez que se construye el widget.
    print('HomeScreen: build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Principal'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Home'),
            Tab(text: 'Grid'),
            Tab(text: 'Otro'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Primer tab: Home
          _HomeTab(),

        // Segundo tab: GridView
          GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print('HomeScreen: setState (al tocar item)');
                  setState(() {}); // Solo para evidenciar setState
                },
                child: Card(
                  child: Center(child: Text('Elemento $index')),
                ),
              );
            },
          ),
          // Tercer tab: Widget adicional (ListView)
          ListView(
            children: [
              ListTile(title: Text('Elemento A')),
              ListTile(title: Text('Elemento B')),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'go',
            label: Text('go'),
            onPressed: () {
              // Navega y reemplaza la ruta actual.
              context.go('/detail/go');
            },
          ),
          SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'push',
            label: Text('push'),
            onPressed: () {
              // Navega y agrega a la pila.
              context.push('/detail/push');
            },
          ),
          SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'replace',
            label: Text('replace'),
            onPressed: () {
              // Reemplaza la ruta actual.
              context.replace('/detail/replace');
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Se llama al destruir el widget.
    print('HomeScreen: dispose');
    _tabController.dispose();
    super.dispose();
  }

}


