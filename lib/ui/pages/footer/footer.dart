import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
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