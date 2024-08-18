import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class ProgramaPage extends StatefulWidget {
  const ProgramaPage({super.key});

  @override
  State<ProgramaPage> createState() => _ProgramaPageState();
}

class _ProgramaPageState extends State<ProgramaPage> {
  final ApiService apiService = ApiService();
  List<dynamic> programas = [];

  @override
  void initState() {
    super.initState();
    fetchProgramas();
  }

  void fetchProgramas() async {
    try {
      final data = await apiService.get('programa/');
      setState(() {
        programas = data;
      });
    } catch (e) {
      print('Error Obteniendo Programas: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programa'),
      ),
      body: ListView.builder(
        itemCount: programas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(programas[index]['nombre_programa']),
          );
        },
      ),
    );
  }
}
