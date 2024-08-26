import 'package:flutter/material.dart';
import 'package:reconocimiento_app/models/user_model.dart';
import 'package:reconocimiento_app/services/user_services.dart';
import 'package:reconocimiento_app/ui/pages/navbar/navbar.dart';

class ReportesInstructor extends StatefulWidget {
  const ReportesInstructor({super.key});

  @override
  _ReportesInstructorState createState() => _ReportesInstructorState();
}

class _ReportesInstructorState extends State<ReportesInstructor> {
  final UserService userService = UserService();

  List<User> usuarios = [];
  List<User> datosFiltrados = [];

  bool loading = true;

  String? error;
  String documentoFiltro = "";

  @override
  void initState() {
    super.initState();
    recibirUsuarios();
  }

  Future<void> recibirUsuarios() async {
    try {
      final data = await userService.fetchUsersByRole('Instructor');
      setState(() {
        usuarios = data;
        datosFiltrados = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  void filtrarDatos(String filtro) {
    setState(() {
      documentoFiltro = filtro;
      if (documentoFiltro.isNotEmpty) {
        datosFiltrados = usuarios.where((usuario) {
          return usuario.numeroDocumento.contains(documentoFiltro);
        }).toList();
      } else {
        datosFiltrados = usuarios;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Reportes Instructor'),
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Navbar(
          item1: 'inicio',
          item2: 'Reportes',
          ruta1: '/inicioInstructor',
          color2: 'activo',
          item3: '',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButton<String>(
                      items: const [
                        DropdownMenuItem(
                            value: "2669742", child: Text("2669742")),
                        DropdownMenuItem(
                            value: "2669756", child: Text("2669756")),
                        DropdownMenuItem(
                            value: "2669723", child: Text("2669723")),
                      ],
                      onChanged: (value) {},
                      hint: const Text("Seleccione un documento"),
                      isExpanded: true,
                      underline: const SizedBox(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '# Documento',
                    ),
                    onChanged: filtrarDatos,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: DropdownButton<String>(
                      items: const [
                        DropdownMenuItem(value: "Mañana", child: Text("Mañana")),
                        DropdownMenuItem(value: "Tarde", child: Text("Tarde")),
                        DropdownMenuItem(value: "Noche", child: Text("Noche")),
                      ],
                      onChanged: (value) {},
                      hint: const Text("Seleccione jornada"),
                      isExpanded: true,
                      underline: const SizedBox(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButton<String>(
                      items: const [
                        DropdownMenuItem(value: "Hoy", child: Text("Hoy")),
                        DropdownMenuItem(
                            value: "Semanal", child: Text("Semanal")),
                        DropdownMenuItem(
                            value: "Mensual", child: Text("Mensual")),
                      ],
                      onChanged: (value) {},
                      hint: const Text("Seleccione fecha"),
                      isExpanded: true,
                      underline: const SizedBox(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ReportesGraficas');
                  },
                  child: const Text('Graficas'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    '10/${usuarios.length}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text('Ingresos', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (loading)
              const Center(child: CircularProgressIndicator())
            else if (error != null)
              Center(child: Text('Error: $error'))
            else
              SizedBox(
                height: 400,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: datosFiltrados.length,
                    itemBuilder: (context, index) {
                      final usuario = datosFiltrados[index];
                      return
                          // Expanded(
                          //   child: SingleChildScrollView(
                          //     scrollDirection: Axis.horizontal,
                          //     child:
                          Table(
                        columnWidths: const {
                          0: FlexColumnWidth(4),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(3),
                          3: FlexColumnWidth(2),
                          4: FlexColumnWidth(2),
                          5: FlexColumnWidth(2),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              // border: Border.all(color: Colors.grey[400]!),
                              // border: Border.all(style: BorderStyle.solid)
                              // borderRadius: BorderRadius.circular(10),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  '${usuario.firstName} ${usuario.lastName}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  usuario.genero,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  usuario.numeroDocumento,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  usuario.genero,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  usuario.rol,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                          // title: Text('${usuario.firstName} ${usuario.lastName}'),
                          // subtitle: Text(usuario.numeroDocumento),
                          // trailing: const Icon(Icons.check, color: Colors.green),
                        ],
                      );
                      // ),
                      // );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
