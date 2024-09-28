// import 'package:flutter/material.dart';

// class ReportesPage extends StatelessWidget {
//   const ReportesPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Página de Reportes de prueba',
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'Panel/panel.dart';
import 'Resumen/resumen.dart';

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
