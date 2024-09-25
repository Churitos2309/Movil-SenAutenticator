import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            'Footer',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}