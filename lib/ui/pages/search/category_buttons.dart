// Importa el paquete necesario de Flutter.
import 'package:flutter/material.dart';

// Definicion de la clase CategoryButtons, que extiende StatelessWidget.
class CategoryButtons extends StatelessWidget {
  // Constructor de la clase CategoryButtons.
  const CategoryButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de nombres de las categorias de botones.
    List<String> buttons = [
      "IGTV",
      "Travel",
      "Arquitecture",
      "Decor",
      "Style",
      "Food",
      "Art",
      "Beauty",
      "DIY",
      "Music",
    ];

    // Retorna un SingleChildScrollView con botones de categoría.
    return SingleChildScrollView(
      // Establece la direccion del desplazamiento del SingleChildScrollView.
      scrollDirection: Axis.horizontal,
      child: Row(
        // Crea una fila de botones utilizando List.generate.
        children: List.generate(
          // Genera 10 botones con los nombres de las categorias.
          10,
          (index) => Container(
            // Agrega un espacio horizontal alrededor de los botones.
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: OutlinedButton(
              // Asigna una funcion vacía a onPressed (no realiza ninguna accion).
              onPressed: () {},
              // Establece el texto del botón como el nombre de la categoria correspondiente.
              child: Text(buttons[index]),
            ),
          ),
        ),
      ),
    );
  }
}
