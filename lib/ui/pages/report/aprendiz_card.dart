import 'package:flutter/material.dart';

class AprendizCard extends StatelessWidget {
  final Map<String, dynamic> aprendiz;

  const AprendizCard({super.key, required this.aprendiz});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(aprendiz['nombre']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${aprendiz['id']}'),
                Text('Documento: ${aprendiz['documento']}'),
                Text('Estado: ${aprendiz['estado']? 'Aprobado' : 'Pendiente'}'),
                Text('Hora: ${aprendiz['hora']}'),
              ],
            ),
            trailing: Icon(aprendiz['estado']? Icons.check_circle : Icons.warning),
          ),
        ],
      ),
    );
  }
}