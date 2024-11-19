import 'package:flutter/material.dart';
import '../models/trabajo.dart';
import '../database_helper.dart';
import 'editar_trabajo_screen.dart';

class ListaTrabajosScreen extends StatefulWidget {
  @override
  _ListaTrabajosScreenState createState() => _ListaTrabajosScreenState();
}

class _ListaTrabajosScreenState extends State<ListaTrabajosScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<List<Trabajo>> _trabajos;

  @override
  void initState() {
    super.initState();
    _cargarTrabajos();
  }

  void _cargarTrabajos() {
    setState(() {
      _trabajos = _dbHelper.getTrabajos();
    });
  }

  void _eliminarTrabajo(int id) async {
    await _dbHelper.deleteTrabajo(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Trabajo eliminado',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
    _cargarTrabajos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Trabajos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF003B73),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<Trabajo>>(
          future: _trabajos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error al cargar los trabajos',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No hay trabajos disponibles',
                  style: TextStyle(fontSize: 16, color: Color(0xFF003B73)),
                ),
              );
            }

            final trabajos = snapshot.data!;
            return ListView.builder(
              itemCount: trabajos.length,
              itemBuilder: (context, index) {
                final trabajo = trabajos[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      trabajo.descripcion,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Salario: ${trabajo.salario}',
                          style: TextStyle(color: Color(0xFF0074B7)),
                        ),
                        Text(
                          'Empresa: ${trabajo.empresaNombre ?? 'Sin empresa'}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(
                          'Categoría: ${trabajo.categoriaNombre ?? 'Sin categoría'}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditarTrabajoScreen(trabajo: trabajo),
                              ),
                            ).then((_) => _cargarTrabajos());
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _eliminarTrabajo(trabajo.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
