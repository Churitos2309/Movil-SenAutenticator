import 'package:flutter/material.dart';
import '../pages/aprendiz/Inicio/inicio_screen.dart';
import '../pages/aprendiz/Objetos/objetos_screen.dart';
import '../pages/aprendiz/Historial/historial_screen.dart';
import 'package:reconocimiento_app/ui/pages/login/login_screen.dart';

class AprendizScreen extends StatefulWidget {
  const AprendizScreen({super.key});

  @override
  _AprendizScreenState createState() => _AprendizScreenState();
}

class _AprendizScreenState extends State<AprendizScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Clave para manejar el Drawer

  static const List<String> _titles = <String>[
    'Inicio',
    'Objetos',
    'Historial', // Título para la nueva pantalla
  ];

  static final List<Widget> _pages = <Widget>[
    const InicioScreen(),
    const ObjetosScreen(),
    const HistorialScreen(), // Nueva pantalla
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asignamos la clave al Scaffold
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'images/login/LogoReconocimientoFacialBlanco.png', // Asegúrate de tener el logo en esta ruta
              height: 40, // Ajusta el tamaño del logo según sea necesario
            ),
            const SizedBox(width: 8), // Espacio entre el logo y el texto
            Text(_titles[_selectedIndex]),
          ],
        ),
        backgroundColor: const Color(0xFF39A900), // Verde del SENA
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF39A900), // Fondo del BottomNavigationBar
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.white, // Color del borde
            width: 2.0, // Ancho del borde
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
              16.0), // Bordes redondeados del BottomNavigationBar
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon:
                    Icon(Icons.category), // Cambia el icono según sea necesario
                label: 'Objetos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history), // Icono para Historial
                label: 'Historial',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white, // Color del ítem seleccionado
            unselectedItemColor:
                Colors.white54, // Color del ítem no seleccionado
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            backgroundColor:
                Colors.transparent, // Fondo transparente para aplicar borde
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
          horizontal: 16.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_pic.png'),
              radius: 16,
            ),
            const SizedBox(width: 8),
            const Text(
              'Angelina Jolie',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
