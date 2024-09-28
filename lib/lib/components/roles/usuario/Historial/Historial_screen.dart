import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  _HistorialScreenState createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  late Future<List<dynamic>> _objetos;

  // @override
  // void initState() {
  //   super.initState();
  //   _objetos = fetchObjetos();
  // }

  // Future<List<dynamic>> fetchObjetos() async {
  //   try {
  //     ApiService apiService = ApiService();
  //     print('Fetching objects...');
  //     final response = await apiService.get('objetos/'); // Cambia esta ruta según tu API
  //     if (response.isEmpty) {
  //       throw Exception("No hay objetos disponibles");
  //     }
  //     print('Objects fetched: ${response.length}');
  //     return response;
  //   } catch (e) {
  //     // Captura de errores y envío a la interfaz de usuario
  //     print('Error fetching objects: $e');
  //     throw Exception('Error al obtener los objetos: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Objetos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: _objetos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Mostrar el mensaje de error en la interfaz
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay objetos registrados.'));
            } else {
              final List<dynamic> objetos = snapshot.data!;
              return ListView.builder(
                itemCount: objetos.length,
                itemBuilder: (context, index) {
                  final objeto = objetos[index];

                  // Asegúrate de que este campo contenga la URL correcta
                  final imageUrl = objeto['foto_objeto'] ?? '';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Mostrar la imagen desde la URL de Firebase
                          imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      height: 100,
                                      width: 100,
                                      child: const Center(
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 50,
                                        ),
                                      ),
                                    );
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                  (loadingProgress.expectedTotalBytes ?? 1)
                                              : null,
                                        ),
                                      );
                                    }
                                  },
                                )
                              : Container(
                                  color: Colors.grey.shade200,
                                  height: 100,
                                  width: 100,
                                  child: const Center(
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                                  ),
                                ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Marca: ${objeto['marca_objeto'] ?? 'Desconocida'}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Modelo: ${objeto['modelo_objeto'] ?? 'Desconocido'}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Descripción: ${objeto['descripcion_objeto'] ?? 'No disponible'}',
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
              );
            }
          },
        ),
      ),
    );
  }
}
