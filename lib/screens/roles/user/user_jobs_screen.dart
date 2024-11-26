import 'package:flutter/material.dart';
import 'package:appmovil/models/trabajo.dart';
import 'package:appmovil/database_helper.dart';
import 'package:appmovil/screens/roles/user/job_details_screen.dart';

class UserJobsScreen extends StatefulWidget {
  final int userId; // ID del usuario

  const UserJobsScreen({required this.userId, Key? key}) : super(key: key);

  @override
  _UserJobsScreenState createState() => _UserJobsScreenState();
}

class _UserJobsScreenState extends State<UserJobsScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Trabajo> _trabajos = [];

  @override
  void initState() {
    super.initState();
    _cargarTrabajos();
  }

  Future<void> _cargarTrabajos() async {
    final trabajos = await _dbHelper.getTrabajos(); // Obtiene todos los trabajos de la base de datos
    setState(() {
      _trabajos = trabajos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ofertas Disponibles'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Descripción inspiradora
          Container(
            color: Colors.blue[100],
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "¡Encuentra tu próximo destino profesional!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Aquí podrás explorar las mejores ofertas de trabajo y dar el primer paso hacia el empleo de tus sueños. No esperes más, revisa las oportunidades disponibles y postula para comenzar una nueva etapa llena de éxito y crecimiento profesional.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
          Expanded(
            child: _trabajos.isEmpty
                ? Center(
              child: Text(
                'No hay ofertas disponibles en este momento.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : ListView.builder(
              itemCount: _trabajos.length,
              itemBuilder: (context, index) {
                final trabajo = _trabajos[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      Icons.work, // Icono para representar el trabajo
                      color: Colors.blueAccent,
                      size: 40,
                    ),
                    title: Text(
                      trabajo.descripcion,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money, // Icono de moneda
                              color: Colors.green,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${trabajo.salario.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.business, // Icono de empresa
                              color: Colors.orange,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                trabajo.empresaNombre ?? "Sin información",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.category, // Icono de categoría
                              color: Colors.blue,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                trabajo.categoriaNombre ?? "Sin información",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      // Mostrar detalles del trabajo al presionar
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetailsScreen(
                            trabajo: trabajo,
                            userId: widget.userId, // Pasar el userId
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
