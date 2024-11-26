import 'package:flutter/material.dart';
import 'package:appmovil/models/trabajo.dart';
import 'package:appmovil/database_helper.dart';

class GuestHomeScreen extends StatefulWidget {
  @override
  _GuestHomeScreenState createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> {
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
      backgroundColor: Colors.blueAccent, // Fondo azul
      appBar: AppBar(
        title: Text(
          'Vista de Invitado',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Texto de bienvenida
            Text(
              "Ofertas Disponibles",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Lista de trabajos
            Expanded(
              child: _trabajos.isEmpty
                  ? Center(
                child: Text(
                  'No hay ofertas disponibles en este momento.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
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
                        Icons.work, // Icono de trabajo
                        color: Colors.blue, // Color del ícono
                        size: 40, // Tamaño del ícono
                      ),
                      title: Text(
                        trabajo.descripcion,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Salario: ${trabajo.salario.toStringAsFixed(2)}'),
                          Text('Empresa: ${trabajo.empresaNombre ?? "Sin información"}'),
                          Text('Categoría: ${trabajo.categoriaNombre ?? "Sin información"}'),
                        ],
                      ),
                      trailing: Icon(
                        Icons.info_outline, // Icono informativo
                        color: Colors.grey, // Color del ícono
                        size: 24, // Tamaño del ícono
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
