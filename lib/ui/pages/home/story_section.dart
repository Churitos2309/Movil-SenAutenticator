// Importa el paquete necesario de Flutter.
import 'package:flutter/material.dart';

// Definicion de la clase StorySection, que extiende StatelessWidget.
class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de imagenes de perfil.
    List<String> profileImages = [
      "images/1.jpg",
      "images/2.jpeg",
      "images/3.jpeg",
      "images/4.jpeg",
      "images/5.jpeg",
      "images/6.jpeg",
      "images/7.jpeg",
      "images/8.jpeg",
    ];

    // Retorna un SingleChildScrollView horizontal para las historias.
    return SingleChildScrollView(
      // Desplazamiento horizontal.
      scrollDirection: Axis.horizontal,
      child: Row(
        // Genera una lista de widgets a partir de las imágenes de perfil.
        children: List.generate(
          // Numero de historias a mostrar.
          8,
          // Funcion que crea un widget para cada historia.
          (index) => Container(
            // Espaciado alrededor de cada historia.
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // Imagen de perfil en un circulo.
                CircleAvatar(
                  // Radio externo del circulo.
                  radius: 35,
                  // Imagen de fondo del circulo externo.
                  backgroundImage: const AssetImage("images/story.jpeg"),
                  // Circulo interno con la imagen de perfil.
                  child: CircleAvatar(
                    // Radio del circulo interno.
                    radius: 32,
                    // Imagen de perfil.
                    backgroundImage: AssetImage(profileImages[index]),
                  ),
                ),
                const SizedBox(height: 10),
                // Nombre del perfil.
                const Text(
                  "profile name",
                  // Estilo del texto del nombre de perfil.
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
