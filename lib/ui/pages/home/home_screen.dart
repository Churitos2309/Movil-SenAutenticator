import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/widgets/button_new_navigation.dart';
import 'package:reconocimiento_app/ui/widgets/role_button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.person, // Icono que representa el rol
              size: 100.0,
              color: Colors.green[900],
            ),
            const SizedBox(height: 20.0),
            Text(
              'Welcome, User', // Mensaje de bienvenida
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            const SizedBox(height: 40.0),
            RoleButton(
              label: 'Start',
              onPressed: () {
                // Acción que realiza el botón
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ButtonNewNavigation(),
    );
  }
}
