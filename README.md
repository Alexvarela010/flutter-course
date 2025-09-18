# talleres

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Ejercicio Flutter: go_router, Widgets y Ciclo de Vida

## Arquitectura y Navegación

- **Rutas:**
  - `/` : Pantalla principal (`HomeScreen`)
  - `/detail/:value` : Pantalla secundaria (`DetailScreen`) que recibe un parámetro `value`.

- **Envío de parámetros:**
  - El parámetro `value` se pasa en la URL al navegar a `/detail/:value`.
  - Se accede en la pantalla secundaria mediante `state.params['value']`.

- **Navegación con go_router:**
  - `context.go('/detail/123')`: Reemplaza la ruta actual (no se puede volver atrás).
  - `context.push('/detail/456')`: Agrega la ruta a la pila (se puede volver atrás).
  - `context.replace('/detail/789')`: Reemplaza la ruta actual (similar a go, pero mantiene el historial).

## Widgets Usados

- **GridView:** Muestra una cuadrícula de elementos en la pantalla principal. Permite visualizar listas de forma eficiente.
- **TabBar y TabBarView:** Permiten navegar entre secciones dentro de la pantalla principal, mejorando la organización de la UI.
- **ListView:** Como tercer widget, muestra una lista simple en el segundo tab.
- **FloatingActionButton:** Se usan tres para demostrar los diferentes métodos de navegación.

## Ciclo de Vida

- Se imprime en consola la ejecución de `initState`, `didChangeDependencies`, `build`, `setState` y `dispose` en ambas pantallas.
- Cada método tiene un comentario breve explicando cuándo y por qué se llama.
