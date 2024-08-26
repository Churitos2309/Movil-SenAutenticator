import 'dart:convert';

import 'package:reconocimiento_app/models/user_model.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class UserService {
  final ApiService apiService = ApiService();

  Future<List<User>> fetchActiveUsers() async {
    final response = await apiService.getUrl('usuario/');
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).where((user) => user.isActive).toList();
    } else {
      throw Exception('Failed to load users');
    }
    // return users.where((user) => user.isActive).toList();
  }

  Future<List<User>> fetchUsersByRole(String role) async {
    final response = await apiService.getUrl('usuario/');
    print('Response status: ${response.statusCode}');
    print('Response status: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).where((user) => user.rol == role).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}