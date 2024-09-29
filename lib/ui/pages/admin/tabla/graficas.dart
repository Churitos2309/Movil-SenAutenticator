// import 'package:flutter/material.dart';
// import 'graficas/circular.dart';
// import 'graficas/lineal.dart';


// class Graficas extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Gráfica Circular
//         // GraficaCircular(),
//         const SizedBox(height: 16.0), // Espacio entre las gráficas
//         // Gráfica Lineal
//         GraficaDeBarras(),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'graficas/circular.dart';
import 'graficas/lineal.dart';

class Graficas extends StatelessWidget {
  const Graficas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Gráfica Circular
        // GraficaCircular(),
        const SizedBox(height: 16.0), // Espacio entre las gráficas
        // Gráfica Lineal
        const GraficaDeBarras(), // Asegúrate de agregar la constante aquí
      ],
    );
  }
}
