// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';

// class ButtonNewNavigation extends StatefulWidget {
//   @override
//   _ButtonNewNavigationState createState() => _ButtonNewNavigationState();
// }

// class _ButtonNewNavigationState extends State<ButtonNewNavigation>
//     with SingleTickerProviderStateMixin {
//   int _bottomNavIndex = 0;
//   final NotchBottomBarController _notchBottomBarController =
//       NotchBottomBarController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Navigation Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/vistaLogin');
//               },
//               child: const Text('Login'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/instructor');
//               },
//               child: const Text('Instructor'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/admin');
//               },
//               child: const Text('Admin'),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: AnimatedNotchBottomBar(
//         notchBottomBarController: _notchBottomBarController,
//         notchGradient: const LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             Colors.red,
//             Colors.blue,
//           ],
//         ),
//         showBottomRadius: false,
//         bottomBarItems: [
//           BottomBarItem(
//             inActiveItem: AnimatedSwitcher(
//               duration: const Duration(milliseconds: 1000),
//               transitionBuilder: (Widget child, Animation<double> animation) {
//                 return FadeTransition(opacity: animation, child: child);
//               },
//               child: _bottomNavIndex == 0
//                   ? const Icon(
//                       Icons.home_filled,
//                       color: Colors.green,
//                       key: ValueKey<int>(0),
//                     )
//                   : const Icon(
//                       Icons.home_filled,
//                       color: Colors.blueGrey,
//                       key: ValueKey<int>(1),
//                     ),
//             ),
//             activeItem: const Icon(
//               Icons.home,
//               color: Colors.green,
//             ),
//             itemLabel: 'Home',
//           ),
//           BottomBarItem(
//             inActiveItem: AnimatedSwitcher(
//               duration: const Duration(milliseconds: 1000),
//               transitionBuilder: (Widget child, Animation<double> animation) {
//                 return FadeTransition(opacity: animation, child: child);
//               },
//               child: _bottomNavIndex == 1
//                   ? const Icon(
//                       Icons.home_filled,
//                       color: Colors.green,
//                       key: ValueKey<int>(1),
//                     )
//                   : const Icon(
//                       Icons.home_filled,
//                       color: Colors.blueGrey,
//                       key: ValueKey<int>(1),
//                     ),
//             ),
//             activeItem: const Icon(
//               Icons.home,
//               color: Colors.green,
//             ),
//             itemLabel: 'Home',
//           ),
//           BottomBarItem(
//             inActiveItem: AnimatedSwitcher(
//               duration: const Duration(milliseconds: 1000),
//               transitionBuilder: (Widget child, Animation<double> animation) {
//                 return FadeTransition(opacity: animation, child: child);
//               },
//               child: _bottomNavIndex == 2
//                   ? const Icon(
//                       Icons.home_filled,
//                       color: Colors.green,
//                       key: ValueKey<int>(2),
//                     )
//                   : const Icon(
//                       Icons.home_filled,
//                       color: Colors.blueGrey,
//                       key: ValueKey<int>(2),
//                     ),
//             ),
//             activeItem: const Icon(
//               Icons.home,
//               color: Colors.green,
//             ),
//             itemLabel: 'Home',
//           ),
//           // Agrega más BottomBarItem según sea necesario
//         ],
//         onTap: (index) {
//           setState(() {
//             _bottomNavIndex = index;
//           });
//         },
//         kIconSize: 20,
//         kBottomRadius: 50,
//       ),
//     );
//   }
// }

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/home/home_screen.dart';
import 'package:reconocimiento_app/ui/pages/profile/profile_page.dart';
import 'package:reconocimiento_app/ui/pages/usuarios/usuarios_page.dart';

class ButtonNewNavigation extends StatefulWidget {
  const ButtonNewNavigation({super.key});

  @override
  _ButtonNewNavigationState createState() => _ButtonNewNavigationState();
}

class _ButtonNewNavigationState extends State<ButtonNewNavigation>
    with SingleTickerProviderStateMixin {
      
  int _bottomNavIndex = 0;

  final NotchBottomBarController _notchBottomBarController =
      NotchBottomBarController();

  final List<Widget> _pages = [
    const HomeScreen(),
    const UsuariosPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: PageController(initialPage: _bottomNavIndex),
        onPageChanged: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _notchBottomBarController,
        // notchGradient: const LinearGradient(
          // begin: Alignment.topRight,
          // end: Alignment.bottomLeft,
          // colors: [
          //   Color(0x39A900), // Color principal en el degradado
          //   Color(0xFF39A900)
          // ],
        // ),
        showBottomRadius: true, // Mostrar el radio inferior
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _bottomNavIndex == 0
                  ? const Icon(
                      Icons.home_outlined,
                      color: Color(0xFF39A900), // Color activo para el ícono
                      key: ValueKey<int>(0),
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Colors.blueGrey,
                      key: ValueKey<int>(1),
                    ),
            ),
            activeItem: const Icon(
              Icons.home_rounded,
              color: Color(0xFF39A900), // Color activo
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _bottomNavIndex == 1
                  ? const Icon(
                      Icons.camera_alt_outlined,
                      color: Color(0xFF39A900), // Color activo para el ícono
                      key: ValueKey<int>(0),
                    )
                  : const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.blueGrey,
                      key: ValueKey<int>(1),
                    ),
            ),
            activeItem: const Icon(
              Icons.camera_alt_rounded,
              color: Color(0xFF39A900), // Color activo
            ),
            itemLabel: 'Facial',
          ),
          BottomBarItem(
            inActiveItem: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _bottomNavIndex == 2
                  ? const Icon(
                      Icons.person_outlined,
                      color: Color(0xFF39A900), // Color activo para el ícono
                      key: ValueKey<int>(0),
                    )
                  : const Icon(
                      Icons.person_outlined,
                      color: Colors.blueGrey,
                      key: ValueKey<int>(1),
                    ),
            ),
            activeItem: const Icon(
              Icons.person_rounded, 
              color: Color(0xFF39A900), // Color activo
            ),
            itemLabel: 'Perfil',
          ),
          // Agrega más BottomBarItem según sea necesario
        ],
        onTap: _onItemTapped,
        kIconSize: 20,
        kBottomRadius: 50, // Ajustar el radio inferior
      ),
    );
  }
}
