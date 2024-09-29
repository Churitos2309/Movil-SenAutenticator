import 'package:animate_gradient/animate_gradient.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/services/scroll_provider.dart';
import 'package:reconocimiento_app/ui/pages/instructor/components/custom_app_bar_instructor.dart';
import 'package:reconocimiento_app/ui/pages/instructor/historial_page_instructor.dart';
import 'package:reconocimiento_app/ui/pages/instructor/home_instructor.dart';
import 'package:reconocimiento_app/ui/pages/instructor/objetos_intructor_page.dart';

class BottomNavbarInstructor extends StatefulWidget {
  @override
  _BottomNavbarInstructorState createState() => _BottomNavbarInstructorState();
}

class _BottomNavbarInstructorState extends State<BottomNavbarInstructor>{
  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _screens = [
    HomeScreenInstructor(),
    ObjetosInstructorPage(),
    HistorialPageInstructor(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context);

    return Scaffold(
      appBar: CustomAppBarInstructor(title: 'Instructor'),
      // AppBar(
      //   title: Text('App Title'),
      // ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: AnimateGradient(
        primaryBeginGeometry: const AlignmentDirectional(0, 1),
        primaryEndGeometry: const AlignmentDirectional(0, 2),
        secondaryBeginGeometry: const AlignmentDirectional(2, 0),
        secondaryEndGeometry: const AlignmentDirectional(0, -0.8),
        primaryColors: scrollProvider.primaryColors,
        secondaryColors: scrollProvider.secondaryColors,
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _currentIndex,
          items: const <Widget>[
            Icon(Icons.home_outlined,
                size: 30, color: Color(0xFF27A900)), // Verde
            Icon(Icons.build_outlined,
                size: 30, color: Color(0xFF27A900)), // Verde
            Icon(Icons.info_outline,
                size: 30, color: Color(0xFF27A900)), // Verde
          ],
          color: const Color.fromARGB(164, 224, 224, 224), // Fondo gris claro
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.white70,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
