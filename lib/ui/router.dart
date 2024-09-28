import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/aprendiz_page.dart';
import 'package:reconocimiento_app/ui/pages/home_page.dart';
import 'package:reconocimiento_app/ui/pages/login/login_screen.dart';
import 'package:reconocimiento_app/ui/pages/objetos_page.dart';
import 'package:reconocimiento_app/ui/pages/register/register_screen.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String facialRecognition = '/facial-recognition';
  static const String objetos = '/objetos';
  static const String aprendiz = '/aprendiz';
  static const String perfil = '/perfil';
  static const String configuracion = '/configuracion';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case login:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(apiService: ApiService()));
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case aprendiz:
        return MaterialPageRoute(builder: (_) => AprendizScreen());
      case objetos:
        return MaterialPageRoute(builder: (_) => ObjetosPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
