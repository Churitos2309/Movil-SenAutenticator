import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final ApiService apiService = ApiService();
  List<dynamic> usuarios = [];

  @override
  void initState() {
    super.initState();
    fetchUsuarios();
  }

  void fetchUsuarios() async {
    try {
      final data = await apiService.get('usuario/');
      setState(() {
        usuarios = data;
      });
    } catch (e) {
      print('Error Obteniendo Usuarios: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final usuario = usuarios[index];
          final nombreUsuario =
              usuario['numero_documento_usuario'] ?? ' Nombre no disponible';
          return ListTile(
            // title: Text(usuarios[index]['Nombre_Usuario']),
            title: Text(nombreUsuario),
          );
        },
      ),
    );
  }
}
