import 'package:flutter/material.dart';
import '../models/categoria.dart';
import '../database_helper.dart';
import 'editar_categoria_screen.dart';

class ListaCategoriasScreen extends StatefulWidget {
  @override
  _ListaCategoriasScreenState createState() => _ListaCategoriasScreenState();
}

class _ListaCategoriasScreenState extends State<ListaCategoriasScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<List<Categoria>> _categorias;

  @override
  void initState() {
    super.initState();
    _cargarCategorias();
  }

  void _cargarCategorias() {
    setState(() {
      _categorias = _dbHelper.getCategorias();
    });
  }

  void _eliminarCategoria(int id) async {
    await _dbHelper.deleteCategoria(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Categoría eliminada')),
    );
    _cargarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Categorías'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Categoria>>(
        future: _categorias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar las categorías'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay categorías disponibles'));
          }

          final categorias = snapshot.data!;
          return ListView.builder(
            itemCount: categorias.length,
            itemBuilder: (context, index) {
              final categoria = categorias[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(categoria.nombre),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditarCategoriaScreen(categoria: categoria),
                            ),
                          ).then((_) => _cargarCategorias());
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _eliminarCategoria(categoria.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
