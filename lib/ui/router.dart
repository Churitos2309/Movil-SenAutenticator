import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/historial_page_aprendiz.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/objetos_page.dart';
import 'package:reconocimiento_app/ui/pages/captura_facial.dart';
import 'package:reconocimiento_app/ui/pages/home_admin.dart';
import 'package:reconocimiento_app/ui/pages/home_aprendiz.dart';
import 'package:reconocimiento_app/ui/pages/home_instructor.dart';
import 'package:reconocimiento_app/ui/pages/home_page.dart';
import 'package:reconocimiento_app/ui/pages/inicio_sesion_facial/facial_login_page.dart';
import 'package:reconocimiento_app/ui/pages/login/login_screen.dart';
import 'package:reconocimiento_app/ui/pages/perfil.dart';
import 'package:reconocimiento_app/ui/pages/register/register_screen.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String registroFacial = '/facial-recognition';
  static const String inicioSesionFacial = '/inicio-sesion-facial';
  static const String objetos = '/objetos';
  static const String aprendiz = '/aprendiz';
  static const String perfil = '/perfil';
  static const String configuracion = '/configuracion';
  static const String homeAprendiz = '/homeAprendiz';
  static const String historial = '/historial';
  static const String baseAprendiz = '/baseAprendiz';
  static const String baseAdmin = '/baseAdmin';
  static const String baseInstructor = '/baseInstructor';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case login:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(apiService: ApiService()));
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case registroFacial:
        return MaterialPageRoute(builder: (_) => const FacialLoginPage());
      case inicioSesionFacial:
        return MaterialPageRoute(builder: (_) => CapturaFacial());
      case aprendiz:
        return MaterialPageRoute(builder: (_) => const ProfilePage(user: null,));
      case objetos:
        return MaterialPageRoute(builder: (_) => const ObjetosAprendizPage());
      case homeAprendiz:
        return MaterialPageRoute(builder: (_) => const HomeAprendiz());
      case historial:
        return MaterialPageRoute(builder: (_) => const HistorialAprendizPage());
      case perfil:
        return MaterialPageRoute(builder: (_) => const ProfilePage(user: null,));
      case baseAprendiz:
        return MaterialPageRoute(builder: (_) => const HomeAprendiz());
      case baseAdmin:
        return MaterialPageRoute(builder: (_) => const HomeAdmin());
      case baseInstructor:
        return MaterialPageRoute(builder: (_) => const HomeInstructor());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
