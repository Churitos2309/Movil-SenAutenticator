import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  final FocusNode _numeroIdentificacionFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _nombreFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  final TextEditingController _numeroIdentificacionController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Color _numeroIdentificacionTextColor = Colors.grey;
  Color _passwordTextColor = Colors.grey;
  Color _confirmPasswordTextColor = Colors.grey;
  Color _nombreTextColor = Colors.grey;
  Color _emailTextColor = Colors.grey;

  String _selectedTipoDocumento = 'Cedula de ciudadania';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _numeroIdentificacionFocusNode.addListener(_onNumeroIdentificacionFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
    _confirmPasswordFocusNode.addListener(_onConfirmPasswordFocusChange);
    _nombreFocusNode.addListener(_onNombreFocusChange);
    _emailFocusNode.addListener(_onEmailFocusChange);
  }

  @override
  void dispose() {
    _numeroIdentificacionFocusNode.removeListener(_onNumeroIdentificacionFocusChange);
    _passwordFocusNode.removeListener(_onPasswordFocusChange);
    _confirmPasswordFocusNode.removeListener(_onConfirmPasswordFocusChange);
    _nombreFocusNode.removeListener(_onNombreFocusChange);
    _emailFocusNode.removeListener(_onEmailFocusChange);

    _numeroIdentificacionFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _nombreFocusNode.dispose();
    _emailFocusNode.dispose();

    _numeroIdentificacionController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nombreController.dispose();
    _emailController.dispose();
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

  void _onConfirmPasswordFocusChange() {
    setState(() {
      _confirmPasswordTextColor = _confirmPasswordFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  void _onNombreFocusChange() {
    setState(() {
      _nombreTextColor = _nombreFocusNode.hasFocus ? const Color.fromARGB(255, 76, 175, 80) : Colors.grey;
    });
  }

  void _onEmailFocusChange() {
    setState(() {
      _emailTextColor = _emailFocusNode.hasFocus ? Colors.green : Colors.grey;
    });
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim();
    final nombre = _nombreController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final selectedTipoDocumento = _selectedTipoDocumento;
    final numeroIdentificacion = _numeroIdentificacionController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Las contraseñas no coinciden"),
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final requestData = {
        'first_name': nombre,
        'email': email,
        'password': password,
        'tipo_documento_usuario': selectedTipoDocumento,
        'numero_documento_usuario': numeroIdentificacion,
        'username': numeroIdentificacion,
      };

      // final responseData = await apiService.post('usuario/');


      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );

      Navigator.pushNamed(context, '/vistaLogin');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: $e')),
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
                      "Regístrate para continuar..",
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      focusNode: _nombreFocusNode,
                      controller: _nombreController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        labelStyle: TextStyle(color: _nombreTextColor),
                        prefixIcon: Icon(Icons.person, color: _nombreTextColor),
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
                          return 'Por favor, ingrese su nombre';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo Electrónico',
                        labelStyle: TextStyle(color: _emailTextColor),
                        prefixIcon: Icon(Icons.email, color: _emailTextColor),
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
                          return 'Por favor, ingrese su correo electrónico';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: _selectedTipoDocumento,
                      decoration: InputDecoration(
                        labelText: 'Tipo de Documento',
                        labelStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(Icons.document_scanner, color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: <String>[
                        'Cedula de ciudadania',
                        'Tarjeta de identidad',
                        'Cedula de extranjeria',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTipoDocumento = newValue!;
                        });
                      },
                      style: const TextStyle(color: Colors.grey),
                      dropdownColor: Colors.grey[700],
                      iconEnabledColor: Colors.green,
                      


                    ),
                    const SizedBox(height: 15),
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
                    const SizedBox(height: 15),
                    TextFormField(
                      focusNode: _confirmPasswordFocusNode,
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirmar Contraseña',
                        labelStyle: TextStyle(color: _confirmPasswordTextColor),
                        prefixIcon: Icon(Icons.lock, color: _confirmPasswordTextColor),
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
                          return 'Por favor, confirme su contraseña';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _register,
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
                            : const Text("Registrarse"),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "O regístrate con ",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "¿Ya tienes una cuenta?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/vistaLogin');
                          },
                          child: const Text(
                            "Inicia sesión",
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