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
import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'package:reconocimiento_app/ui/pages/instructor/Reportes/Fichas_Instructor/Usuarios_aprendiz/Usuarios.dart';

class FichasScreen extends StatefulWidget {
  final int programaId;

  const FichasScreen({required this.programaId, super.key});

  @override
  _FichasScreenState createState() => _FichasScreenState();
}

class _FichasScreenState extends State<FichasScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> fichas = [];
  bool isLoading = false;
  String errorMessage = '';

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

      final endpoint = 'ficha/?programa_ficha=${widget.programaId}';
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
        builder: (context) => UsuariosScreen(fichaId: fichaId, numeroFicha: numeroFicha),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'images/login/LogoReconocimientoFacialBlanco.png',
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text(
              'Fichas',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF39a900),
        toolbarHeight: 80,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 16)))
                : fichas.isEmpty
                    ? Center(child: Text('No hay fichas disponibles.', style: TextStyle(fontSize: 16, color: Colors.grey[600])))
                    : Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey[300]!, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                showCheckboxColumn: false, // Ocultar columna de selección
                                columnSpacing: 16.0, // Ajustar espacio entre columnas
                                dataRowHeight: 50.0, // Ajustar altura de filas de datos
                                headingRowHeight: 50.0, // Ajustar altura de filas de encabezado
                                headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => const Color(0xFF39a900),
                                ),
                                dataRowColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey[200]!,
                                ),
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Container(
                                      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Color(0xFF2C6B2F), width: 2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Número Ficha',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2C6B2F),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Container(
                                      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Color(0xFF2C6B2F), width: 2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Aprendices Matriculados',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2C6B2F),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Container(
                                      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Color(0xFF2C6B2F), width: 2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Aprendices Actuales',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2C6B2F),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Container(
                                      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Color(0xFF2C6B2F), width: 2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Jornada',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2C6B2F),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: fichas.map<DataRow>((ficha) {
                                  return DataRow(
                                    color: MaterialStateProperty.resolveWith<Color?>(
                                      (states) {
                                        // Alterna el color de fondo de las filas
                                        return (states.contains(MaterialState.selected))
                                            ? Colors.grey[200]
                                            : null;
                                      },
                                    ),
                                    cells: <DataCell>[
                                      DataCell(Text(
                                        ficha['numero_ficha'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      )),
                                      DataCell(Text(
                                        ficha['aprendices_matriculados_ficha'].toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      )),
                                      DataCell(Text(
                                        ficha['aprendices_actuales_ficha'].toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      )),
                                      DataCell(Text(
                                        ficha['jornada_ficha'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      )),
                                    ],
                                    onSelectChanged: (selected) {
                                      if (selected != null && selected) {
                                        showUserDetails(
                                          ficha['id'],
                                          ficha['numero_ficha'] ?? '',
                                        );
                                      }
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.report),
              label: 'Reportes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.request_page),
              label: 'Solicitudes',
            ),
          ],
          selectedItemColor: const Color(0xFF39a900),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (index) {
            // Manejar la navegación a otras pantallas aquí
          },
        ),
      ),
    );
  }
}
