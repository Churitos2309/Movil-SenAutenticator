import 'package:flutter/material.dart';
import 'tabla/graficas.dart';

class HistorialAdminPage extends StatelessWidget {
  const HistorialAdminPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      // backgroundColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Campo Azul
              _buildCard(
                title: "Total Aprendices",
                value: "1234",
                subtitle: "Rango de fichas seleccionadas",
                colors: [Colors.blue.shade200, Colors.blue.shade500],
              ),
              const SizedBox(height: 16.0),

              // Campo Verde
              _buildCard(
                title: "Promedio por Día",
                value: "567",
                subtitle: "Datos adicionales aquí",
                colors: [Colors.green.shade200, Colors.green.shade500],
              ),
              const SizedBox(height: 16.0),

              // Campo Naranja
              _buildCard(
                title: "Día con Mayor Entrada",
                value: "789",
                subtitle: "Detalles adicionales aquí",
                colors: [Colors.orange.shade200, Colors.orange.shade500],
              ),
              const SizedBox(height: 16.0),

              // Importar y mostrar el widget de gráficas
              const Graficas(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required String value, required String subtitle, required List<Color> colors}) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: colors.first.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8.0),
            Text(
              value,
              style: const TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
            const SizedBox(height: 8.0),
            Text(
              subtitle,
              style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
