// Importa el paquete necesario de Flutter.
import 'package:flutter/material.dart';

// Definicion de la clase SearchBarrr, que extiende StatelessWidget.
class SearchBarrr extends StatelessWidget {
  // Constructor de la clase SearchBarrr.
  const SearchBarrr({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna un campo de texto con estilo de barra de busqueda.
    return TextFormField(
      decoration: InputDecoration(
        // Icono de busqueda como prefijo del campo de texto.
        prefixIcon: const Icon(Icons.search),
        // Texto de sugerencia en el campo de texto.
        hintText: "Search",
        // Relleno interno del campo de texto.
        contentPadding: const EdgeInsets.all(0),
        // Borde del campo de texto (sin borde).
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        // Color de fondo del campo de texto.
        fillColor: const Color.fromRGBO(220, 220, 220, 1),
        // Habilita el relleno del campo de texto.
        filled: true,
      ),
    );
  }
}
