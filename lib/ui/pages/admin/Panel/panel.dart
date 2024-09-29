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

  @override
  void initState() {
    super.initState();
    fetchUsuarios();
  }

  void fetchUsuarios() async {
    try {
      final data = await apiService.get('usuarios/');
      setState(() {
        usuarios = data;
      });
    } catch (e) {
      print('Error obteniendo usuarios: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0), // Espaciado interno
        decoration: BoxDecoration(
          color: Colors.white, // Fondo blanco limpio
          borderRadius: BorderRadius.circular(15.0), // Bordes más redondeados
          boxShadow: [
            BoxShadow(
              color: Colors.black12, // Sombra suave
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Texto con estilo iOS
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Resultados de usuarios',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Contenedor para la tabla estilizada
            Container(
              constraints: BoxConstraints(
                maxHeight: 250, // Altura adecuada para la tabla
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 28.0, // Espaciado entre columnas más amplio
                    headingTextStyle: TextStyle(
                      fontSize: 14, // Tamaño de texto más grande
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                    dataTextStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500, // Texto más claro
                      color: Colors.black87, // Color oscuro sutil
                    ),
                    columns: const <DataColumn>[
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text('Fecha')),
                      DataColumn(label: Text('Estado')),
                      DataColumn(label: Text('Documentos')),
                    ],
                    rows: _buildDataRows(), // Construir las filas de datos
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0), // Redondeo de bordes
                      color: Colors.grey.shade50, // Fondo suave para la tabla
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir las filas de datos
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
        // Estilo para las filas
        color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue.shade50; // Color cuando se selecciona una fila
          }
          return null;  // Usar el color por defecto
        }),
      );
    }).toList();
  }
}
