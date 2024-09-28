import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'Inicio/inicio_screen.dart';
import 'Historial/Historial_screen.dart';
import 'Objetos/objetos_screen.dart';

class NavigationAprendiz extends StatefulWidget {
  const NavigationAprendiz({Key? key}) : super(key: key);

  @override
  _NavigationAprendizState createState() => _NavigationAprendizState();
}

class _NavigationAprendizState extends State<NavigationAprendiz> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final PageController _pageController = PageController(initialPage: 0);

  // Aquí están las páginas que se mostrarán en el PageView
  List<Widget> pages = [
    InicioScreen(), // Página de Inicio
    ObjetosScreen(), // Página de Reportes
    HistorialScreen (),// Página de Historial
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Cuerpo de la app donde se mostrarán las páginas
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _page = index;
          });
        },
        children: pages,
      ),

      // Barra de navegación personalizada
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page, // Sincronización de la página actual
        height: 60.0, // Altura del Bottom Navigation Bar
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white), // Inicio
          Icon(Icons.report, size: 30, color: Colors.white), // Reportes
          Icon(Icons.bar_chart, size: 30, color: Colors.white), // Gráficas
        ],
        color: Colors.blueAccent, // Color del fondo de los íconos
        buttonBackgroundColor:
            Colors.greenAccent, // Fondo del ícono seleccionado
        backgroundColor:
            Colors.lightBlueAccent, // Fondo del BottomNavigationBar
        animationCurve: Curves.easeInOut, // Curva de animación
        animationDuration:
            const Duration(milliseconds: 600), // Duración de la animación
        onTap: (index) {
          setState(() {
            _page =
                index; // Actualiza el estado con la nueva página seleccionada
          });
          _pageController
              .jumpToPage(index); // Navega a la página correspondiente
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
