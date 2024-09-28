import 'package:animate_gradient/animate_gradient.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/services/scroll_provider.dart';

class BottomNavBarAprendiz extends StatefulWidget {
  const BottomNavBarAprendiz({super.key});

  @override
  State<BottomNavBarAprendiz> createState() => _BottomNavBarAprendizState();
}

class _BottomNavBarAprendizState extends State<BottomNavBarAprendiz> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Escucha los cambios en el scroll
  }

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context);

    return AnimateGradient(
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
          Icon(Icons.category,
              size: 30, color: Color(0xFF27A900)), // Verde
          Icon(Icons.history, size: 30, color: Color(0xFF27A900)), // Verde
        ],
        color: const Color.fromARGB(164, 224, 224, 224), // Fondo gris claro
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white70,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {},
      ),
    );
  }
}
