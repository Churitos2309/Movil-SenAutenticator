// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

// Inicio de sesión usuario

Future<http.Response> sendLoginRequest(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse("https://apimercadolibreochoa.onrender.com/api/users"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
      }),
    );

    return response;
  } catch (e) {
    // Maneja el error de red o cualquier otro error
    print("Error durante la solicitud de inicio de sesión: $e");
    return http.Response('{"error": "Error en la solicitud"}', 500);
  }
}

//1. Registrar usuarios

Future<Users> createUsers(String nombre, String email, String password) async {
  final response = await http.post(
    Uri.parse('https://apimercadolibreochoa.onrender.com/api/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "nombre": nombre,
      "email": email,
      "password": password
    }),
  );

  if (response.statusCode == 201) {
    return Users.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('No es posible registrarse');
  }
}

class Users {
  final String? id;
  final String? nombre;
  final String? email;
  final String? password;

  const Users({
    required this.id,
    required this.nombre,
    required this.email,
    required this.password,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['_id'] ?? '',
      nombre: json['nombre'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Users.empty()
      : id = '',
        nombre = '',
        email = '',
        password = '';
}

//2. Consultar usuarios
Future<List<Users>> consultUsers() async {
  final response = await http.get(Uri.parse('https://apimercadolibreochoa.onrender.com/api/users'));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Users.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}

/////////////////////////////////////////////
/// 3. eliminar un usuario

Future<void> deleteUsers(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://apimercadolibreochoa.onrender.com/api/users/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to delete user.');
  }
}

//4. Actualizar un usuario
Future<Users> updateUser(String id, String nombre, String email) async {
  print('updateUser called with userId= $id, nombre=$nombre, email=$email');
  try {
    final response = await http.put(
      Uri.parse('https://apimercadolibreochoa.onrender.com/api/users/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "nombre": nombre,
        "email": email,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      final user = responseBody['user'];

      if (user != null && user['password'] != null) {
        // La contraseña existe y no es nula, podemos procesarla
        final password = user['password'];
        // Procesar la contraseña encriptada
        print('Contraseña encriptada: $password');
      } else {
        // La contraseña no existe o es nula, no la procesamos
        print('No se proporcionó contraseña');
      }

      return Users.fromJson(user);
    } else {
      throw Exception('Failed to update user');
    }
  } catch (e) {
    print('Error al conectar a la base de datos: $e');
    rethrow;
  }
}
