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
        SnackBar(content: Text('¡Postulación exitosa!')),
      );
    } catch (e) {
      print('Error al postularse: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al postularse. Por favor, inténtalo nuevamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Trabajo'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con descripción destacada
            Text(
              trabajo.descripcion,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: 20),

            // Contenedor estilizado para los detalles
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Salario: ${trabajo.salario.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.business, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Empresa: ${trabajo.empresaNombre ?? "Sin información"}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.category, color: Colors.blue, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Categoría: ${trabajo.categoriaNombre ?? "Sin información"}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Botón de postulación
            Center(
              child: ElevatedButton(
                onPressed: () => _postularse(context),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Postularse',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
