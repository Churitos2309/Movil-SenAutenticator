import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final ApiService apiService = ApiService();
  List usuarios = [];

  @override
  void initState() {
    super.initState();
    fetchUsuarios();
  }

  void fetchUsuarios() async {
    try {
      final data = await apiService.getList('usuario/');
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
      body: usuarios.isEmpty
          ? const CardLoading(
              height: 100,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              margin: EdgeInsets.all(100),
            )
          : ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final usuario = usuarios[index];
                final nombreUsuario =
                    usuario['username'] ?? ' Nombre no disponible';
                return ListTile(
                  // title: Text(usuarios[index]['Nombre_Usuario']),
                  title: Text(nombreUsuario),
                );
              },
            ),
    );
  }
}
