# Talleres Flutter: Conceptos Avanzados

Este proyecto es una aplicación de Flutter diseñada para demostrar conceptos clave de programación asíncrona y manejo de ciclo de vida, utilizando `go_router` para la navegación.

## Conceptos de Asincronía en Flutter

### 1. Asincronía con `Future` / `async` / `await`

- **Cuándo usarlo:** Para operaciones de I/O (entrada/salida) que toman tiempo pero no consumen mucho CPU, como peticiones HTTP, acceso a bases de datos o lectura de archivos. `Future` permite que la aplicación continúe ejecutándose sin bloquear el hilo principal (UI).

- **Implementación:**
  - Se creó un `DataService` que simula una consulta a un servidor con un `Future.delayed` de 3 segundos.
  - La pantalla `HomeScreen` (en la pestaña **Async**) utiliza `async/await` para esperar el resultado.
  - La interfaz muestra tres estados claramente definidos:
    1.  **Cargando:** Mientras el `Future` está en progreso.
    2.  **Éxito:** Si el `Future` se completa correctamente.
    3.  **Error:** Si el `Future` falla.

### 2. Temporizador con `Timer`

- **Cuándo usarlo:** Para ejecutar una acción repetidamente en intervalos de tiempo regulares. Es ideal para cronómetros, cuentas regresivas, animaciones o tareas periódicas como *polling*.

- **Implementación:**
  - Se desarrolló `TimerScreen`, una pantalla dedicada a un cronómetro.
  - Un `Timer.periodic` actualiza la UI cada 100 milisegundos.
  - Se implementaron controles para **Iniciar, Pausar, Reanudar y Reiniciar** el cronómetro.
  - Es fundamental llamar a `_timer?.cancel()` en el método `dispose` para liberar los recursos y evitar fugas de memoria cuando se abandona la pantalla.

### 3. Tareas Pesadas con `Isolate`

- **Cuándo usarlo:** Para operaciones que consumen mucho CPU (CPU-bound), como procesar imágenes grandes, realizar cálculos matemáticos complejos o parsear un JSON muy extenso. `Isolate` ejecuta la tarea en un hilo completamente separado, con su propia memoria, evitando que la UI se congele.

- **Implementación:**
  - Se creó la pantalla `IsolateScreen` para ejecutar una tarea pesada (una suma iterativa gigante).
  - La función `heavyTask` se ejecuta en un nuevo hilo gracias a `Isolate.spawn`.
  - La comunicación entre el hilo principal y el `Isolate` se realiza mediante `ReceivePort` y `SendPort`, permitiendo enviar el resultado de vuelta a la UI sin bloquearla.
  - La UI muestra el estado del cómputo y el resultado final.

## Flujo de la Aplicación y Pantallas

La navegación se gestiona con `go_router`.

1.  **Pantalla Principal (`/`)**
    - Contiene una `TabBar` con tres pestañas: **Home**, **Grid** y **Async** (demostración de `Future`).
    - Dispone de `FloatingActionButtons` para navegar a las siguientes pantallas:
      - **Cómputo con Isolate (`/isolate`):** Botón con ícono de chip.
      - **Cronómetro (`/timer`):** Botón con ícono de reloj.

2.  **Pantalla de Cronómetro (`/timer`)**
    - Muestra un cronómetro funcional con controles para iniciar, pausar, reanudar y reiniciar.

3.  **Pantalla de Cómputo Pesado (`/isolate`)**
    - Permite iniciar una tarea que consume mucho CPU en un hilo separado, mostrando el progreso sin congelar la aplicación.

---

## Ejercicio Anterior: go_router, Widgets y Ciclo de Vida

- **Rutas:**
  - `/` : Pantalla principal (`HomeScreen`)
  - `/detail/:value` : Pantalla secundaria (`DetailScreen`) que recibe un parámetro `value`.

- **Navegación con go_router:**
  - `context.go()`: Reemplaza la ruta actual.
  - `context.push()`: Agrega la ruta a la pila.
  - `context.replace()`: Reemplaza la ruta actual manteniendo el historial.

- **Widgets Usados:**
  - `GridView`, `TabBar`, `TabBarView`, `ListView`, `FloatingActionButton`.

- **Ciclo de Vida:**
  - Se imprime en consola la ejecución de `initState`, `didChangeDependencies`, `build`, y `dispose`.
