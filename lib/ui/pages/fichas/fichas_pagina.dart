import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class FichasPage extends StatefulWidget {
  const FichasPage({super.key});

  @override
  State<FichasPage> createState() => _FichasPageState();
}

class _FichasPageState extends State<FichasPage> {
  final ApiService apiService = ApiService();
  List<dynamic> fichas = [];

  @override
  void initState() {
    super.initState();
    fetchFichas();
  }

  void fetchFichas() async {
    try {
      final data = await apiService.get('ficha/');
      setState(() {
        fichas = data;
      });
    } catch (e) {
      print('Error Obteniendo Fichas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fichas'),
      ),
      body:
          ListView.builder(itemCount: fichas.length, itemBuilder: (context, index) {
            return ListTile(
              title: Text(fichas[index]['Nombre_Ficha']),
            );
          } ,),
    );
  }
}
