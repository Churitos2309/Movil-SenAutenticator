import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'package:reconocimiento_app/ui/pages/instructor/Reportes/Fichas_Instructor/fichas_screen.dart';

class ReportesScreen extends StatefulWidget {
  const ReportesScreen({super.key});

  @override
  _ReportesScreenState createState() => _ReportesScreenState();
}

const primaryColor = Color(0xFF39a900); // Color verde institucional del SENA
const defaultPadding = 16.0;

class _ReportesScreenState extends State<ReportesScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> programas = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProgramas();
  }

  void fetchProgramas() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final data = await apiService.get('programa/');
      setState(() {
        programas = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error obteniendo programas: $e';
        isLoading = false;
      });
    }
  }

  void _onRowTap(int programaId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FichasScreen(programaId: programaId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                : programas.isEmpty
                    ? Center(
                        child: Text(
                          'No hay datos disponibles.',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      )
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
                                showCheckboxColumn: false,
                                columnSpacing: defaultPadding,
                                dataRowHeight: 50.0,
                                headingRowHeight: 50.0,
                                headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => primaryColor,
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
                                        border: Border.all(color: primaryColor, width: 2),
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
                                          'Nombre Programa',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                            fontSize: 14,
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
                                        border: Border.all(color: primaryColor, width: 2),
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
                                          'Tipo Formación',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: programas.map<DataRow>((programa) {
                                  return DataRow(
                                    color: MaterialStateProperty.resolveWith<Color?>(
                                      (states) {
                                        if (states.contains(MaterialState.selected)) {
                                          return Colors.green[100];
                                        }
                                        return Colors.grey[100];
                                      },
                                    ),
                                    cells: <DataCell>[
                                      DataCell(
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: primaryColor, width: 1),
                                          ),
                                          child: Text(
                                            programa['nombre_programa'] ?? '',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: primaryColor, width: 1),
                                          ),
                                          child: Text(
                                            programa['tipo_formacion_programa'] ?? '',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    onSelectChanged: (selected) {
                                      if (selected != null && selected) {
                                        _onRowTap(programa['id']);
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
    );
  }
}
