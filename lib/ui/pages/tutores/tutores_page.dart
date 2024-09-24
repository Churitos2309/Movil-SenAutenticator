import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class TutoresPage extends StatefulWidget {
  const TutoresPage({super.key});

  @override
  State<TutoresPage> createState() => _TutoresPageState();
}

class _TutoresPageState extends State<TutoresPage> {
  final ApiService apiService = ApiService();
  List<dynamic> tutores = [];

  @override
  void initState() {
    super.initState();
    fetchTutores();
  }

  void fetchTutores() async {
    try {
      final date = await apiService.getList('tutor/');
      setState(() {
        tutores = date;
      });
    } catch (e) {
      print('Error Obteniendo Tutores: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutores'),
      ),
      body: ListView.builder(
        itemCount: tutores.length,
        itemBuilder: (context, index) {
          final tutor = tutores[index];
          final nombreTutor = tutor['Nombre_Tutor'] ?? 'Nombre no disponible';

          return ListTile(
            title: Text(nombreTutor),
          );
        },
      ),
    );
  }
}
