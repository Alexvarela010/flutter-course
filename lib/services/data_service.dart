import 'dart:async';
import 'dart:math';

class DataService {
  Future<String> fetchData() async {
    print('Iniciando consulta de datos...');
    await Future.delayed(const Duration(seconds: 3));

    if (Random().nextBool()) {
      print('Consulta exitosa.');
      return 'Datos obtenidos exitosamente desde el servidor simulado.';
    } else {
      print('Error en la consulta.');
      throw 'Error: No se pudieron cargar los datos.';
    }
  }
}
