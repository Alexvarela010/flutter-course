# Taller Flutter: Consumo de API con `http` y `go_router`

Este proyecto demuestra cómo construir un módulo en Flutter para consumir datos de una API pública, gestionar estados (carga, éxito, error) y navegar entre una vista de listado y una de detalle.

## 1. API Utilizada: TheMealDB

- **Descripción:** Una API pública y gratuita que provee datos sobre recetas de comida de todo el mundo.
- **Endpoint Principal (Listado):** `https://www.themealdb.com/api/json/v1/1/search.php?f=a`
- **Endpoint de Detalle:** `https://www.themealdb.com/api/json/v1/1/lookup.php?i={idMeal}`

- **Ejemplo de Respuesta JSON (reducido):**
  ```json
  {
    "meals": [
      {
        "idMeal": "52771",
        "strMeal": "Spicy Arrabiata Penne",
        "strCategory": "Vegetarian",
        "strMealThumb": "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg",
        "strInstructions": "...",
        "strIngredient1": "penne rigate",
        "strMeasure1": "1 pound",
        // ... (hasta 20 ingredientes y medidas)
      }
    ]
  }
  ```

## 2. Arquitectura y Estructura de Carpetas

El proyecto sigue una arquitectura limpia para separar responsabilidades:

- **`/lib/models/`**: Contiene los modelos de datos (`meal.dart`). Su principal responsabilidad es definir la estructura del objeto y proveer un método `fromJson` para parsear la respuesta de la API.

- **`/lib/services/`**: Contiene la lógica de negocio y comunicación con la API (`meal_service.dart`). Centraliza las peticiones `http`, el manejo de errores de red y la transformación de datos.

- **`/lib/screens/`**: Contiene los widgets que representan las pantallas de la aplicación (`meal_list_screen.dart`, `meal_detail_screen.dart`). Se encargan exclusivamente de la UI y de reaccionar a los diferentes estados.

## 3. Manejo de Estado y Navegación

- **Gestión de Estado:** Se utiliza un `FutureBuilder` en ambas pantallas para manejar de forma declarativa los tres estados principales:
  1.  **Cargando:** Muestra un `CircularProgressIndicator` mientras se espera la respuesta de la API.
  2.  **Éxito:** Muestra los datos una vez que se han recibido y procesado correctamente.
  3.  **Error:** Muestra un mensaje descriptivo si ocurre un problema durante la petición.

- **Navegación con `go_router`:**
  - La ruta `/meals` está configurada como la ruta inicial de la aplicación y muestra `MealListScreen`.
  - Al tocar un elemento de la lista, se navega a la ruta anidada `/meals/:id`, pasando el ID de la comida como parámetro en la URL.
  - `MealDetailScreen` lee el `id` de los parámetros de la ruta para solicitar los detalles específicos de esa comida.
  - El botón "atrás" es gestionado automáticamente por `go_router`, devolviendo al usuario a la pantalla de listado.

---

# Talleres Anteriores

## Taller: Conceptos Avanzados (Future, Timer, Isolate)

- **Pantallas**: `HomeScreen`, `TimerScreen`, `IsolateScreen`.
- **Rutas**: `/`, `/timer`, `/isolate`.
- **Conceptos**: Demostraciones de `Future.delayed`, `Timer.periodic`, y `Isolate.spawn`.

## Taller: go_router, Widgets y Ciclo de Vida

- **Rutas**: `/detail/:value`.
- **Conceptos**: Uso básico de `go_router` y logs del ciclo de vida de los widgets.
