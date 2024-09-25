import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Back',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black
          ),
        ),
        actions: [
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('images/story.jpeg'), // Tu imagen de fondo
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.1,
                left: screenWidth * 0.5 - 50,
                child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('images/1.jpg'),
                    // backgroundImage: NetworkImage('https://example.com/profile.jpg'), // Tu imagen de perfil
                  ),
                ),
              ),
              Positioned(
                top: 160,
                left: 20,
                child: Center(
                  child: Text(
                    'Juan Ochoa',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit Profile'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.bar_chart),
                  title: const Text('My Stats'),
                  onTap: () {},
                ),
                // Agrega más ListTiles aquí
              ],
            ),
          ),
        ],
      ),
    );
  }
}
