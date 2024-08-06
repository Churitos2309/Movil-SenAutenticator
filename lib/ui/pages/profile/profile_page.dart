import 'package:flutter/material.dart';
import 'package:reconocimiento_app/ui/pages/profile/card_carnet.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      body: const CardCarnet()
    );
  }
}
