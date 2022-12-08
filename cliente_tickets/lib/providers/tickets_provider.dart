import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EventosProvider {
  final apiURL = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> getTickets() async {
    var respuesta = await http.get(Uri.parse(apiURL + '/eventos'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> comprarTicket(
    String nombreCliente,
    String rutCliente,
    String cliente_id,
    int precioTicket,
    int cantidad,
  ) async {
    var respuesta = await http.post(
      Uri.parse(apiURL + '/eventos'),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'nombreCliente': nombreCliente,
        'rutCliente': rutCliente,
        'cliente_id': cliente_id,
        'precioTicket': precioTicket,
        'cantidad': cantidad,
      }),
    );

    return json.decode(respuesta.body);
  }

  Future<List<dynamic>> getTicketsPersona() async {
    var respuesta = await http.get(Uri.parse(apiURL + '/eventos'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getTicketsCliente(String email) async {
    var respuesta =
        await http.get(Uri.parse(apiURL + '/clientes/' + email + '/cliente'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }
}
