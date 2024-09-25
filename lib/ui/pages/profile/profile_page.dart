import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = true;
  Map<String, dynamic>? _profileData;

  // Inicializa el ID del usuario aquí o pásalo como parámetro

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      var data = await ApiService().getProfile('usuario/');
      setState(() {
        _profileData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar el perfil: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              // Navegar a la página de edición de perfil
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _profileData == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No se encontraron datos del perfil', style: TextStyle(fontSize: 18, color: Colors.redAccent)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchProfileData,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileItem('Nombre de usuario', _profileData!['username']),
                          _buildProfileItem('Nombre', _profileData!['first_name']),
                          _buildProfileItem('Apellido', _profileData!['last_name']),
                          _buildProfileItem('Correo electrónico', _profileData!['email']),
                          _buildProfileItem('Tipo de documento', _profileData!['tipo_documento_usuario']),
                          _buildProfileItem('Número de documento', _profileData!['numero_documento_usuario']),
                          _buildProfileItem('Género', _profileData!['genero_usuario']),
                          _buildProfileItem('Rol', _profileData!['rol_usuario']),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget _buildProfileItem(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.person, color: Colors.teal),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title:',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  value?.toString() ?? 'No disponible',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
