import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class RegistroFacialPage extends StatefulWidget {
  const RegistroFacialPage({super.key});

  @override
  State<RegistroFacialPage> createState() => RegistroFacialPageState();
}

class RegistroFacialPageState extends State<RegistroFacialPage> {

  final ApiService apiService = ApiService();
  List<dynamic> registroFacial = [];

  @override
  void initState() {
    super.initState();
    fetchRegistroFacial();
  }

  void fetchRegistroFacial() async{
    try {
      final data = await apiService.get('registroFacial/');
      setState(() {
        registroFacial = data;
      });
    } catch (e) {
      print('Error Obteniendo Registro Facial: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Facial'),
      ),
      body: ListView.builder(itemCount: registroFacial.length , itemBuilder: (context, index) {
        return ListTile(
          title: Text(registroFacial[index]['Nombre_Usuario']),
        );
      }),
    );
  }
}