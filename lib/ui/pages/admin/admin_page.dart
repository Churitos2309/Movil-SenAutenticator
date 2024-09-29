import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/admin/components/bottom_navbar_admin.dart';
import 'package:reconocimiento_app/ui/pages/admin/components/custom_app_bar_admin.dart';
import 'package:reconocimiento_app/ui/router.dart';

class AdminPage extends StatefulWidget {
  final Widget body;
  final int currentIndex;

  const AdminPage({super.key, required this.body, required this.currentIndex});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

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
      appBar: CustomAppBarAdmin(title: 'Aprendiz'),
      body: widget.body,
      bottomNavigationBar: BottomNavbarAdmin(
        // currentIndex: widget.currentIndex,
        // onItemTapped: _onItemTapped,
      ),
    );
  }
}