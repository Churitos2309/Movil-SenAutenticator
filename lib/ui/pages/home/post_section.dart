// Importa el paquete necesario de Flutter.
import 'package:flutter/material.dart';
// Importa el componente PostItem.
import 'post_item.dart';

// Definicion de la clase PostSection, que extiende StatelessWidget.
class PostSection extends StatelessWidget {
  const PostSection({super.key});

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

    // Lista de imagenes de publicaciones.
    List<String> posts = [
      "images/post_1.jpeg",
      "images/post_2.jpeg",
      "images/post_3.jpeg",
      "images/post_4.jpeg",
      "images/post_5.jpeg",
      "images/post_6.jpeg",
      "images/post_7.jpeg",
      "images/post_8.jpeg",
    ];

    // Retorna una columna con las publicaciones.
    return Column(
      // Genera una lista de widgets PostItem a partir de las listas de imagenes.
      children: List.generate(
        // Numero de publicaciones que se generaran.
        8,
        // Funcion que crea un PostItem para cada Indice de la lista.
        (index) => PostItem(
          profileImage: profileImages[index],
          postImage: posts[index],
        ),
      ),
    );
  }
}
