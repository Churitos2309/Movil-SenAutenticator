// import 'package:flutter/material.dart';

// class GraficasPage extends StatelessWidget {
//   const GraficasPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Página de Gráficas',
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class GraficasScreen extends StatelessWidget {
//   const GraficasScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Gráfica Circular en su propio recuadro
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       const Text(
//                         "Gráfica Circular",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       Container(
//                         height: 200, // Ajusta el tamaño según necesites
//                         child: Stack(
//                           children: [
//                             PieChart(
//                               PieChartData(
//                                 sectionsSpace: 0,
//                                 centerSpaceRadius: 70,
//                                 startDegreeOffset: -90,
//                                 sections: paiChartSelectionData,
//                               ),
//                             ),
//                             Positioned.fill(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const SizedBox(height: 16.0),
//                                   Text(
//                                     "porcentaje",
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600,
//                                       height: 0.5,
//                                     ),
//                                   ),
//                                   Text(
//                                     "of 128GB",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16.0), // Espacio entre las gráficas
//               // Gráfica de Línea de Frecuencia en su propio recuadro
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       const Text(
//                         "Gráfica de Línea",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       Container(
//                         height: 200, // Ajusta el tamaño según necesites
//                         child: LineChart(
//                           LineChartData(
//                             gridData: FlGridData(
//                               show: true,
//                               drawVerticalLine: true,
//                               getDrawingHorizontalLine: (value) {
//                                 return FlLine(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   strokeWidth: 1,
//                                 );
//                               },
//                               getDrawingVerticalLine: (value) {
//                                 return FlLine(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   strokeWidth: 1,
//                                 );
//                               },
//                             ),
//                             titlesData: FlTitlesData(
//                               show: true,
//                               rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                               topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                               bottomTitles: AxisTitles(
//                                 sideTitles: SideTitles(
//                                   showTitles: true,
//                                   reservedSize: 22,
//                                   getTitlesWidget: (value, meta) {
//                                     const style = TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 14,
//                                     );
//                                     Widget text;
//                                     switch (value.toInt()) {
//                                       case 0:
//                                         text = const Text('Lun', style: style);
//                                         break;
//                                       case 1:
//                                         text = const Text('Mar', style: style);
//                                         break;
//                                       case 2:
//                                         text = const Text('Mie', style: style);
//                                         break;
//                                       case 3:
//                                         text = const Text('Jue', style: style);
//                                         break;
//                                       case 4:
//                                         text = const Text('Vie', style: style);
//                                         break;
//                                       case 5:
//                                         text = const Text('Sab', style: style);
//                                         break;
//                                       case 6:
//                                         text = const Text('Dom', style: style);
//                                         break;
//                                       default:
//                                         text = const Text('', style: style);
//                                         break;
//                                     }
//                                     return SideTitleWidget(
//                                       axisSide: meta.axisSide,
//                                       space: 16,
//                                       child: text,
//                                     );
//                                   },
//                                 ),
//                               ),
//                               leftTitles: AxisTitles(
//                                 sideTitles: SideTitles(
//                                   showTitles: true,
//                                   reservedSize: 28,
//                                   getTitlesWidget: (value, meta) {
//                                     const style = TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 14,
//                                     );
//                                     return SideTitleWidget(
//                                       axisSide: meta.axisSide,
//                                       space: 8,
//                                       child: Text(value.toInt().toString(), style: style),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             borderData: FlBorderData(
//                               show: true,
//                               border: Border.all(color: Colors.grey, width: 1),
//                             ),
//                             minX: 0,
//                             maxX: 6,
//                             minY: 0,
//                             maxY: 20,
//                             lineBarsData: [
//                               LineChartBarData(
//                                 spots: [
//                                   FlSpot(0, 8),
//                                   FlSpot(1, 10),
//                                   FlSpot(2, 14),
//                                   FlSpot(3, 15),
//                                   FlSpot(4, 13),
//                                   FlSpot(5, 10),
//                                   FlSpot(6, 8),
//                                 ],
//                                 isCurved: true,
//                                 color: const Color(0xFF39A900),
//                                 barWidth: 4, // Ajusta el ancho de la línea según necesites
//                                 isStrokeCapRound: true,
//                                 dotData: FlDotData(
//                                   show: false,
//                                 ),
//                                 belowBarData: BarAreaData(
//                                   show: true,
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       const Color(0xFF39A900).withOpacity(0.3),
//                                       const Color(0xFF39A900).withOpacity(0.0),
//                                     ],
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Datos de la Gráfica Circular
// List<PieChartSectionData> paiChartSelectionData = [
//   PieChartSectionData(
//     color: const Color(0xFF39A900),
//     value: 25,
//     showTitle: false,
//     radius: 25,
//   ),
//   PieChartSectionData(
//     color: const Color(0xFF26E5FF),
//     value: 20,
//     showTitle: false,
//     radius: 22,
//   ),
//   PieChartSectionData(
//     color: const Color(0xFFFFCF26),
//     value: 10,
//     showTitle: false,
//     radius: 19,
//   ),
//   PieChartSectionData(
//     color: const Color(0xFFEE2727),
//     value: 15,
//     showTitle: false,
//     radius: 16,
//   ),
//   PieChartSectionData(
//     color: const Color(0xFF39A900).withOpacity(0.1),
//     value: 25,
//     showTitle: false,
//     radius: 13,
//   ),
// ];
import 'package:flutter/material.dart';
import 'tabla/graficas.dart';

class GraficasScreen extends StatelessWidget {
  const GraficasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Campo Azul
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.6), // Menos transparente
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Aprendices",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white, // Cambiado a blanco
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "1234", // Número cualquiera
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white, // Cambiado a blanco
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Rango de fichas seleccionadas",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, // Cambiado a blanco
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0), // Espacio entre los campos
              // Campo Verde
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.6), // Menos transparente
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Promedio por Día",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white, // Cambiado a blanco
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "567", // Número cualquiera
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white, // Cambiado a blanco
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Datos adicionales aquí", // Puedes ajustar el texto
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, // Cambiado a blanco
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0), // Espacio entre los campos
              // Campo Naranja
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.6), // Menos transparente
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Día con Mayor Entrada",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white, // Cambiado a blanco
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "789", // Número cualquiera
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white, // Cambiado a blanco
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Detalles adicionales aquí", // Puedes ajustar el texto
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, // Cambiado a blanco
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0), // Espacio entre los campos
              // Importar y mostrar el widget de gráficas
              Graficas(),
            ],
          ),
        ),
      ),
    );
  }
}
