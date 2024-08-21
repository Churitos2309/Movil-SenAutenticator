// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
// import 'ApiReportes/api_service.dart';
import 'package:reconocimiento_app/services/api_services.dart';

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
  bool isLoading = false;
  String errorMessage = '';

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

  // Future<void> _fetchUsuarios() async {
  //   setState(() {
  //     isLoading = true;
  //     errorMessage = '';
  //   });

  //   try {
  //     final data = await apiService.fetchUsuarios(ficha, documento, tiempo);
  //     setState(() {
  //       usuarios = data;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       errorMessage = 'Error al cargar datos: ${e.toString()}';
  //     });
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildFilterInput('Fichas', (value) {
                    setState(() {
                      ficha = value;
                    });
                    fetchUsuarios();
                  }),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildFilterInput('Documentos', (value) {
                    setState(() {
                      documento = value;
                    });
                    fetchUsuarios();
                  }),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildFilterInput('Tiempo', (value) {
                    setState(() {
                      tiempo = value;
                    });
                    fetchUsuarios();
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage))
                      : usuarios.isEmpty
                          ? Center(
                              child: Text('No hay datos disponibles',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[600])))
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: MediaQuery.of(context).size.width,
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    columnSpacing: 16.0,
                                    dataRowMaxHeight: 50.0,
                                    headingRowHeight: 50.0,
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => const Color.fromARGB(255, 16, 255, 28)!),
                                    dataRowColor:
                                        MaterialStateProperty.resolveWith(
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
                                    rows: usuarios.map<DataRow>((usuario) {
                                      return DataRow(
                                        color: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return Colors.green[100];
                                            }
                                            return Colors.grey[100];
                                          },
                                        ),
                                        cells: <DataCell>[
                                          DataCell(Text(
                                            usuario['id'].toString(),
                                            style: TextStyle(
                                                color: Colors.green[800]),
                                          )),
                                          DataCell(Text(
                                            usuario['first_name'] ?? '',
                                            style: TextStyle(
                                                color: Colors.green[800]),
                                          )),
                                          DataCell(Text(
                                            usuario['date_joined'] ?? '',
                                            style: TextStyle(
                                                color: Colors.green[800]),
                                          )),
                                          DataCell(Text(
                                            (usuario['is_active'] ?? false)
                                                ? 'Activo'
                                                : 'Inactivo',
                                            style: TextStyle(
                                              color: (usuario['is_active'] ??
                                                      false)
                                                  ? Colors.green[800]
                                                  : Colors.red[800],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(
                                            Text(
                                                usuario['numero_documento_usuario'] ??
                                                    '',
                                                style: TextStyle(
                                                    color: Colors.green[800])),
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
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      ),
      cursorColor: Colors.green,
    );
  }
}
