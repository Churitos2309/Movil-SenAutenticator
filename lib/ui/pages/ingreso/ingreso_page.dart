import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class IngresoPage extends StatefulWidget {
  const IngresoPage({super.key});

  @override
  State<IngresoPage> createState() => _IngresoPageState();
}

class _IngresoPageState extends State<IngresoPage> {
  final ApiService apiService = ApiService();
  List<dynamic> ingreso = [];

  @override
  void initState() {
    super.initState();
    fetchIngreso();
  }

  void fetchIngreso() async {
    try {
      final data = await apiService.getList('ingresos/');
      setState(() {
        ingreso = data;
      });
    } catch (e) {
      print('Error Obteniendo Ingreso: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingreso'),
      ),
      body: ListView.builder(
        itemCount: ingreso.length,
        itemBuilder: (context, index) {
          final ingresoid = ingreso[index];
          final nombreIngreso = ingresoid['Nombre_Ingreso'] ?? ' Nombre no disponible';

          return ListTile(
            title: Text(nombreIngreso),
          );
        },
      ),
    );
  }
}
