import 'package:flutter/material.dart';
// import 'package:reconocimiento_app/ui/pages/aprendiz/Objetos/objetos_screen.dart';
// import 'package:reconocimiento_app/ui/pages/administrador/main.dart';
import 'package:reconocimiento_app/ui/pages/fichas/fichas_pagina.dart';
import 'package:reconocimiento_app/ui/pages/home/home_page.dart';
import 'package:reconocimiento_app/ui/widgets/navegador_admin.dart';
import 'package:reconocimiento_app/ui/pages/ingreso/ingreso_page.dart';
import 'package:reconocimiento_app/ui/widgets/navegador_aprendiz.dart';
import 'package:reconocimiento_app/ui/widgets/navegador_instructor.dart';
import 'package:reconocimiento_app/ui/widgets/navegador_admin.dart';
import 'package:reconocimiento_app/ui/pages/instructor/reportes_instructor/reportes_instructor.dart';
import 'package:reconocimiento_app/ui/pages/login/login_screen.dart';
import 'package:reconocimiento_app/ui/pages/objetos/objetos_page.dart';
import 'package:reconocimiento_app/ui/pages/register/register_screen.dart';
import 'package:reconocimiento_app/ui/pages/tutores/tutores_page.dart';
import 'package:reconocimiento_app/ui/pages/usuarios/usuarios_page.dart';


// Punto de entrada de la aplicacion.|
void main() {
  runApp(const MyApp());
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
      home: AprendizScreen(),
      routes: {
        '/home': (context) => const MyHomePage(),
        '/registro': (context) => RegisterScreen(),
        '/vistaLogin': (context) => LoginScreen(),
        '/instructor': (context) => const InstructorApp(),
        '/aprendiz': (context) => const AprendizScreen(),
        '/admin': (context) => const AdminScreen(),
        '/fichas': (context) => const FichasPage(),
        '/objetos': (context) => const ObjetosPage(),
        '/ingresos': (context) => const IngresoPage(),
        '/usuarios': (context) => const UsuariosPage(),
        '/paginaUsuario': (context) => const UsuariosPage(),
        '/tutores': (context) => const TutoresPage(),
        '/reportesInstructor': (context) => ReportesInstructor(),
      },
    );
  }
}
