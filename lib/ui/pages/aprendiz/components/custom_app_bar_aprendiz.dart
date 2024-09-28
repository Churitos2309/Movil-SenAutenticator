import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/services/auth_provider.dart';

class CustomAppBarAprendiz extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBarAprendiz({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF27A900), // Verde institucional
      shadowColor: const Color(0xFF27A900),
      title: Row(
        children: [
          const ImageIcon(
            AssetImage('images/login/LogoReconocimientoFacialBlanco.png'),
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navegar a la página de perfil al hacer clic en el avatar
                Navigator.pushNamed(context, '/profile');
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('images/login/LogoReconocimientoFacialBlanco.png'),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (String result) {
                switch (result) {
                  case 'Perfil':
                    Navigator.pushNamed(context, '/profile');
                    break;
                  case 'Configuraciones':
                    Navigator.pushNamed(context, '/settings');
                    break;
                  case 'Salir':
                    Provider.of<AuthProvider>(context, listen: false).logout();
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Perfil',
                  child: Text('Perfil'),
                ),
                const PopupMenuItem<String>(
                  value: 'Configuraciones',
                  child: Text('Configuraciones'),
                ),
                const PopupMenuItem<String>(
                  value: 'Salir',
                  child: Text('Salir'),
                ),
              ],
              icon: const Icon(Icons.arrow_drop_down), // Flechita para desplegar el menú
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}