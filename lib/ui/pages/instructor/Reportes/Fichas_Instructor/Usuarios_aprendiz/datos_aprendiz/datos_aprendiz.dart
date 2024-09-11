import 'package:flutter/material.dart';

class DatosAprendiz extends StatelessWidget {
  final Map<String, dynamic> usuario;

  const DatosAprendiz({required this.usuario, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Detalles del Aprendiz',
            style: TextStyle(
              fontSize: 20, // Tamaño de fuente personalizado
              fontWeight: FontWeight.bold, // Negrita
              color: Colors.black, // Color del texto
            ),
          ),
          const SizedBox(height: 16.0),
          Text('Nombre: ${usuario['first_name']} ${usuario['last_name']}'),
          Text('Correo: ${usuario['email'] ?? 'N/A'}'),
          Text('Rol: ${usuario['rol_usuario'] ?? 'N/A'}'),
          // Agrega más detalles aquí si es necesario
        ],
      ),
    );
  }
}
