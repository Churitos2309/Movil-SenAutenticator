import 'package:flutter/material.dart';
import 'package:reconocimiento_app/services/api_services.dart';

class ReportesScreen extends StatefulWidget {
  const ReportesScreen({Key? key}) : super(key: key);

  @override
  _ReportesScreenState createState() => _ReportesScreenState();
}

class _ReportesScreenState extends State<ReportesScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> usuarios = [];

  String ficha = '';
  String documento = '';
  String tiempo = '';
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchUsuarios();
  }

  void fetchUsuarios() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final data = await apiService.get('usuario/');
      setState(() {
        usuarios = data;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error obteniendo usuarios: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 4.0, // Altura de la barra de progreso
            color: Colors.green, // Color de la barra de progreso
            width: isLoading ? MediaQuery.of(context).size.width : 0, // Solo visible cuando se está cargando
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildFilterInput('Fichas', (value) {
                          setState(() {
                            ficha = value;
                          });
                          fetchUsuarios();
                        }),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildFilterInput('Documentos', (value) {
                          setState(() {
                            documento = value;
                          });
                          fetchUsuarios();
                        }),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildFilterInput('Tiempo', (value) {
                          setState(() {
                            tiempo = value;
                          });
                          fetchUsuarios();
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: errorMessage.isNotEmpty
                        ? Center(child: Text(errorMessage))
                        : usuarios.isEmpty
                            ? Center(
                                child: Text('No hay datos disponibles',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[600])))
                            : GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Dos tarjetas por fila
                                  crossAxisSpacing: 16.0, // Espacio horizontal entre tarjetas
                                  mainAxisSpacing: 16.0, // Espacio vertical entre tarjetas
                                  childAspectRatio: 1.0, // Relación de aspecto de cada tarjeta
                                ),
                                itemCount: usuarios.length,
                                itemBuilder: (context, index) {
                                  return _buildUserCard(usuarios[index]);
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(dynamic usuario) {
    return Card(
      margin: EdgeInsets.zero, // Sin margen adicional
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfoRow('ID:', usuario['id'].toString()),
            _buildUserInfoRow('Nombre:', usuario['first_name'] ?? 'N/A'),
            _buildUserInfoRow('Fecha:', usuario['date_joined'] ?? 'N/A'),
            _buildUserInfoRow(
              'Estado:',
              (usuario['is_active'] ?? false) ? 'Activo' : 'Inactivo',
              color: (usuario['is_active'] ?? false)
                  ? Colors.black
                  : Colors.red[800],
            ),
            _buildUserInfoRow('Documentos:', usuario['numero_documento_usuario'] ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color ?? Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterInput(String label, Function(String) onChanged) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey[600] ?? Colors.grey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey[600] ?? Colors.grey, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      ),
      cursorColor: Colors.grey[600],
    );
  }
}
