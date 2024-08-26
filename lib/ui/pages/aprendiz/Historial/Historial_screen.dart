// lib/pages/aprendiz/Historial/historial_screen.dart

import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  _HistorialScreenState createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? historialData;
  bool isLoading = false;
  TextEditingController idController = TextEditingController();

  void fetchHistorial(String id) async {
    setState(() {
      isLoading = true;
      historialData = null; // Limpiamos cualquier dato anterior
    });

    try {
      final data = await apiService.get('objeto/$id'); // Solicitud GET con el ID
      setState(() {
        historialData = data;
      });
    } catch (e) {
      print('Error obteniendo historial: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: 'Ingrese el ID del Objeto',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (idController.text.isNotEmpty) {
                      fetchHistorial(idController.text);
                    }
                  },
                ),
              ),
              keyboardType: TextInputType.number, // Asegura que el teclado numérico se muestre
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : historialData != null
                    ? Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              title: const Text('Marca del Objeto'),
                              subtitle: Text(historialData!['marca_objeto'] ?? 'No disponible'),
                            ),
                            const SizedBox(height: 8),
                            ListTile(
                              title: const Text('Modelo del Objeto'),
                              subtitle: Text(historialData!['modelo_objeto'] ?? 'No disponible'),
                            ),
                            const SizedBox(height: 8),
                            ListTile(
                              title: const Text('Descripción del Objeto'),
                              subtitle: Text(historialData!['descripcion_objeto'] ?? 'No disponible'),
                            ),
                            const SizedBox(height: 8),
                            ListTile(
                              title: const Text('Usuario del Objeto'),
                              subtitle: Text(historialData!['usuario_objeto'] ?? 'No disponible'),
                            ),
                            const SizedBox(height: 8),
                            if (historialData!['foto_objeto'] != null)
                              Center(
                                child: Image.network(
                                  historialData!['foto_objeto'], // URL de la imagen desde la API
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else
                              const Text('Imagen no disponible'),
                          ],
                        ),
                      )
                    : const Text('Ingrese un ID para buscar el historial'),
          ],
        ),
      ),
    );
  }
}
