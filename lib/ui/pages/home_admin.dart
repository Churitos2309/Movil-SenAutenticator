import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/admin/admin_page.dart';
class HomeAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdminPage(
      body: Center(
        child: Text('Esta es la página de inicio'),
      ),
      currentIndex: 0,
    );
  }
}