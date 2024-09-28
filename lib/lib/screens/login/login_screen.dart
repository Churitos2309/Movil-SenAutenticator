import 'package:flutter/material.dart';
import 'package:reconocimiento_app/lib/screens/login/login_form.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required ApiService apiService});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding( 
          padding: EdgeInsets.all(20.0),
          child: LoginForm()
        ),
      ),
    );
  }
}
