import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  final FocusNode numeroIdentificacionFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final TextEditingController numeroIdentificacionController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Color numeroIdentificacionTextColor = Colors.grey;
  Color passwordTextColor = Colors.grey;

  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Lo expones

  final ApiService apiService; // Instancia de ApiService

  LoginController(this.apiService);

  void onNumeroIdentificacionFocusChange() {
    notifyListeners();
  }

  void onPasswordFocusChange() {
    notifyListeners();
  }

  void _validarToken(String token, String? rol, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    if (rol != null && rol.isNotEmpty) {
      await prefs.setString('rol', rol);
      switch (rol) {
        case 'Administrador':
          Navigator.pushReplacementNamed(context, '/');
          break;
        case 'Instructor':
          Navigator.pushReplacementNamed(context, '/fichas');
          break;
        case 'Aprendiz':
          Navigator.pushReplacementNamed(context, '/objetos');
          break;
        case 'Guardia de seguridad':
          Navigator.pushReplacementNamed(context, '/usuarios');
          break;
        default:
          Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      await prefs.setString('rol', '');
      Navigator.pushReplacementNamed(context, '/error');
    }
  }

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final responseData = await apiService.post('inicio-sesion/', {
        'numero_documento_usuario': numeroIdentificacionController.text,
        'password': passwordController.text,
      });

      if (responseData != null && responseData['token'] != null) {
        final token = responseData['token'];
        final rol = responseData['user']?['rol_usuario'];
        _validarToken(token, rol, context);
      } else {
        throw Exception('Error: Token no proporcionado por el servidor');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
