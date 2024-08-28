import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class GraficasScreen extends StatefulWidget {
  const GraficasScreen({Key? key}) : super(key: key);

  @override
  _GraficasScreenState createState() => _GraficasScreenState();
}

class _GraficasScreenState extends State<GraficasScreen> {
  late Future<Map<String, dynamic>> _graficaData;

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _graficaData = fetchData();
  }

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final data = await apiService.get('usuario/');

      // Verifica si data es una lista y tiene elementos
      if (data.isEmpty || data is! List) {
        return {};
      }

      Map<String, int> generoCounts = {
        'Masculino': 0,
        'Femenino': 0,
      };

      for (var usuario in data) {
        String genero = usuario['genero_usuario'];
        if (generoCounts.containsKey(genero)) {
          generoCounts[genero] = generoCounts[genero]! + 1;
        }
      }

      // Datos para el gráfico de barras
      List<Map<String, dynamic>> barData = generoCounts.entries.map((entry) {
        return {
          'x': entry.key == 'Masculino' ? 1 : 2,
          'y': entry.value,
        };
      }).toList();

      // Datos para el gráfico circular
      int total = generoCounts.values.reduce((a, b) => a + b);
      List<Map<String, dynamic>> pieData = generoCounts.entries.map((entry) {
        return {
          'color': entry.key == 'Masculino' ? 0xFF4CAF50 : 0xFFFF5722,
          'value': total > 0 ? (entry.value / total) * 100 : 0,
          'radius': 50.0,
        };
      }).toList();

      return {
        'barData': barData,
        'pieData': pieData,
      };
    } catch (e) {
      print('Error fetching data: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<Map<String, dynamic>>(
        future: _graficaData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final data = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Diagrama de Barras',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: BarChart(
                              BarChartData(
                                borderData: FlBorderData(show: false),
                                gridData: FlGridData(show: true),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget:
                                          (double value, TitleMeta meta) {
                                        String text;
                                        switch (value.toInt()) {
                                          case 1:
                                            text = 'Masculino';
                                            break;
                                          case 2:
                                            text = 'Femenino';
                                            break;
                                          default:
                                            text = '';
                                        }
                                        return Text(
                                          text,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget:
                                          (double value, TitleMeta meta) {
                                        return Text(
                                          value % 5 == 0
                                              ? '${value.toInt()}'
                                              : '',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        );
                                      },
                                      reservedSize: 40,
                                    ),
                                  ),
                                ),
                                barGroups: _generateBarData(data['barData']),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Gráfico Circular',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: PieChart(
                              PieChartData(
                                sections: _generatePieData(data['pieData']),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  List<BarChartGroupData> _generateBarData(List<dynamic> barData) {
    return barData.map((item) {
      return BarChartGroupData(
        x: item['x'],
        barRods: [
          BarChartRodData(
            toY: item['y'].toDouble(),
            color: Colors.green,
            width: 22,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }

  List<PieChartSectionData> _generatePieData(List<dynamic> pieData) {
    return pieData.map((item) {
      return PieChartSectionData(
        color: Color(item['color']),
        value: item['value'].toDouble(),
        title: '${item['value'].toStringAsFixed(1)}%',
        radius: item['radius'].toDouble(),
        titleStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}
