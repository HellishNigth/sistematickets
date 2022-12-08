import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ClientesProvider {
  final apiURL = 'http://10.0.2.2:8000/api';

  //AGREGAR CLIENTES
  Future<LinkedHashMap<String, dynamic>> agregarCliente(String email) async {
    var respuesta = await http.post(
      Uri.parse(apiURL + '/clientes'),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{'email': email}),
    );

    return json.decode(respuesta.body);
  }

  Future<http.Response> confirmarRol(String email) async {
    var respuesta =
        await http.post(Uri.parse(apiURL + '/clientes/rol/' + email));

    return respuesta;
  }
}
