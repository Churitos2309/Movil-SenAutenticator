// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'ApiReportes/api_service.dart';

class ReportesScreen extends StatefulWidget {
  const ReportesScreen({super.key});

  @override
  _ReportesScreenState createState() => _ReportesScreenState();
}

class _ReportesScreenState extends State<ReportesScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> usuarios = [];
  String ficha = '';
  String documento = '';
  String tiempo = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchUsuarios() async {
    try {
      final data = await apiService.fetchUsuarios(ficha, documento, tiempo);
      setState(() {
        usuarios = data;
      });
    } catch (e) {
      // Manejo de errores
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Reportes Instructor'),
      //   backgroundColor: Colors.green[800],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Inputs encima de la tabla
            Row(
              children: [
                Expanded(
                  child: _buildFilterInput('Fichas', (value) {
                    setState(() {
                      ficha = value;
                    });
                    _fetchUsuarios();
                  }),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildFilterInput('Documentos', (value) {
                    setState(() {
                      documento = value;
                    });
                    _fetchUsuarios();
                  }),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildFilterInput('Tiempo', (value) {
                    setState(() {
                      tiempo = value;
                    });
                    _fetchUsuarios();
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tabla de reportes
            Expanded(
              child: usuarios.isEmpty
                  ? Center(child: Text('No hay datos disponibles', style: TextStyle(fontSize: 16, color: Colors.grey[600])))
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // Desplazamiento horizontal
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical, // Desplazamiento vertical
                          child: DataTable(
                            columnSpacing: 16.0, // Espaciado entre columnas
                            dataRowMaxHeight: 50.0, // Altura de las filas
                            // dataRowMinHeight: 50.0, // Altura de las filas
                            headingRowHeight: 50.0, // Altura de las cabeceras
                            headingRowColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.green[700]!),
                            dataRowColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.white),
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'ID',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nombre',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Fecha',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Estado',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Documentos',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                            rows: usuarios.where((usuario) {
                              final numeroDocumento =
                                  usuario['numero_documento_usuario']
                                      ?.toString() ??
                                      '';
                              return numeroDocumento.startsWith(documento);
                            }).map<DataRow>((usuario) {
                              return DataRow(
                                color: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    // Alterna el color de las filas
                                    if (states.contains(MaterialState.selected)) {
                                      return Colors.green[100];
                                    }
                                    return Colors.grey[100]; // Color de las filas
                                  },
                                ),
                                cells: <DataCell>[
                                  DataCell(Text(
                                    usuario['id'].toString(),
                                    style: TextStyle(color: Colors.green[800]),
                                  )),
                                  DataCell(Text(
                                    usuario['first_name'] ?? '',
                                    style: TextStyle(color: Colors.green[800]),
                                  )),
                                  DataCell(Text(
                                    usuario['date_joined'] ?? '',
                                    style: TextStyle(color: Colors.green[800]),
                                  )),
                                  DataCell(Text(
                                    (usuario['is_active'] ?? false)
                                        ? 'Activo'
                                        : 'Inactivo',
                                    style: TextStyle(
                                      color: (usuario['is_active'] ?? false)
                                          ? Colors.green[800]
                                          : Colors.red[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataCell(Text(
                                      usuario['numero_documento_usuario'] ?? '',
                                      style: TextStyle(color: Colors.green[800])),
                                  ),
                                ],
                              );
                            }).toList(),
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

  Widget _buildFilterInput(String label, Function(String) onChanged) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.green, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      ),
      cursorColor: Colors.green,
    );
  }
}
