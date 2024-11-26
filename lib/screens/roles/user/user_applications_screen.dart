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
    try {
      final postulaciones = await _dbHelper.getPostulacionesByUserId(widget.userId);
      setState(() {
        _postulaciones = postulaciones;
      });
    } catch (e) {
      print('Error cargando postulaciones: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Postulaciones'),
        backgroundColor: Colors.blueAccent, // Cambia el color del AppBar si lo deseas
      ),
      body: _postulaciones.isEmpty
          ? Center(
        child: Text(
          'No tienes postulaciones aún.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        itemCount: _postulaciones.length,
        itemBuilder: (context, index) {
          final postulacion = _postulaciones[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                'Trabajo ID: ${postulacion.trabajoId}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text('Fecha: ${postulacion.fechaPostulacion}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  // Mostrar el estado "Pendiente" para cada postulación
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Pendiente',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
