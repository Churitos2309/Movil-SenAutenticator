import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class ObjetosAprendizPage extends StatefulWidget {
  @override
  _ObjetosAprendizPageState createState() => _ObjetosAprendizPageState();
}

class _ObjetosAprendizPageState extends State<ObjetosAprendizPage> {
  late Future<List<dynamic>> _objetosFuture;

  @override
  void initState() {
    super.initState();
    _objetosFuture = Provider.of<ApiService>(context, listen: false).getObjetos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Objetos Page'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _objetosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No objects found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final objeto = snapshot.data![index];
                return ListTile(
                  leading: objeto['foto_objeto'] != null
                      ? Image.network(objeto['foto_objeto'])
                      : Icon(Icons.image_not_supported),
                  title: Text('${objeto['marca_objeto']} ${objeto['modelo_objeto']}'),
                  subtitle: Text(objeto['descripcion_objeto']),
                );
              },
            );
          }
        },
      ),
    );
  }
}