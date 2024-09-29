import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/aprendiz_page.dart';

class HomeAprendiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AprendizPage(
      body: Center(
        child: Text('Esta es la página de inicio'),
      ),
      currentIndex: 0,
    );
  }
}