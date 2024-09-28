import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/lib/screens/login/login_screen.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'package:reconocimiento_app/services/auth_provider.dart';
import 'package:reconocimiento_app/ui/pages/home_page.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return FutureBuilder(
          future: authProvider.checkAuth(), // Llama a checkAuth
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return authProvider.isLoggedIn
                  ? const HomePage() // Página para usuario autenticado
                  : LoginScreen(apiService: ApiService()); // Página de login
            }
          },
        );
      },
    );
  }
}
