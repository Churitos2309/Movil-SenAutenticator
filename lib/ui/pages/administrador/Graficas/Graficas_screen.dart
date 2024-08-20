import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficasScreen extends StatelessWidget {
  const GraficasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
                          borderData: FlBorderData(
                            show: false,
                          ),
                          gridData: FlGridData(show: true),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  String text;
                                  switch (value.toInt()) {
                                    case 1:
                                      text = 'A';
                                      break;
                                    case 2:
                                      text = 'B';
                                      break;
                                    case 3:
                                      text = 'C';
                                      break;
                                    case 4:
                                      text = 'D';
                                      break;
                                    case 5:
                                      text = 'E';
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
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  return Text(
                                    value % 5 == 0 ? '${value.toInt()}' : '',
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
                          barGroups: [
                            BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(
                                  toY: 8,
                                  color: Colors.green,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 2,
                              barRods: [
                                BarChartRodData(
                                  toY: 10,
                                  color: Colors.green,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 3,
                              barRods: [
                                BarChartRodData(
                                  toY: 14,
                                  color: Colors.green,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 4,
                              barRods: [
                                BarChartRodData(
                                  toY: 15,
                                  color: Colors.green,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 5,
                              barRods: [
                                BarChartRodData(
                                  toY: 13,
                                  color: Colors.green,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                          ],
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
                          sections: [
                            PieChartSectionData(
                              color: Colors.green,
                              value: 40,
                              title: '40%',
                              radius: 60,
                              titleStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              color: Colors.orange,
                              value: 30,
                              title: '30%',
                              radius: 50,
                              titleStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              color: Colors.blue,
                              value: 20,
                              title: '20%',
                              radius: 40,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              color: Colors.red,
                              value: 10,
                              title: '10%',
                              radius: 30,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
