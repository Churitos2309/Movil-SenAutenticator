import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Inputs para filtrar datos en la tabla con estilos mejorados
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          // Tabla de reportes con desplazamiento vertical y estilo mejorado
          Expanded(
            child: usuarios.isEmpty
                ? Center(
                    child: Text('No hay datos disponibles',
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[600])))
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(0, 4), // Shadow position
                            ),
                          ],
                        ),
                        child: DataTable(
                          columnSpacing: 20,
                          headingRowHeight: 56,
                          dataRowHeight: 60,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.green[700]!),
                          dataRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'ID',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Nombre',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Fecha',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Estado',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Documentos',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                          rows: usuarios.where((usuario) {
                            return usuario['numero_documento_usuario']
                                .toString()
                                .startsWith(documento);
                          }).map<DataRow>((usuario) {
                            return DataRow(
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
                                  (usuario['is_staff'] && usuario['is_active'])
                                      ? 'Activo'
                                      : 'Inactivo',
                                  style: TextStyle(
                                      color: usuario['is_staff'] &&
                                              usuario['is_active']
                                          ? Colors.green[800]
                                          : Colors.red[800]),
                                )),
                                DataCell(Text(
                                  usuario['numero_documento_usuario'] ?? '',
                                  style: TextStyle(color: Colors.green[800]),
                                )),
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
    );
  }

  Widget _buildFilterInput(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextField(
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
        ),
        style: const TextStyle(color: Colors.green),
      ),
    );
  }
}
