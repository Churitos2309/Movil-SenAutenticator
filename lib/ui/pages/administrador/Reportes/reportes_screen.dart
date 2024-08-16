// import 'package:flutter/material.dart';

// class ReportesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildActionButton(Icons.person, 'Rol'),
//               _buildActionButton(Icons.description, 'Documento'),
//               _buildActionButton(Icons.access_time, 'Tiempo'),
//               _buildActionButton(Icons.show_chart, 'Gráficas'),
//             ],
//           ),
//         ),
//         Expanded(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: DataTable(
//               columnSpacing: 10,
//               headingRowColor: MaterialStateColor.resolveWith(
//                   (states) => Color(0xFF008000).withOpacity(0.1)),
//               dataRowColor:
//                   MaterialStateColor.resolveWith((states) => Colors.white),
//               headingTextStyle:
//                   TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
//               dataTextStyle: TextStyle(fontSize: 10),
//               columns: const <DataColumn>[
//                 DataColumn(
//                   label: Text('ID'),
//                 ),
//                 DataColumn(
//                   label: Text('Nombre'),
//                 ),
//                 DataColumn(
//                   label: Text('Fecha'),
//                 ),
//                 DataColumn(
//                   label: Text('Estado'),
//                 ),
//                 DataColumn(
//                   label: Text('Acciones'),
//                 ),
//               ],
//               rows: <DataRow>[
//                 _buildDataRow('1', 'Juan Pérez', '2024-08-12', true),
//                 _buildDataRow('2', 'María Gómez', '2024-08-11', false),
//                 _buildDataRow('3', 'Carlos Ruiz', '2024-08-10', true),
//                 _buildDataRow('4', 'Ana López', '2024-08-09', false),
//                 _buildDataRow('5', 'Luis Martínez', '2024-08-08', true),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButton(IconData icon, String label) {
//     return ElevatedButton.icon(
//       onPressed: () {},
//       icon: Icon(icon, size: 20),
//       label: Text(label),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//           side: BorderSide(color: Color(0xFF008000), width: 2),
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       ),
//     );
//   }

//   DataRow _buildDataRow(String id, String name, String date, bool isGood) {
//     return DataRow(
//       cells: <DataCell>[
//         DataCell(Text(id)),
//         DataCell(Text(name)),
//         DataCell(Text(date)),
//         DataCell(
//           Icon(
//             isGood ? Icons.check_circle : Icons.cancel,
//             color: isGood ? Colors.green : Colors.red,
//             size: 16,
//           ),
//         ),
//         DataCell(
//           TextButton(
//             onPressed: () {},
//             child: Text('Ver detalles', style: TextStyle(color: Colors.blue)),
//           ),
//         ),
//       ],
//     );
//   }
// }

// ignore_for_file: avoid_print

/////////////////////////////////////////////////// Cosnumo de la API
library;


// import 'package:flutter/material.dart';
// import 'ApiAdmin/api_service.dart';

// class ReportesScreen extends StatefulWidget {
//   @override
//   _ReportesScreenState createState() => _ReportesScreenState();
// }

// class _ReportesScreenState extends State<ReportesScreen> {
//   final ApiService apiService = ApiService();
//   List<dynamic> usuarios = [];
//   String ficha = '';
//   String documento = '';
//   String tiempo = '';

//   @override
//   void initState() {
//     super.initState();
//     // Inicialmente, la tabla estará vacía hasta que se busquen datos
//   }

//   Future<void> _fetchUsuarios() async {
//     try {
//       final data = await apiService.fetchUsuarios(ficha, documento, tiempo);
//       setState(() {
//         usuarios = data;
//       });
//     } catch (e) {
//       // Manejo de errores
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reportes Admin'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Inputs para filtrar datos en la tabla
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     onChanged: (value) {
//                       setState(() {
//                         ficha = value;
//                       });
//                       _fetchUsuarios();
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Fichas',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     onChanged: (value) {
//                       setState(() {
//                         documento = value;
//                       });
//                       _fetchUsuarios();
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Documentos',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     onChanged: (value) {
//                       setState(() {
//                         tiempo = value;
//                       });
//                       _fetchUsuarios();
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Tiempo',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             // Tabla de reportes
//             Expanded(
//               child: usuarios.isEmpty
//                   ? Center(child: Text('No hay datos disponibles'))
//                   : SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         columns: const <DataColumn>[
//                           DataColumn(
//                             label: Text('ID'),
//                           ),
//                           DataColumn(
//                             label: Text('Nombre'),
//                           ),
//                           DataColumn(
//                             label: Text('Fecha'),
//                           ),
//                           DataColumn(
//                             label: Text('Estado'),
//                           ),
//                           DataColumn(
//                             label: Text('Documentos'),
//                           ),
//                         ],
//                         rows: usuarios.map<DataRow>((usuario) {
//                           return DataRow(
//                             cells: <DataCell>[
//                               DataCell(Text(usuario['id'].toString())),
//                               DataCell(Text(usuario['first_name'] ?? '')),
//                               DataCell(Text(usuario['date_joined'] ?? '')),
//                               DataCell(Text(
//                                   usuario['is_staff'] && usuario['is_active']
//                                       ? 'Activo'
//                                       : 'Inactivo')),
//                               DataCell(Text(
//                                   usuario['numero_documento_usuario'] ?? '')),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

import 'ApiAdmin/api_service.dart';

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
    // Inicialmente, la tabla estará vacía hasta que se busquen datos
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
      //   title: Text('Reportes Admin'),
      //   backgroundColor: Colors.green[800],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Inputs para filtrar datos en la tabla con estilos mejorados
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
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: WidgetStateColor.resolveWith(
                            (states) => Colors.green[700]!),
                        dataRowColor: WidgetStateColor.resolveWith(
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
