// import 'package:flutter/material.dart';
// import 'package:reconocimiento_app/services/api_services.dart';
// import 'package:reconocimiento_app/ui/pages/instructor/Reportes/Fichas_Instructor/Usuarios_aprendiz/Usuarios.dart';

// class FichasScreen extends StatefulWidget {
//   final int programaId;

//   const FichasScreen({required this.programaId, super.key});

//   @override
//   _FichasScreenState createState() => _FichasScreenState();
// }

// class _FichasScreenState extends State<FichasScreen> {
//   final ApiService apiService = ApiService();
//   List<dynamic> fichas = [];
//   bool isLoading = false;
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchFichas();
//   }

//   void fetchFichas() async {
//     try {
//       setState(() {
//         isLoading = true;
//         errorMessage = '';
//       });

//       final endpoint = 'ficha/?programa_ficha=${widget.programaId}';
//       final data = await apiService.get(endpoint);

//       setState(() {
//         fichas = data;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error obteniendo fichas: $e';
//         isLoading = false;
//       });
//     }
//   }

//   void showUserDetails(int fichaId, String numeroFicha) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => UsuariosScreen(fichaId: fichaId, numeroFicha: numeroFicha),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Image.asset(
//               'images/login/LogoReconocimientoFacialBlanco.png',
//               height: 40,
//             ),
//             const SizedBox(width: 8),
//             const Text(
//               'Fichas',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: const Color(0xFF39a900),
//         toolbarHeight: 80,
//         elevation: 0,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(20),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : errorMessage.isNotEmpty
//                 ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 16)))
//                 : fichas.isEmpty
//                     ? Center(child: Text('No hay fichas disponibles.', style: TextStyle(fontSize: 16, color: Colors.grey[600])))
//                     : Container(
//                         padding: const EdgeInsets.all(16.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12.0),
//                           border: Border.all(color: Colors.grey[300]!, width: 2),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               spreadRadius: 2,
//                               blurRadius: 6,
//                               offset: Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: ConstrainedBox(
//                             constraints: BoxConstraints(
//                               minWidth: MediaQuery.of(context).size.width,
//                             ),
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.vertical,
//                               child: DataTable(
//                                 showCheckboxColumn: false, // Ocultar columna de selección
//                                 columnSpacing: 16.0, // Ajustar espacio entre columnas
//                                 dataRowHeight: 50.0, // Ajustar altura de filas de datos
//                                 headingRowHeight: 50.0, // Ajustar altura de filas de encabezado
//                                 headingRowColor: MaterialStateColor.resolveWith(
//                                   (states) => const Color(0xFF39a900),
//                                 ),
//                                 dataRowColor: MaterialStateProperty.resolveWith(
//                                   (states) => Colors.grey[200]!,
//                                 ),
//                                 columns: <DataColumn>[
//                                   DataColumn(
//                                     label: Container(
//                                       padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(color: Color(0xFF2C6B2F), width: 2),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.2),
//                                             spreadRadius: 2,
//                                             blurRadius: 8,
//                                             offset: Offset(0, 4),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'Número Ficha',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xFF2C6B2F),
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   DataColumn(
//                                     label: Container(
//                                       padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(color: Color(0xFF2C6B2F), width: 2),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.2),
//                                             spreadRadius: 2,
//                                             blurRadius: 8,
//                                             offset: Offset(0, 4),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'Aprendices Matriculados',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xFF2C6B2F),
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   DataColumn(
//                                     label: Container(
//                                       padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(color: Color(0xFF2C6B2F), width: 2),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.2),
//                                             spreadRadius: 2,
//                                             blurRadius: 8,
//                                             offset: Offset(0, 4),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'Aprendices Actuales',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xFF2C6B2F),
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   DataColumn(
//                                     label: Container(
//                                       padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(color: Color(0xFF2C6B2F), width: 2),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.2),
//                                             spreadRadius: 2,
//                                             blurRadius: 8,
//                                             offset: Offset(0, 4),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'Jornada',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xFF2C6B2F),
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                                 rows: fichas.map<DataRow>((ficha) {
//                                   return DataRow(
//                                     onSelectChanged: (bool? selected) {
//                                       if (selected != null && selected) {
//                                         showUserDetails(ficha['id'], ficha['numero_ficha']);
//                                       }
//                                     },
//                                     color: MaterialStateProperty.resolveWith<Color?>(
//                                       (states) {
//                                         // Alterna el color de fondo de las filas
//                                         return (states.contains(MaterialState.selected))
//                                             ? Colors.grey[200]
//                                             : null;
//                                       },
//                                     ),
//                                     cells: <DataCell>[
//                                       DataCell(
//                                         Container(
//                                           padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(8),
//                                             border: Border.all(color: Color(0xFF2C6B2F), width: 1),
//                                           ),
//                                           child: Text(
//                                             ficha['numero_ficha'] ?? '',
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       DataCell(
//                                         Container(
//                                           padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(8),
//                                             border: Border.all(color: Color(0xFF2C6B2F), width: 1),
//                                           ),
//                                           child: Text(
//                                             ficha['total_aprendices_matriculados'].toString() ?? '',
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       DataCell(
//                                         Container(
//                                           padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(8),
//                                             border: Border.all(color: Color(0xFF2C6B2F), width: 1),
//                                           ),
//                                           child: Text(
//                                             ficha['total_aprendices_actuales'].toString() ?? '',
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       DataCell(
//                                         Container(
//                                           padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(8),
//                                             border: Border.all(color: Color(0xFF2C6B2F), width: 1),
//                                           ),
//                                           child: Text(
//                                             ficha['jornada'] ?? '',
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//       ),
//     );
//   }
// }
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'Usuarios_aprendiz/Usuarios.dart';

class FichasScreen extends StatefulWidget {
  final int programaId;

  const FichasScreen({required this.programaId, super.key});

  @override
  _FichasScreenState createState() => _FichasScreenState();
}

const primaryColor = Color(0xFF39a900); // Verde institucional del SENA
const defaultPadding = 16.0;

class _FichasScreenState extends State<FichasScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> fichas = [];
  bool isLoading = false;
  String errorMessage = '';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchFichas();
  }

  void fetchFichas() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final endpoint = 'fichas/?programa_ficha=${widget.programaId}';
      final data = await apiService.get(endpoint);

      setState(() {
        fichas = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error obteniendo fichas: $e';
        isLoading = false;
      });
    }
  }

  void showUserDetails(int fichaId, String numeroFicha) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UsuariosScreen(fichaId: fichaId, numeroFicha: numeroFicha),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  )
                : fichas.isEmpty
                    ? Center(
                        child: Text(
                          'No hay fichas disponibles.',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      )
                    : Column(
                        children: [
                          // Sección de filtros
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        searchQuery = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Buscar por número de ficha',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: primaryColor),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Encabezados de la tabla
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.transparent,
                                  width:
                                      1), // Sin borde negro, solo color transparente
                              borderRadius: BorderRadius.circular(
                                  16), // Borde más redondeado
                              color: primaryColor, // Color de fondo verde
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Center(
                                      child: Text(
                                        'Número Ficha',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors
                                              .white, // Cambiamos el color del texto a blanco
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Center(
                                      child: Text(
                                        'Aprendices Matriculados',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Center(
                                      child: Text(
                                        'Aprendices Actuales',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Center(
                                      child: Text(
                                        'Jornada',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tabla de datos
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth:
                                        screenWidth, // Para hacerlo responsivo
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: DataTable(
                                      showCheckboxColumn: false,
                                      columnSpacing: defaultPadding,
                                      dataRowHeight:
                                          50.0, // Filas más compactas
                                      headingRowHeight:
                                          0, // Ocultar el encabezado de la tabla (ya no es necesario)
                                      dataRowColor:
                                          MaterialStateProperty.resolveWith(
                                        (states) => Colors.transparent,
                                      ),
                                      border: TableBorder(
                                        horizontalInside: BorderSide(
                                          color: Colors.grey.withOpacity(0.3),
                                          width: 1, // Línea fina entre filas
                                        ),
                                      ),
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label:
                                              Container(), // Columna vacía para que no aparezca encabezado duplicado
                                        ),
                                        DataColumn(
                                          label:
                                              Container(), // Columna vacía para que no aparezca encabezado duplicado
                                        ),
                                        DataColumn(
                                          label:
                                              Container(), // Columna vacía para que no aparezca encabezado duplicado
                                        ),
                                        DataColumn(
                                          label:
                                              Container(), // Columna vacía para que no aparezca encabezado duplicado
                                        ),
                                      ],
                                      rows: fichas.where((ficha) {
                                        // Filtrar por número de ficha
                                        return ficha['numero_ficha']
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                searchQuery.toLowerCase());
                                      }).map<DataRow>((ficha) {
                                        return DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 16.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.05),
                                                      spreadRadius: 2,
                                                      blurRadius: 8,
                                                      offset: Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  ficha['numero_ficha'] ?? '',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 16.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.05),
                                                      spreadRadius: 2,
                                                      blurRadius: 8,
                                                      offset: Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  ficha['aprendices_matriculados_ficha']
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 16.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.05),
                                                      spreadRadius: 2,
                                                      blurRadius: 8,
                                                      offset: Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  ficha['aprendices_actuales_ficha']
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 16.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.05),
                                                      spreadRadius: 2,
                                                      blurRadius: 8,
                                                      offset: Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  ficha['jornada'] ?? '',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                          onSelectChanged: (selected) {
                                            showUserDetails(ficha['id'],
                                                ficha['numero_ficha']);
                                          },
                                        );
                                      }).toList(),
                                    ),
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
}
