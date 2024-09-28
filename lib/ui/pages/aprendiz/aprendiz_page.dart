import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/components/bottom_navbar_aprendiz.dart';
import 'package:reconocimiento_app/ui/pages/aprendiz/components/custom_app_bar_aprendiz.dart';
import 'package:reconocimiento_app/ui/pages/home_body.dart';

class AprendizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarAprendiz(title: 'Aprendiz'),
      body: const HomeBody(),
      bottomNavigationBar: const BottomNavBarAprendiz(),
    );
  }
}