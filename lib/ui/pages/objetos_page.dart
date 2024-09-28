
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/providers/objetos_provider.dart';

class ObjetosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ObjetosProvider>(context);

    // Llamar a la API al iniciar la página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchObjetos();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Objetos'),
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.objetos.length,
              itemBuilder: (context, index) {
                final objeto = provider.objetos[index];
                return ListTile(
                  title: Text(objeto['nombre'] ?? 'Nombre no disponible'),
                  subtitle: Text(objeto['descripcion'] ?? 'Descripción no disponible'),
                  leading: objeto['foto_objeto'] != null
                      ? Image.network(objeto['foto_objeto'])
                      : Icon(Icons.image_not_supported),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la página de creación de objetos
        },
        child: Icon(Icons.add),
      ),
    );
  }
}