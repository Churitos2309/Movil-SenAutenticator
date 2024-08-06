import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/report/aprendiz_card.dart';


class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Página'),
      ),
      body: ListView(
        children: const [
          AprendizCard(
            aprendiz: {
              'id': 1,
              'nombre': 'Dorado Ramirez Juan Sebastian',
              'documento': 'C.C 28714052',
              'estado': true,
              'hora': '07:15 am',
            },
          ),
          AprendizCard(
            aprendiz: {
              'id': 2,
              'nombre': 'Daniel Camilo Astaiza Toro',
              'documento': 'C.C 2845609',
              'estado': true,
              'hora': '07:05 am',
            },
          ),
          // Agrega más AprendizCard para mostrar más aprendices
        ],
      ),
    );
  }
}