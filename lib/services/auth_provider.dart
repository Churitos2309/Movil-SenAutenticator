class AuthProvider {
  bool isAuthenticated = true;

  // Simulación de una función para obtener todos los usuarios
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    // Aquí iría la lógica para obtener los usuarios, por ejemplo, una llamada a una API
    await Future.delayed(const Duration(seconds: 2)); // Simulación de tiempo de espera
    return [
      {
        'first_name': 'Juan',
        'tipo_documento_usuario': 'CC',
        'numero_documento_usuario': '123456789',
      },
      {
        'first_name': 'Maria',
        'tipo_documento_usuario': 'TI',
        'numero_documento_usuario': '987654321',
      },
    ];
  }
}