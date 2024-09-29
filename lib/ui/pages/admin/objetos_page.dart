import 'package:flutter/material.dart';
import 'Panel/panel.dart';
import 'Resumen/resumen.dart';

class ObjetosAdminPage extends StatefulWidget {
  const ObjetosAdminPage({super.key});

  @override
  _ObjetosAdminPageState createState() => _ObjetosAdminPageState();
}

class _ObjetosAdminPageState extends State<ObjetosAdminPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Componente Panel (con texto y tabla)
            const Panel(),
            // const SizedBox(height: 16),
            // // Componente Resumen
            // const Resumen(),
          ],
        ),
      ),
    );
  }
}
