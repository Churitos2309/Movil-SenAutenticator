import 'package:flutter/material.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  _HistorialScreenState createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  // Lista simulada de objetos registrados
  final List<Map<String, dynamic>> objetos = [
    {
      'imagen': 'https://via.placeholder.com/150', // URL de una imagen de muestra
      'marca': 'Marca 1',
      'modelo': 'Modelo 1',
      'descripcion': 'Descripción del objeto 1',
    },
    {
      'imagen': 'https://via.placeholder.com/150',
      'marca': 'Marca 2',
      'modelo': 'Modelo 2',
      'descripcion': 'Descripción del objeto 2',
    },
    {
      'imagen': 'https://via.placeholder.com/150',
      'marca': 'Marca 3',
      'modelo': 'Modelo 3',
      'descripcion': 'Descripción del objeto 3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: objetos.length,
          itemBuilder: (context, index) {
            final objeto = objetos[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      objeto['imagen'],
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Marca: ${objeto['marca']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Modelo: ${objeto['modelo']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Descripción: ${objeto['descripcion']}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
