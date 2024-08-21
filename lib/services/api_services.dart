import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://backendsenauthenticator.onrender.com/api/';

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse(baseUrl + endpoint));
    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  Future<dynamic> put(String enpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse(baseUrl + enpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(Uri.parse(baseUrl + endpoint));
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  // // agrego el metodo fetch para obtener todos los usuarios 

  // Future<List<dynamic>> fetchUsuarios(String ficha, String documento, String tiempo) async {
  //   final queryParameters = {
  //     'ficha': ficha,
  //     'documento': documento,
  //     'tiempo': tiempo,
  //   };
  //   final uri = Uri.parse(baseUrl + 'usuario/').replace(queryParameters: queryParameters);
  //   final response = await http.get(uri);
  //   return _processResponse(response);
  // }

}
