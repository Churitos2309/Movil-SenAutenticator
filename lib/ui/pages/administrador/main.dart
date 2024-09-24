import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/administrador/widgets/bottom_nav_bar_admin.dart';


class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reconocimiento App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavBarAdmin(),
    );
  }
}