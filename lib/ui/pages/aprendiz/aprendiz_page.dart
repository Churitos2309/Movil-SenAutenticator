import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/components/bottom_navbar_aprendiz.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/components/custom_app_bar_aprendiz.dart';
import 'package:reconocimiento_app/ui/router.dart';

class AprendizPage extends StatefulWidget {
  final Widget body;
  final int currentIndex;

  const AprendizPage({super.key, required this.body, required this.currentIndex});

  @override
  _AprendizPageState createState() => _AprendizPageState();
}

class _AprendizPageState extends State<AprendizPage> {

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, Routes.homeAprendiz);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, Routes.objetos);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, Routes.historial);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarAprendiz(title: 'Aprendiz'),
      body: widget.body,
      bottomNavigationBar: BottomNavbarAprendiz(
        // currentIndex: widget.currentIndex,
        // onItemTapped: _onItemTapped,
      ),
    );
  }
}