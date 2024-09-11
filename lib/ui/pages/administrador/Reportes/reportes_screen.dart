// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart'; // Importar flutter_svg
// import 'package:reconocimiento_app/services/api_services.dart';

// class ReportesScreen extends StatefulWidget {
//   const ReportesScreen({super.key});

//   @override
//   _ReportesScreenState createState() => _ReportesScreenState();
// }
// const primaryColor = Color(0xFF2697FF);
// const secondaryColor = Color(0xFF2A2D3E);
// const bgColor = Color(0xFF212332);
// const defaultPadding = 16.0;

// class _ReportesScreenState extends State<ReportesScreen> {
//   final ApiService apiService = ApiService();
//   List<dynamic> usuarios = [];
//   String ficha = '';
//   String documento = '';
//   String tiempo = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchUsuarios();
//   }

//   void fetchUsuarios() async {
//     try {
//       final data = await apiService.get('usuario/');
//       setState(() {
//         usuarios = data;
//       });
//     } catch (e) {
//       print('Error Obteniendo Usuarios: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(defaultPadding),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Inputs para filtrar datos en la tabla con estilos mejorados
//           Row(
//             children: [
//               Expanded(
//                 child: _buildFilterInput('Fichas', (value) {
//                   setState(() {
//                     ficha = value;
//                   });
//                   fetchUsuarios();
//                 }),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: _buildFilterInput('Documentos', (value) {
//                   setState(() {
//                     documento = value;
//                   });
//                   fetchUsuarios();
//                 }),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: _buildFilterInput('Tiempo', (value) {
//                   setState(() {
//                     tiempo = value;
//                   });
//                   fetchUsuarios();
//                 }),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           // Tabla de reportes con desplazamiento vertical y estilo mejorado
//           Expanded(
//             child: usuarios.isEmpty
//                 ? Center(
//                     child: Text('No hay datos disponibles',
//                         style: TextStyle(fontSize: 16, color: Colors.grey[600])))
//                 : SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Container(
//                         padding: EdgeInsets.all(defaultPadding),
//                         decoration: BoxDecoration(
//                           color: secondaryColor,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: DataTable(
//                           columnSpacing: defaultPadding,
//                           headingRowHeight: 56,
//                           dataRowHeight: 60,
//                           headingRowColor: MaterialStateColor.resolveWith(
//                               (states) => primaryColor),
//                           dataRowColor: MaterialStateColor.resolveWith(
//                               (states) => Colors.white),
//                           columns: <DataColumn>[
//                             DataColumn(
//                               label: Text(
//                                 'ID',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                     fontSize: 16),
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'Nombre',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                     fontSize: 16),
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'Fecha',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                     fontSize: 16),
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'Estado',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                     fontSize: 16),
//                               ),
//                             ),
//                             DataColumn(
//                               label: Text(
//                                 'Documentos',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                     fontSize: 16),
//                               ),
//                             ),
//                           ],
//                           rows: usuarios.where((usuario) {
//                             return usuario['numero_documento_usuario']
//                                 .toString()
//                                 .startsWith(documento);
//                           }).map<DataRow>((usuario) {
//                             return DataRow(
//                               cells: <DataCell>[
//                                 DataCell(Text(
//                                   usuario['id'].toString(),
//                                   style: TextStyle(color: primaryColor),
//                                 )),
//                                 DataCell(Text(
//                                   usuario['first_name'] ?? '',
//                                   style: TextStyle(color: primaryColor),
//                                 )),
//                                 DataCell(Text(
//                                   usuario['date_joined'] ?? '',
//                                   style: TextStyle(color: primaryColor),
//                                 )),
//                                 DataCell(Text(
//                                   (usuario['is_staff'] && usuario['is_active'])
//                                       ? 'Activo'
//                                       : 'Inactivo',
//                                   style: TextStyle(
//                                       color: usuario['is_staff'] &&
//                                               usuario['is_active']
//                                           ? primaryColor
//                                           : Colors.red[800]),
//                                 )),
//                                 DataCell(Text(
//                                   usuario['numero_documento_usuario'] ?? '',
//                                   style: TextStyle(color: primaryColor),
//                                 )),
//                               ],
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterInput(String label, Function(String) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//       child: TextField(
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: TextStyle(color: primaryColor),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             borderSide: BorderSide(color: primaryColor, width: 1.5),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             borderSide: BorderSide(color: primaryColor, width: 2.0),
//           ),
//         ),
//         style: TextStyle(color: primaryColor),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/administrador/Reportes/Panel/panel.dart';
import 'package:reconocimiento_app/ui/pages/administrador/Reportes/Resumen/resumen.dart';

class ReportesScreen extends StatefulWidget {
  const ReportesScreen({super.key});

  @override
  _ReportesScreenState createState() => _ReportesScreenState();
}

class _ReportesScreenState extends State<ReportesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Componente Panel (con texto y tabla)
            const Panel(),
            const SizedBox(height: 16),
            // Componente Resumen
            const Resumen(),
          ],
        ),
      ),
    );
  }
}

