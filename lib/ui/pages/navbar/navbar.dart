import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String item1;
  final String item2;
  final String ruta1;
  final String color2;

  const Navbar({super.key, 
    required this.item1,
    required this.item2,
    required this.ruta1,
    required this.color2, required String item3,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item1),
          Text(
            item2,
            style: TextStyle(
              color: color2 == 'activo' ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}