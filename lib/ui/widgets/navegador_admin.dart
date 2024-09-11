import 'package:flutter/material.dart';
import '../pages/administrador/Graficas/Graficas_screen.dart';
import '../pages/administrador/Inicio/inicio_screen.dart';
import '../pages/administrador/Reportes/reportes_screen.dart';
import 'package:reconocimiento_app/ui/pages/login/login_screen.dart'; // Asegúrate de que la ruta sea correcta

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<String> _titles = <String>[
    'Inicio',
    'Reportes',
    'Gráficas',
  ];

  static final List<Widget> _pages = <Widget>[
    const InicioScreen(),
    const ReportesScreen(),
    const GraficasScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
              height: 40,
            ),
            const SizedBox(width: 8),
            Text(
              _titles[_selectedIndex],
              style: const TextStyle(
                fontSize: 18, // Reduce el tamaño de la fuente
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF39A900),
        toolbarHeight: 70, // Reduce la altura del AppBar
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ProfileCard(), // Aquí integramos el ProfileCard como en el primer código
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF39A900),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
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
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart),
                label: 'Gráficas',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white54,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
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
          horizontal: 10.0, // Reduce el padding horizontal
          vertical: 6.0, // Reduce el padding vertical
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0), // Reduce el tamaño del borde
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_pic.png'),
              radius: 14, // Reduce el tamaño del avatar
            ),
            const SizedBox(width: 6),
            const Text(
              'Angelina Jolie', // Cambia este nombre si es necesario
              style: TextStyle(
                color: Colors.black,
                fontSize: 14, // Reduce el tamaño de la fuente
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 18), // Reduce el tamaño del ícono
          ],
        ),
      ),
    );
  }
}
