import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EventosProvider {
  final apiURL = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> getEventos() async {
    var respuesta = await http.get(Uri.parse(apiURL + '/eventos'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> agregarEvento(
      String nombreEve,
      String detalleEve,
      String ubicacionEve,
      int precioEve,
      int cantidadTicket,
      String estado,
      String fechaEve) async {
    var respuesta = await http.post(
      Uri.parse(apiURL + '/eventos'),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'nombreEve': nombreEve,
        'detalleEve': detalleEve,
        'ubicacionEve': ubicacionEve,
        'precioEve': precioEve,
        'cantidadTicket': cantidadTicket,
        'estado': estado,
        'fechaEve': fechaEve
      }),
    );

    return json.decode(respuesta.body);
  }

  Future<LinkedHashMap<String, dynamic>> getEvento(String id) async {
    var respuesta = await http.get(Uri.parse(apiURL + '/eventos/' + id));
    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return LinkedHashMap();
    }
  }

  Future<bool> borrarEvento(int id) async {
    var respuesta =
        await http.delete(Uri.parse(apiURL + '/eventos/' + id.toString()));
    return respuesta.statusCode == 200;
  }

  Future<LinkedHashMap<String, dynamic>> editarEvento(
      int id,
      String nombreEve,
      String detalleEve,
      String ubicacionEve,
      int precioEve,
      int cantidadTicket,
      String estado,
      String fechaEve) async {
    var respuesta = await http.put(
      Uri.parse(apiURL + '/eventos/' + id.toString()),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'nombreEve': nombreEve,
        'detalleEve': detalleEve,
        'ubicacionEve': ubicacionEve,
        'precioEve': precioEve,
        'cantidadTicket': cantidadTicket,
        'estado': estado,
        'fechaEve': fechaEve
      }),
    );

    return json.decode(respuesta.body);
  }

  Future<LinkedHashMap<String, dynamic>> editarEstado(
      int id, String estado) async {
    var respuesta = await http.put(
      Uri.parse(apiURL + '/eventos/' + id.toString() + '/estado'),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'estado': estado,
      }),
    );

    return json.decode(respuesta.body);
  }
}
