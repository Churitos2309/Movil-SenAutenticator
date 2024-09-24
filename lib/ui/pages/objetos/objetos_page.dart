import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class ObjetosPage extends StatefulWidget {
  const ObjetosPage({super.key});

  @override
  State<ObjetosPage> createState() => _ObjetosPageState();
}

class _ObjetosPageState extends State<ObjetosPage> {
  final ApiService apiService = ApiService();
  List<dynamic> objetos = [];

  @override
  void initState() {
    super.initState();
    fetchObjectos();
  }

  void fetchObjectos() async {
    try {
      final data = await apiService.getList('objeto/');
      setState(() {
        objetos = data;
      });
    } catch (e) {
      print('Error Obteniendo Objetos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Objetos'),
      ),
      body: objetos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: objetos.length,
              itemBuilder: (context, index) {
                final objeto = objetos[index];
                final nombreObjeto =
                    objeto['marca_objeto'] ?? ' Nombre no disponible';
                return ListTile(
                  // title: Text(objetos[index]['Nombre_Objeto'],),
                  title: Text(nombreObjeto),
                );
              },
            ),
    );
  }
}
