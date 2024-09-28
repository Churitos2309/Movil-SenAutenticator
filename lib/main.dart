import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'package:reconocimiento_app/services/scroll_provider.dart';
// import 'package:reconocimiento_app/ui/pages/administrador/main.dart';
import 'package:reconocimiento_app/ui/pages/administrador/widgets/bottom_nav_bar_admin.dart';
import 'package:reconocimiento_app/ui/pages/fichas/fichas_pagina.dart';
import 'package:reconocimiento_app/ui/pages/guarda_seguridad/main.dart';
import 'package:reconocimiento_app/ui/pages/ingreso/ingreso_page.dart';
import 'package:reconocimiento_app/ui/pages/instructor/reportes_instructor/reportes_instructor.dart';
import 'package:reconocimiento_app/ui/pages/login/login_screen.dart';
import 'package:reconocimiento_app/ui/pages/objetos/objetos_page.dart';
import 'package:reconocimiento_app/ui/pages/profile/profile_new_page.dart';
import 'package:reconocimiento_app/ui/pages/profile/profile_page.dart';
import 'package:reconocimiento_app/ui/pages/register/register_screen.dart';
import 'package:reconocimiento_app/ui/pages/tutores/tutores_page.dart';
import 'package:reconocimiento_app/ui/pages/usuarios/usuarios_page.dart';
import 'package:reconocimiento_app/ui/widgets/curved_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:reconocimiento_app/lib/components/roles/admin/Graficas/graficas_page.dart';
import 'package:reconocimiento_app/lib/components/roles/admin/Reportes/reportes_page.dart';
import 'package:reconocimiento_app/lib/components/roles/admin/inicio/admin_menu.dart';
import 'package:reconocimiento_app/lib/components/roles/admin/navigation_admin.dart';
import 'package:reconocimiento_app/lib/components/roles/Instructor/navigation_Instructor.dart';
import 'package:reconocimiento_app/lib/components/roles/usuario/navigation_aprendiz.dart';

// Punto de entrada de la aplicacion.|
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScrollProvider()),
      ],
      child: MyApp(),
    ),
  );
}

// Definicion de la clase MyApp, que extiende StatelessWidget.
// StatelessWidget significa que este widget no tiene estado mutable.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp envuelve la aplicacion y la configura.
    return MaterialApp(
      // Desactiva la etiqueta de depuracion.
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // Define el tema de la aplicacion.
      theme: ThemeData(
        // Configura el tema de los iconos en la aplicacipn.
        iconTheme: const IconThemeData(color: Color.fromRGBO(40, 40, 40, 1)),
        // Configura el tema de la barra de aplicaciones (AppBar).
        appBarTheme: const AppBarTheme(
          // Define la elevacion de la barra de aplicaciones.
          elevation: 1,
          // Establece el color de fondo de la barra de aplicaciones.
          color: Colors.white,
          // Define el tema para los iconos en la barra de aplicaciones.
          iconTheme: IconThemeData(color: Color.fromRGBO(40, 40, 40, 1)),
        ),
        // Utiliza un esquema de colores basado en una semilla de color.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // Indica que se debe usar el nuevo diseño de Material 3.
        useMaterial3: true,
      ),
      // Establece la pagina de inicio de la aplicacion como MyHomePage.
      // Este widget sera la pantalla principal que se muestra cuando la aplicación se inicia.
      // home: BottomNavBar(),
      initialRoute: '/inicioInstructor',
      routes: {
        // '/home': (context) => _checkAuth(context, '/home'),
        // '/home': (context) => const MyHomePage(),
        // '/': (context) => FacialRecognitionPage(),
        // '/': (context) => RegisterFacePage(),
        '/': (context) => BottomNavBarAdmin(),
        // '/': (context) => BottonNavScreen(),
        // '/registro': (context) => const RegisterScreen(screenState: RegisterScreenState()),
        // '/registro': (context) => RegisterScreen(screenState: RegisterScreenState()),
        '/registro': (context) {
          // final screenState = MockRegisterScreenState();
          // return RegisterScreen(screenState: MockRegisterScreenState(),);
          return RegisterScreen();
        },
        '/vistaLogin': (context) => LoginScreen(
              apiService: ApiService(),
            ),
        // '/instructor': (context) => BottomNavBarInstructor(),
        '/guardaseguridad': (context) => BottomNavBarGuardaSeguridad(),
        // '/admin': (context) => const AdminPage(),
        '/home': (context) => BottomNavBar(),
        '/usuario': (context) => BottomNavBar(),

        '/fichas': (context) => const FichasPage(),
        '/objetos': (context) => const ObjetosPage(),
        '/ingresos': (context) => const IngresoPage(),
        '/usuarios': (context) => const UsuariosPage(),
        '/paginaUsuario': (context) => const UsuariosPage(),
        '/tutores': (context) => const TutoresPage(),
        '/reportesInstructor': (context) => const ReportesInstructor(),
        // '/perfil': (context) => const ProfilePage(),
        '/perfilnew': (context) => const UserProfile(),
        '/perfil': (context) => const ProfilePage(),
        // '/camera': (context) => CameraPage(),

        '/inicioadmin': (context) => const NavigationAdmin(),
        '/inicioInstructor': (context) => const NavigationInstructor(),
        '/inicioAprendiz': (context) => const NavigationAprendiz(),
      },
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkIfLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.data == true) {
          return LoginScreen(
            apiService: ApiService(),
          );
        } else {
          return const BottomNavBarAdmin();
        }
      },
    );
  }
}

// class MockRegisterScreenState extends Mock implements RegisterScreenState {
//   @override
//   Future<void> _register() async {
//     // Implementación de la función _register
//   }
// }

Future<void> _checkAuth(BuildContext context, String route) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('token')) {
    Navigator.pushReplacementNamed(context, '/login');
  } else {
    Navigator.pushNamed(context, route);
  }
}

Future<bool> _checkIfLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('token');
}

Future<void> _logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');

  Navigator.pushReplacementNamed(context, '/login');
}
