// import 'dart:convert';
// import 'dart:io'; // Para manejar el archivo de imagen

// import 'package:http/http.dart' as http;
// import 'package:path/path.dart'; // Para obtener el nombre del archivo

// class ApiService {

//   final http.Client client;
//   final String baseUrl = 'https://senauthenticator-6nrt.onrender.com/api/';

//   ApiService({http.Client? client}) : client = client ?? http.Client();

//   dynamic _processResponse(http.Response response) {
//   if (response.statusCode >= 200 && response.statusCode < 300) {
//     // Decodificar la respuesta JSON
//     var decodedResponse = jsonDecode(response.body);

//     // Ahora puedes usar los corchetes si decodedResponse es un Map
//     if (decodedResponse is Map<String, dynamic>) {
//       return decodedResponse;
//     } else if (decodedResponse is List) {
//       return decodedResponse;
//     } else {
//       throw Exception('Formato de respuesta no reconocido');
//     }
//   } else {
//     throw Exception(
//         'Error en la solicitud: ${response.statusCode} - ${response.body}');
//   }
// }

//   Future<dynamic> postWithImage(String endpoint, File imageFile) async {
//   try {
//     // Crear una solicitud multipart para subir archivos
//     var request = http.MultipartRequest('POST', Uri.parse(baseUrl + endpoint));

//     // Añadir encabezados si es necesario
//     request.headers.addAll({
//       'Content-Type': 'multipart/form-data',
//       // Añade más encabezados aqui si es necesario
//     });

//     // Adjuntar el archivo de imagen
//     request.files.add(await http.MultipartFile.fromPath(
//       'face_login', // Este es el nombre esperado en el backend
//       imageFile.path,
//       filename: basename(imageFile.path), // Nombre del archivo
//     ));

//     // Hacer la solicitud
//     var response = await request.send();

//     // Procesar la respuesta
//     if (response.statusCode == 200) {
//       var responseData = await response.stream.bytesToString();
//       return jsonDecode(responseData);
//     } else {
//       throw Exception('Error en la solicitud: ${response.statusCode}');
//     }
//   } catch (e) {
//     throw Exception('Error en la solicitud POST con imagen: $e');
//   }
// }

//   // Método para realizar solicitudes GET
//   // Future<List<dynamic>> get(String endpoint) async {
//   //   final response = await client.get(Uri.parse(baseUrl + endpoint));
//   //   return _processResponse(response);
//   // }

//   Future<http.Response> get(String endpoint) async {
//     // final url = Uri.parse(baseUrl + endpoint);
//     final response = await http.get(Uri.parse(baseUrl + endpoint));
//     return response;
//   }

//   // Método para obtener el perfil de usuario
//   Future<Map<String, dynamic>> getProfile(String endpoint) async {
//     final response = await client.get(Uri.parse(baseUrl + endpoint));
//     final data = _processResponse(response);
//     if (data is List && data.isNotEmpty) {
//       return data[0]
//           as Map<String, dynamic>; // Cambiar de 1 a 0 si es el primer elemento
//     } else {
//       throw Exception('La respuesta no contiene datos válidos');
//     }
//   }

//   // Método para realizar solicitudes POST
//   Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
//   try {
//     final response = await client
//         .post(
//           Uri.parse(baseUrl + endpoint),
//           headers: {'Content-Type': 'application/json'},
//           body: jsonEncode(data),
//         )
//         .timeout(const Duration(seconds: 10));

//     if (response.body.isEmpty) {
//       throw Exception('La respuesta del servidor es vacía');
//     }

//     // Decodificar la respuesta antes de usarla
//     var decodedResponse = jsonDecode(response.body);

//     // Ahora puedes acceder al mapa decodificado
//     return decodedResponse;
//   } catch (e) {
//     throw Exception('Error en la solicitud POST: $e');
//   }
// }

//   // Método para realizar solicitudes PUT
//   Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
//     final response = await client.put(
//       Uri.parse(baseUrl + endpoint),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(data),
//     );
//     return _processResponse(response);
//   }

//   // Método para realizar solicitudes DELETE
//   Future<dynamic> delete(String endpoint) async {
//     final response = await client.delete(Uri.parse(baseUrl + endpoint));
//     return _processResponse(response);
//   }
// }

import 'dart:convert';
import 'dart:io'; // Para manejar el archivo de imagen

import 'package:http/http.dart' as http;
import 'package:path/path.dart'; // Para obtener el nombre del archivo

class ApiService {
  final http.Client client;
  final String baseUrl = 'https://senauthenticator-6nrt.onrender.com/api/';

  ApiService({http.Client? client}) : client = client ?? http.Client();

  // Método para procesar la respuesta de la API
  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Decodificar la respuesta JSON
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is Map<String, dynamic>) {
        return decodedResponse;
      } else if (decodedResponse is List) {
        return decodedResponse;
      } else {
        throw Exception('Formato de respuesta no reconocido');
      }
    } else {
      throw Exception(
          'Error en la solicitud: ${response.statusCode} - ${response.body}');
    }
  }

  // Método para realizar solicitudes POST con una imagen
  Future<dynamic> postWithImage(String endpoint, File imageFile) async {
    try {
      // Crear una solicitud multipart para subir archivos
      var request =
          http.MultipartRequest('POST', Uri.parse(baseUrl + endpoint));

      // Añadir encabezados si es necesario
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        // Añade más encabezados aquí si es necesario
      });

      // Adjuntar el archivo de imagen
      request.files.add(await http.MultipartFile.fromPath(
        'face_login', // Este es el nombre esperado en el backend
        imageFile.path,
        filename: basename(imageFile.path), // Nombre del archivo
      ));

      // Hacer la solicitud
      var response = await request.send();

      // Procesar la respuesta
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        return jsonDecode(responseData);
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud POST con imagen: $e');
    }
  }

  // Método para realizar solicitudes GET
  Future<http.Response> get(String endpoint) async {
    final response = await client.get(Uri.parse(baseUrl + endpoint));
    return _processResponse(response);
  }

  Future<dynamic> getWithHeaders(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response = await client.get(
        Uri.parse(baseUrl + endpoint),
        headers: headers,
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Error en la solicitud GET: $e');
    }
  }

// Método para obtener una lista de datos de un endpoint
  Future<dynamic> getList(String endpoint) async {
    try {
      final response = await client.get(Uri.parse(baseUrl + endpoint));

      // Procesar la respuesta
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Decodificar el cuerpo de la respuesta
        var decodedResponse = jsonDecode(response.body);

        // Comprobar si el resultado es una lista
        if (decodedResponse is List<dynamic>) {
          return decodedResponse; // Retorna la lista decodificada
        } else {
          throw Exception(
              'Se esperaba una lista, pero se recibió: $decodedResponse');
        }
      } else {
        throw Exception(
            'Error en la solicitud: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud GET: $e');
    }
  }

  // Método para obtener el perfil de usuario
  Future<Map<String, dynamic>> getProfile(String endpoint) async {
    final response = await client.get(Uri.parse(baseUrl + endpoint));
    final data = _processResponse(response);
    if (data is List && data.isNotEmpty) {
      return data[0]
          as Map<String, dynamic>; // Cambiar de 1 a 0 si es el primer elemento
    } else {
      throw Exception('La respuesta no contiene datos válidos');
    }
  }

  // Método para realizar solicitudes POST
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await client
          .post(
            Uri.parse(baseUrl + endpoint),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));

      if (response.body.isEmpty) {
        throw Exception('La respuesta del servidor es vacía');
      }

      // Decodificar la respuesta antes de usarla
      var decodedResponse = jsonDecode(response.body);
      return decodedResponse;
    } catch (e) {
      throw Exception('Error en la solicitud POST: $e');
    }
  }

  // Método para realizar solicitudes PUT
  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final response = await client.put(
      Uri.parse(baseUrl + endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  // Método para realizar solicitudes DELETE
  Future<dynamic> delete(String endpoint) async {
    final response = await client.delete(Uri.parse(baseUrl + endpoint));
    return _processResponse(response);
  }
}
