import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String _baseUrl = 'http://127.0.0.1:8000/senauthenticator/usuario/';

  Future<List<dynamic>> fetchUsuarios(String ficha, String documento, String tiempo) async {
    final url = Uri.parse('$_baseUrl?ficha=$ficha&documento=$documento&tiempo=$tiempo');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar datos de la API');
    }
  }
}
