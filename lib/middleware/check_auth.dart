import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _checkAuth(BuildContext context, String route)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('token')) {
    Navigator.pushReplacementNamed(context, '/login');
  }else {
    Navigator.pushNamed(context, route);
  }

}