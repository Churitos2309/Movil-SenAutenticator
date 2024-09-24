import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePagew extends StatefulWidget {
  const HomePagew({super.key});

  @override
  _HomePagewState createState() => _HomePagewState();
}

class _HomePagewState extends State<HomePagew> {

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Imagenes dinámicas en un Slider
            SizedBox(
              height: 200,
              child: Image.network("https://picsum.photos/id/123/500/300"), // Replace '123' with the actual identifier or variable
            ),

            const SizedBox(height: 16),

            // Campo de búsqueda
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: "Buscar",
                labelStyle: TextStyle(color: Colors.green),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 32),

            // Botón para lanzar búsqueda en un sitio web específico
            ElevatedButton(
              onPressed: () {
                final searchText = _searchController.text.trim();
                if (searchText.isNotEmpty) {
                  launch("https://www.example.com/search?q=$searchText");
                }
              },
              child: const Text("Buscar en sitio web"),
            ),
          ],
        ),
      ),
    );
  }
}