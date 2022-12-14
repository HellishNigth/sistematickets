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

  // Future<LinkedHashMap<String, dynamic>> confirmarRol(String email) async {
  //   var respuesta = await http.get(Uri.parse(apiURL + '/clientes/rol' + email));
  //   if (respuesta.statusCode == 200) {
  //     return json.decode(respuesta.body);
  //   } else {
  //     return LinkedHashMap();
  //   }
  // }

}
