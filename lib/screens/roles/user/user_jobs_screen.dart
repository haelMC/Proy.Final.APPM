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
      body: _trabajos.isEmpty
          ? Center(
        child: Text(
          'No hay ofertas disponibles en este momento.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        itemCount: _trabajos.length,
        itemBuilder: (context, index) {
          final trabajo = _trabajos[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(trabajo.descripcion),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Salario: ${trabajo.salario.toStringAsFixed(2)}'),
                  Text(
                      'Empresa: ${trabajo.empresaNombre ?? "Sin información"}'),
                  Text(
                      'Categoría: ${trabajo.categoriaNombre ?? "Sin información"}'),
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
    );
  }
}
