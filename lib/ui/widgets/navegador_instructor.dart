import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/login/login_screen.dart';
import '../pages/instructor/Inicio/inicio_screen.dart';
import '../pages/instructor/Reportes/reportes_screen.dart';
import '../pages/instructor/Reportes/Fichas_Instructor/Usuarios_aprendiz/Graficas/graficas_screen.dart';

void main() {
  runApp(const InstructorApp());
}

class InstructorApp extends StatelessWidget {
  const InstructorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instructor',
      theme: ThemeData(
        primaryColor: const Color(0xFF39a900), // Verde institucional SENA
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF39a900), // Verde institucional SENA
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0), // Bordes inferiores del AppBar
            ),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          elevation: 0,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold, // Negrita para la etiqueta seleccionada
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal, // Normal para la etiqueta no seleccionada
          ),
        ),
      ),
      home: const InstructorHome(),
    );
  }
}

class InstructorHome extends StatefulWidget {
  const InstructorHome({super.key});

  @override
  _InstructorHomeState createState() => _InstructorHomeState();
}

class _InstructorHomeState extends State<InstructorHome> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final List<Widget> _widgetOptions = <Widget>[
    const InicioScreen(),
    const ReportesScreen(),
    const GraficasInstructorScreen(), // Nueva opción para Gráficas
  ];

  static const List<String> _titles = <String>[
    'Inicio',
    'Reportes',
    'Gráficas', // Nuevo título para Gráficas
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout(BuildContext context) {
    // Navegar a la pantalla de inicio de sesión
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'images/login/LogoReconocimientoFacialBlanco.png',
              height: 40, // Ajusta el tamaño del logo según sea necesario
            ),
            const SizedBox(width: 8), // Espacio entre el logo y el texto
            Text(
              _titles[_selectedIndex],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF39a900), // Verde del SENA
        toolbarHeight: 80,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Bordes inferiores del AppBar
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProfileCard(), // Aquí integramos el ProfileCard
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF39a900), // Fondo del BottomNavigationBar
          borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
          border: Border.all(
            color: Colors.white, // Color del borde
            width: 2.0, // Ancho del borde
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.report),
                label: 'Reportes',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.show_chart), // Icono para Gráficas
              //   label: 'Gráficas', // Etiqueta para Gráficas
              // ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

// Clase ProfileCard adaptada
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'Cerrar sesión') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Perfil',
          child: Text('Perfil'),
        ),
        const PopupMenuItem<String>(
          value: 'Cerrar sesión',
          child: Text('Cerrar sesión'),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0, // Reduzco el padding horizontal
          vertical: 6.0,  // Reduzco el padding vertical
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0), // Bordes redondeados más pequeños
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_pic.png'),
              radius: 14, // Reducir el radio de la imagen de perfil
            ),
            const SizedBox(width: 6), // Espacio reducido entre la imagen y el texto
            const Text(
              'Angelina Jolie',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12, // Reducir el tamaño de la fuente
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 16, // Reducir el tamaño del ícono
            ),
          ],
        ),
      ),
    );
  }
}
