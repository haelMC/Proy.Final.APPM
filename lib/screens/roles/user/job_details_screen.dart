import 'package:flutter/material.dart';
import 'package:appmovil/database_helper.dart';
import 'package:appmovil/models/trabajo.dart';
import 'package:appmovil/models/postulacion.dart';

class JobDetailsScreen extends StatelessWidget {
  final Trabajo trabajo;
  final int userId; // ID del usuario autenticado

  const JobDetailsScreen({required this.trabajo, required this.userId, Key? key}) : super(key: key);

  void _postularse(BuildContext context) async {
    final postulacion = Postulacion(
      trabajoId: trabajo.id!,
      userId: userId,
      fechaPostulacion: DateTime.now().toIso8601String(),
    );

    try {
      await DatabaseHelper().insertPostulacion(postulacion);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Postulación exitosa')),
      );
    } catch (e) {
      print('Error al postularse: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al postularse')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles del Trabajo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(trabajo.descripcion, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Salario: ${trabajo.salario}'),
            Text('Empresa: ${trabajo.empresaNombre ?? "Sin información"}'),
            Text('Categoría: ${trabajo.categoriaNombre ?? "Sin información"}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _postularse(context),
              child: Text('Postularse'),
            ),
          ],
        ),
      ),
    );
  }
}
