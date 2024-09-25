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
      Map<String, int> generoCounts = {
        'Masculino': 0,
        'Femenino': 0,
        'No especificado': 0,
      };

      for (var usuario in data) {
        String genero = usuario['genero_usuario'] ?? 'No especificado';
        if (generoCounts.containsKey(genero)) {
          generoCounts[genero] = generoCounts[genero]! + 1;
        } else {
          generoCounts['No especificado'] = generoCounts['No especificado']! + 1;
        }
      }

      List<Map<String, dynamic>> barData = generoCounts.entries.map((entry) {
        return {
          'x': entry.key == 'Masculino'
              ? 1
              : entry.key == 'Femenino'
                  ? 2
                  : 3,
          'y': entry.value,
        };
      }).toList();

      int total = generoCounts.values.reduce((a, b) => a + b);
      List<Map<String, dynamic>> pieData = generoCounts.entries.map((entry) {
        return {
          'color': entry.key == 'Masculino'
              ? 0xFF4CAF50
              : entry.key == 'Femenino'
                  ? 0xFFFF5722
                  : 0xFF81D4FA,
          'value': (entry.value / total) * 100,
          'count': entry.value,
          'radius': 40.0,
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Cargando datos...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(
                    color: Colors.green, // Color verde para la barra de carga
                    backgroundColor: Colors.grey, // Fondo gris para la barra
                    minHeight: 6, // Altura de la barra
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return LayoutBuilder(
              builder: (context, constraints) {
                bool isSmallScreen = constraints.maxWidth < 600;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isSmallScreen)
                      ..._buildGraphsInColumn(data)
                    else
                      Row(
                        children: _buildGraphsInRow(data),
                      ),
                  ],
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  List<Widget> _buildGraphsInRow(Map<String, dynamic> data) {
    return [
      Expanded(
        child: Column(
          children: [
            const Text(
              'Diagrama de Barras',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 150, // Reduce la altura de la gráfica de barras
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          String text;
                          switch (value.toInt()) {
                            case 1:
                              text = 'Masculino';
                              break;
                            case 2:
                              text = 'Femenino';
                              break;
                            case 3:
                              text = 'No espec.';
                              break;
                            default:
                              text = '';
                          }
                          return Text(
                            text,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10, // Tamaño de fuente reducido
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value % 1 == 0 ? '${value.toInt()}' : '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10, // Tamaño de fuente reducido
                            ),
                          );
                        },
                        reservedSize: 28,
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
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          children: [
            const Text(
              'Gráfico Circular',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 150, // Reduce la altura del gráfico circular
              child: PieChart(
                PieChartData(
                  sections: _generatePieData(data['pieData']),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildGraphsInColumn(Map<String, dynamic> data) {
    return [
      Column(
        children: [
          const Text(
            'Diagrama de Barras',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 150, // Reduce la altura de la gráfica de barras
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        String text;
                        switch (value.toInt()) {
                          case 1:
                            text = 'Masculino';
                            break;
                          case 2:
                            text = 'Femenino';
                            break;
                          case 3:
                            text = 'No espec.';
                            break;
                          default:
                            text = '';
                        }
                        return Text(
                          text,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10, // Tamaño de fuente reducido
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          value % 1 == 0 ? '${value.toInt()}' : '',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10, // Tamaño de fuente reducido
                          ),
                        );
                      },
                      reservedSize: 28,
                    ),
                  ),
                ),
                barGroups: _generateBarData(data['barData']),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Column(
        children: [
          const Text(
            'Gráfico Circular',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 150, // Reduce la altura del gráfico circular
            child: PieChart(
              PieChartData(
                sections: _generatePieData(data['pieData']),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  List<BarChartGroupData> _generateBarData(List<dynamic> barData) {
    return barData.map((item) {
      return BarChartGroupData(
        x: item['x'],
        barRods: [
          BarChartRodData(
            toY: item['y'].toDouble(),
            color: const Color(0xFF4CAF50),
            width: 18, // Reduce el ancho de las barras
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();
  }

  List<PieChartSectionData> _generatePieData(List<dynamic> pieData) {
    return pieData.map((item) {
      return PieChartSectionData(
        color: Color(item['color']),
        value: item['value'],
        title: '${item['value'].toStringAsFixed(1)}%',
        radius: 30, // Reduce el radio de las secciones del gráfico
        titleStyle: const TextStyle(
          fontSize: 12, // Reduce el tamaño de la fuente de las etiquetas
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}
