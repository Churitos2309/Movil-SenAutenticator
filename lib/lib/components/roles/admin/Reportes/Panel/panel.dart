import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class Panel extends StatefulWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  final ApiService apiService = ApiService();
  List<dynamic> usuarios = [];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchUsuarios();
  // }

  // void fetchUsuarios() async {
  //   try {
  //     final data = await apiService.get('usuario/');
  //     setState(() {
  //       usuarios = data;
  //     });
  //   } catch (e) {
  //     print('Error obteniendo usuarios: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0), // Espaciado interno alrededor del borde verde
        decoration: BoxDecoration(
          color: Colors.white, // Fondo blanco para evitar franjas
          border: Border.all(color: const Color(0xFF39A900), width: 2), // Borde verde SENA
          borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Centrando el texto
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Center(
                child: const Text(
                  'Aquí puedes ver los resultados obtenidos de los usuarios',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Contenedor para la tabla con desplazamiento vertical y horizontal
            Container(
              constraints: BoxConstraints(
                maxHeight: 200, // Altura suficiente para mostrar 4 filas
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 24.0, // Espacio entre columnas
                    headingTextStyle: TextStyle(
                      fontSize: 12, // Tamaño del texto en el encabezado
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    dataTextStyle: TextStyle(
                      fontSize: 10, // Tamaño del texto en las celdas
                    ),
                    columns: const <DataColumn>[
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text('Fecha')),
                      DataColumn(label: Text('Estado')),
                      DataColumn(label: Text('Documentos')),
                    ],
                    rows: _buildDataRows(), // Obtener las filas de datos
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir las filas de datos, mostrando todos los datos disponibles
  List<DataRow> _buildDataRows() {
    return usuarios.map<DataRow>((usuario) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(usuario['id'].toString())),
          DataCell(Text(usuario['first_name'] ?? '')),
          DataCell(Text(usuario['date_joined'] ?? '')),
          DataCell(Text(
            (usuario['is_staff'] && usuario['is_active'])
                ? 'Activo'
                : 'Inactivo',
          )),
          DataCell(Text(usuario['numero_documento_usuario'] ?? '')),
        ],
      );
    }).toList();
  }
}
