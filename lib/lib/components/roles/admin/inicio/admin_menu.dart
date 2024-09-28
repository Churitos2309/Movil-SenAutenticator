// import 'package:flutter/material.dart';

// class AdminMenu extends StatelessWidget {
//   const AdminMenu({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Menú de Administración forma de prueba pasar las cosas',
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  Future<Map<String, int>?> fetchData() async {
    final String apiUrl =
        'https://backendsenauthenticator.up.railway.app/api/usuarios/';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Agrupa por rol de usuario y cuenta cuántos hay por rol
      Map<String, int> roleCounts = {};
      for (var user in data) {
        String role = user['rol_usuario'] ?? 'Desconocido'; // Valor por defecto si 'rol_usuario' es null
        roleCounts[role] = (roleCounts[role] ?? 0) + 1;
      }
      return roleCounts;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        "Distribución de personas en el SENA por su rol de usuario",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      FutureBuilder<Map<String, int>?>(
                        future: fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                            return const Text('No hay datos disponibles');
                          } else {
                            final roleCounts = snapshot.data!;
                            return Container(
                              height: 400, // Mantiene la altura ajustada
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey, width: 1),
                              ),
                              child: BarChart(
                                BarChartData(
                                  barGroups: roleCounts.entries
                                      .map(
                                        (entry) => BarChartGroupData(
                                          x: roleCounts.keys.toList().indexOf(entry.key),
                                          barRods: [
                                            BarChartRodData(
                                              toY: entry.value.toDouble(),
                                              color: Colors.blueAccent, // Color mejorado
                                              width: 30, // Ajuste del ancho de las barras
                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                              backDrawRodData: BackgroundBarChartRodData(
                                                show: true,
                                                toY: roleCounts.values.reduce((a, b) => a > b ? a : b).toDouble(),
                                                color: Colors.blue.withOpacity(0.1), // Fondo sutil
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 40,
                                        interval: 1, // Solo enteros
                                        getTitlesWidget: (value, meta) {
                                          if (value % 1 != 0) return Container(); // Evita decimales
                                          return Text(
                                            value.toInt().toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: 1,
                                        getTitlesWidget: (value, meta) {
                                          final roleNames = roleCounts.keys.toList();
                                          if (value < 0 || value >= roleNames.length) {
                                            return const SizedBox();
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              roleNames[value.toInt()],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  gridData: FlGridData(
                                    show: true,
                                    horizontalInterval: 1, // Líneas cada 1 unidad
                                    drawVerticalLine: false,
                                    getDrawingHorizontalLine: (value) => FlLine(
                                      color: Colors.grey.withOpacity(0.5), // Líneas sutiles
                                      strokeWidth: 0.8,
                                    ),
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: const Border(
                                      bottom: BorderSide(color: Colors.black, width: 1),
                                      left: BorderSide(color: Colors.black, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
