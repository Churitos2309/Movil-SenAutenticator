// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthProvider with ChangeNotifier {
//   bool _isLoggedIn = false;

//   bool get isLoggedIn => _isLoggedIn;

//   Future<void> checkAuth() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _isLoggedIn = prefs.containsKey('token');
//     notifyListeners();
//   }

//   Future<void> login(String token) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('token', token);
//     _isLoggedIn = true;
//     notifyListeners();
//   }

//   Future<void> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('token');
//     _isLoggedIn = false;
//     notifyListeners();
//   }
// }



import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkAuth() async {
    try {
      // Lógica para verificar si el usuario está autenticado
      // Esto puede incluir verificar un token almacenado en SharedPreferences
      // o realizar una llamada API para validar el token.
      final token = await _getTokenFromStorage();
      _isLoggedIn = token != null && token.isNotEmpty;
    } catch (e) {
      _isLoggedIn = false;
    } finally {
      notifyListeners();
    }
  }

  Future<String?> _getTokenFromStorage() async {
    // Simular una lectura del token (ejemplo con SharedPreferences)
    // Aquí es donde buscarías el token en tu almacenamiento local
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getString('token');
    return 'mockToken'; // Simulando token para pruebas
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    notifyListeners();
    // Lógica para cerrar sesión y limpiar el token del almacenamiento
  }
}
