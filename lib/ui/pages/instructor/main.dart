// import 'package:flutter/material.dart';
// import 'Inicio/inicio_screen.dart';
// import 'Reportes/reportes_screen.dart';

// class InstructorHome extends StatefulWidget {
//   @override
//   _InstructorHomeState createState() => _InstructorHomeState();
// }

// class _InstructorHomeState extends State<InstructorHome> {
//   int _selectedIndex = 0;

//   static final List<Widget> _widgetOptions = <Widget>[
//     InicioScreen(),
//     ReportesScreen(),
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
//         title: const Text('Instructor'),
//         backgroundColor: Color(0xFF008000), // Verde institucional del SENA
//       ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Inicio',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.report),
//             label: 'Reportes',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Color(0xFF008000),
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'Inicio/inicio_screen.dart';
import 'Reportes/reportes_screen.dart';

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
        primaryColor: const Color.fromARGB(255, 5, 223, 5), // Verde institucional SENA
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
    ReportesScreen(),
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
        title: const Text('Instructor'),
        backgroundColor: const Color.fromARGB(255, 5, 223, 5), // Verde institucional SENA
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Reportes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF00A859), // Verde institucional SENA
        onTap: _onItemTapped,
      ),
    );
  }
}

