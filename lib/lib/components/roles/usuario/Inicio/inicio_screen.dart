import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Eliminados los campos pequeños cuadrados

            const SizedBox(height: 16.0),

            // Título centrado
            Center(
              child: Text(
                "Previa vista",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            
            // Campos grandes con imágenes uno al lado del otro
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLargeImageCard('assets/image1.jpg', "Campo 1"),
                  _buildLargeImageCard('assets/image2.jpg', "Campo 2"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir los campos grandes con imágenes
  Widget _buildLargeImageCard(String imagePath, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      width: 150, // Ajusta el ancho de los campos grandes
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // Sombra
          ),
        ],
      ),
      child: Column(
        children: [
          // Imagen en la parte superior
          Image.asset(
            imagePath,
            height: 100, // Altura de la imagen
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          // Texto debajo de la imagen
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InicioScreen(),
  ));
}
