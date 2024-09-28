import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconocimiento_app/lib/screens/login/login_controller.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);

    return SingleChildScrollView(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Image.asset(
                  'images/login/LogoReconocimientoFacialBlanco.png',
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Bienvenido a SENAuthenticator",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Iniciar sesión para continuar..",
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              TextFormField(
                key: const Key('identificacionInput'),
                focusNode:  loginController.numeroIdentificacionFocusNode,
                controller: loginController.numeroIdentificacionController,
                decoration: InputDecoration(
                  labelText: 'Cédula',
                  labelStyle: TextStyle(color: loginController.numeroIdentificacionTextColor),
                  prefixIcon:
                      Icon(Icons.email, color: loginController.numeroIdentificacionTextColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su numero de cédula';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                key: const Key('passwordInput'),
                focusNode: loginController.passwordFocusNode,
                controller: loginController.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: loginController.passwordTextColor),
                  prefixIcon: Icon(Icons.lock, color: loginController.passwordTextColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                  loginController.login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),  
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: loginController.isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Iniciar sesión"),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "O inicie con ",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "¿No tienes una cuenta?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registro');
                      },
                      child: const Text(
                        "Regístrate",
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
