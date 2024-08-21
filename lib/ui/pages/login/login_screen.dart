import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  final FocusNode _numeroIdentificacionFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _numeroIdentificacionController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Color _numeroIdentificacionTextColor = Colors.grey;
  Color _passwordTextColor = Colors.grey;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _numeroIdentificacionFocusNode.addListener(_onNumeroIdentificacionFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
  }

  @override
  void dispose() {
    _numeroIdentificacionFocusNode.removeListener(_onNumeroIdentificacionFocusChange);
    _passwordFocusNode.removeListener(_onPasswordFocusChange);

    _numeroIdentificacionFocusNode.dispose();
    _passwordFocusNode.dispose();
    _numeroIdentificacionController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onNumeroIdentificacionFocusChange() {
    setState(() {
      _numeroIdentificacionTextColor = _numeroIdentificacionFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  void _onPasswordFocusChange() {
    setState(() {
      _passwordTextColor = _passwordFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  Future<void> _login() async {
    final numeroIdentificacion = _numeroIdentificacionController.text.trim();
    final password = _passwordController.text.trim();

    if (numeroIdentificacion.isEmpty && password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por favor, ingrese un correo electrónico y contraseña"),
      ));
      return;
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por favor, ingrese la contraseña"),
      ));
      return;
    } else if (numeroIdentificacion.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por favor, ingrese un correo electrónico y contraseña"),
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final responseData = await apiService.post('inicioSesion/', {
        'numero_documento_usuario': numeroIdentificacion,
        'password': password,
      });

      final token = responseData['token'];
      final user = responseData['user'];

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login exitoso')),
      );

      final rolUsuario = user['rol_usuario'];
      if (rolUsuario == 'Aprendiz') {
        Navigator.pushNamed(context, '/paginaAprendiz');
      } else if (rolUsuario == 'Instructor') {
        Navigator.pushNamed(context, '/paginaInstructor');
      } else if (rolUsuario == 'Administrador') {
        Navigator.pushNamed(context, '/paginaAdministrador');
      } else if (rolUsuario == 'Funcionario') {
        Navigator.pushNamed(context, '/paginaFuncionario');
      } else if (rolUsuario == 'Guardia de seguridad') {
        Navigator.pushNamed(context, '/paginaGuardia');
      } else {
        Navigator.pushNamed(context, '/paginaUsuario');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/login/LogoReconocimientoFacialBlanco.png',
                      width: 100,
                      height: 100,
                      color: Colors.green,
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
                      focusNode: _numeroIdentificacionFocusNode,
                      controller: _numeroIdentificacionController,
                      decoration: InputDecoration(
                        labelText: 'Cédula o Correo',
                        labelStyle: TextStyle(color: _numeroIdentificacionTextColor),
                        prefixIcon: Icon(Icons.email, color: _numeroIdentificacionTextColor),
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
                          return 'Por favor, ingrese su cédula o correo electrónico';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: _passwordTextColor),
                        prefixIcon: Icon(Icons.lock, color: _passwordTextColor),
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
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Iniciar sesión"),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "O inicie con ",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}