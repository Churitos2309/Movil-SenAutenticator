import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Hola',
          style: TextStyle(
            fontSize: 24, // Tamaño de fuente
            fontWeight: FontWeight.bold, // Negrita
            color: Colors.black, // Color del texto
          ),
        ),
      ),
    );
  }
}
