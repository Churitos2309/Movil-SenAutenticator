// Importa los paquetes necesarios de Flutter.
import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/search/category_buttons.dart';
import 'package:reconocimiento_app/ui/pages/search/search_bar.dart';

// Definicion de la clase SearchPage, que extiende StatelessWidget.
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Cuerpo de la pagina con desplazamiento personalizado.
      body: CustomScrollView(
        slivers: [
          // Barra de aplicación deslizante para la barra de busqueda.
          SliverAppBar(
            // Título de la barra de aplicación con el widget SearchBarrr.
            title: const SearchBarrr(),
            // Acciones de la barra de aplicacion (icono de agregar persona).
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_add),
              )
            ],
          ),
          // Barra de aplicacion deslizante para los botones de categoria.
          const SliverAppBar(
            // Titulo de la barra de aplicacion con el widget CategoryButtons.
            title: CategoryButtons(),
          ),
        ],
      ),
    );
  }
}
