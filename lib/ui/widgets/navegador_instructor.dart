// import 'package:flutter/material.dart';
// import '../pages/instructor/Inicio/inicio_screen.dart';
// import '../pages/instructor/Reportes/reportes_screen.dart';
// // import 'Inicio/inicio_screen.dart';
// // import 'Reportes/reportes_screen.dart';

// void main() {
//   runApp(const InstructorApp());
// }

// class InstructorApp extends StatelessWidget {
//   const InstructorApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Instructor',
//       theme: ThemeData(
//         primaryColor:
//             const Color(0xFF39a900), // Verde institucional SENA
//         appBarTheme: const AppBarTheme(
//           backgroundColor:
//               Color(0xFF39a900), // Verde institucional SENA
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(20.0), // Bordes inferiores del AppBar
//             ),
//           ),
//         ),
//         bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//           backgroundColor:
//               Colors.transparent, // Fondo transparente para aplicar borde
//           selectedItemColor: Colors.white, // Color del ítem seleccionado
//           unselectedItemColor: Colors.white54, // Color del ítem no seleccionado
//           showUnselectedLabels: true,
//           showSelectedLabels: true,
//           elevation: 0, // Eliminar sombra para no interferir con el borde
//           selectedLabelStyle: TextStyle(
//             fontWeight:
//                 FontWeight.bold, // Negrita para la etiqueta seleccionada
//           ),
//           unselectedLabelStyle: TextStyle(
//             fontWeight:
//                 FontWeight.normal, // Normal para la etiqueta no seleccionada
//           ),
//         ),
//       ),
//       home: const InstructorHome(),
//     );
//   }
// }

// class InstructorHome extends StatefulWidget {
//   const InstructorHome({super.key});

//   @override
//   _InstructorHomeState createState() => _InstructorHomeState();
// }

// class _InstructorHomeState extends State<InstructorHome> {
//   int _selectedIndex = 0;

//   static final List<Widget> _widgetOptions = <Widget>[
//     const InicioScreen(),
//     const ReportesScreen(),
//   ];

//   static const List<String> _titles = <String>[
//     'Inicio',
//     'Reportes',
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Image.asset(
//               'images/login/LogoReconocimientoFacialBlanco.png', // Asegúrate de tener el logo en esta ruta
//               height: 40, // Ajusta el tamaño del logo según sea necesario
//             ),
//             const SizedBox(width: 8), // Espacio entre el logo y el texto
//             Text(
//               _titles[_selectedIndex],
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: const Color(0xFF39a900), // Verde del SENA
//         toolbarHeight: 80,
//         elevation: 0,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(20), // Bordes inferiores del AppBar
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: 48,
//               height: 48,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//                 border: Border.all(
//                   color: Colors.grey.shade300,
//                   width: 2,
//                 ),
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.person,
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.symmetric(
//             horizontal: 16.0, vertical: 8.0), // Márgenes laterales y verticales
//         decoration: BoxDecoration(
//           color: const Color(0xFF39a900), // Fondo del BottomNavigationBar
//           borderRadius: BorderRadius.circular(
//               16.0), // Bordes redondeados en todos los lados
//           border: Border.all(
//             color: Colors.white, // Color del borde
//             width: 2.0, // Ancho del borde
//           ),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(
//               16.0), // Bordes redondeados del BottomNavigationBar
//           child: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Inicio',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.report),
//                 label: 'Reportes',
//               ),
//             ],
//             currentIndex: _selectedIndex,
//             onTap: _onItemTapped,
//             backgroundColor:
//                 Colors.transparent, // Fondo transparente para aplicar borde
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../pages/instructor/Inicio/inicio_screen.dart';
import '../pages/instructor/Reportes/reportes_screen.dart';
import '../pages/instructor/Graficas/graficas_screen.dart'; // Asegúrate de tener esta ruta correcta

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
        primaryColor:
            const Color(0xFF39a900), // Verde institucional SENA
        appBarTheme: const AppBarTheme(
          backgroundColor:
              Color(0xFF39a900), // Verde institucional SENA
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0), // Bordes inferiores del AppBar
            ),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor:
              Colors.transparent, // Fondo transparente para aplicar borde
          selectedItemColor: Colors.white, // Color del ítem seleccionado
          unselectedItemColor: Colors.white54, // Color del ítem no seleccionado
          showUnselectedLabels: true,
          showSelectedLabels: true,
          elevation: 0, // Eliminar sombra para no interferir con el borde
          selectedLabelStyle: TextStyle(
            fontWeight:
                FontWeight.bold, // Negrita para la etiqueta seleccionada
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight:
                FontWeight.normal, // Normal para la etiqueta no seleccionada
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'images/login/LogoReconocimientoFacialBlanco.png', // Asegúrate de tener el logo en esta ruta
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
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 8.0), // Márgenes laterales y verticales
        decoration: BoxDecoration(
          color: const Color(0xFF39a900), // Fondo del BottomNavigationBar
          borderRadius: BorderRadius.circular(
              16.0), // Bordes redondeados en todos los lados
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
                icon: Icon(Icons.report),
                label: 'Reportes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart), // Icono para Gráficas
                label: 'Gráficas', // Etiqueta para Gráficas
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor:
                Colors.transparent, // Fondo transparente para aplicar borde
          ),
        ),
      ),
    );
  }
}
