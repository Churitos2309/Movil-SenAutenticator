// Importa el paquete necesario de Flutter.
import 'package:flutter/material.dart';

// Definicion de la clase PostItem, que extiende StatelessWidget.
class PostItem extends StatelessWidget {
  // Variables miembro que contienen las imagenes de perfil y de la publicacion.
  final String profileImage;
  final String postImage;

  // Constructor de la clase PostItem.
  const PostItem({super.key, required this.profileImage, required this.postImage});

  @override
  Widget build(BuildContext context) {
    // Retorna una columna que representa una publicacion.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Encabezado de la publicación.
        Row(
          children: [
            // Contenedor que incluye el avatar de perfil.
            Container(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 14,
                backgroundImage: const AssetImage("images/story.jpeg"),
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage(profileImage),
                ),
              ),
            ),
            // Nombre del perfil.
            const Text('Profile Name'),
            // Espaciador para empujar los siguientes elementos hacia la derecha.
            const Spacer(),
            // Boton de opciones (tres puntos).
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        // Imagen de la publicación.
        Image.asset(postImage),
        // Pie de la publicación con iconos de interacción.
        Row(
          children: [
            // Boton de "Me gusta".
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
            ),
            // Boton de comentarios.
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline),
            ),
            // Boton para etiquetar.
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.label_outline),
            ),
            // Espaciador para empujar el siguiente boton hacia la derecha.
            const Spacer(),
            // Boton de guardar.
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_add_outlined),
            ),
          ],
        ),
        // Descripcion y comentarios de la publicacion.
        Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Texto con los nombres de los usuarios que han dado "Me gusta".
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: "LIKE BY"),
                    TextSpan(
                      text: " Profile Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " and"),
                    TextSpan(
                      text: " Others",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // Descripcion de la publicacion.
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: " Profile Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " This is the most amazing picture ever put on Instagram. This is also the best course ever made!",
                    ),
                  ],
                ),
              ),
              // Texto que indica la cantidad de comentarios.
              const Text(
                'View all 12 comments',
                style: TextStyle(color: Colors.black38),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
