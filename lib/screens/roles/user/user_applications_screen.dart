import 'package:flutter/material.dart';
import 'package:appmovil/database_helper.dart';
import 'package:appmovil/models/postulacion.dart';

class UserApplicationsScreen extends StatefulWidget {
  final int userId;

  UserApplicationsScreen({required this.userId});

  @override
  _UserApplicationsScreenState createState() => _UserApplicationsScreenState();
}

class _UserApplicationsScreenState extends State<UserApplicationsScreen> {
  List<Postulacion> _postulaciones = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _cargarPostulaciones();
  }

  Future<void> _cargarPostulaciones() async {
    final postulaciones = await _dbHelper.getPostulacionesByUserId(widget.userId);
    setState(() {
      _postulaciones = postulaciones;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Postulaciones'),
      ),
      body: _postulaciones.isEmpty
          ? Center(
        child: Text(
          'No tienes postulaciones aún.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: _postulaciones.length,
        itemBuilder: (context, index) {
          final postulacion = _postulaciones[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(postulacion.trabajoId.toString()), // Muestra el ID del trabajo
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fecha: ${postulacion.fechaPostulacion}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
