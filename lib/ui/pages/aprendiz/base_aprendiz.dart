// // import 'package:flutter/material.dart';
// // import 'package:reconocimiento_app/ui/pages/aprendiz/components/bottom_navbar_aprendiz.dart';
// // import 'package:reconocimiento_app/ui/pages/aprendiz/components/custom_app_bar_aprendiz.dart';
// // import 'package:reconocimiento_app/ui/router.dart';

// // class BaseScreen extends StatefulWidget {
// //   final Widget body;
// //   final int currentIndex;

// //   BaseScreen({required this.body, required this.currentIndex});

// //   @override
// //   _BaseScreenState createState() => _BaseScreenState();
// // }

// // class _BaseScreenState extends State<BaseScreen> {
// //   int _currentIndex = 0;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _currentIndex = widget.currentIndex;
// //   }

// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _currentIndex = index;
// //     });

// //     switch (index) {
// //       case 0:
// //         Navigator.pushReplacementNamed(context, Routes.homeAprendiz);
// //         break;
// //       case 1:
// //         Navigator.pushReplacementNamed(context, Routes.objetos);
// //         break;
// //       case 2:
// //         Navigator.pushReplacementNamed(context, Routes.historial);
// //         break;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: CustomAppBarAprendiz(title: 'Aprendiz'),
// //       body: widget.body,
// //       bottomNavigationBar: BottomNavbarAprendiz(
// //         // currentIndex: _currentIndex,
// //         // onItemTapped: _onItemTapped,
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:reconocimiento_app/ui/pages/aprendiz/historial_page_aprendiz.dart';
// import 'package:reconocimiento_app/ui/pages/home_page.dart';
// import 'package:reconocimiento_app/ui/pages/objetos_page.dart';


// class BaseScreen extends StatefulWidget {
//   final int currentIndex;

//   BaseScreen({required this.currentIndex});

//   @override
//   _BaseScreenState createState() => _BaseScreenState();
// }

// class _BaseScreenState extends State<BaseScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _screens = [
//     HomePage(),
//     ObjetosPage(),
//     HistorialPage(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.currentIndex;
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('App Title'),
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined, size: 30),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.build_outlined, size: 30),
//             label: 'Build',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.info_outline, size: 30),
//             label: 'Info',
//           ),
//         ],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class BaseAprendiz extends StatefulWidget {
  @override
  _BaseAprendizState createState() => _BaseAprendizState();
}

class _BaseAprendizState extends State<BaseAprendiz> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Widget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Counter: $counter'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}