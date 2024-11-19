import 'package:flutter/material.dart';
import '../models/categoria.dart';
import '../database_helper.dart';

class EditarCategoriaScreen extends StatefulWidget {
  final Categoria categoria;

  EditarCategoriaScreen({required this.categoria});

  @override
  _EditarCategoriaScreenState createState() => _EditarCategoriaScreenState();
}

class _EditarCategoriaScreenState extends State<EditarCategoriaScreen> {
  final _nombreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nombreController.text = widget.categoria.nombre;
  }

  void _guardarCambios() async {
    final nombre = _nombreController.text.trim();
    if (nombre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingresa un nombre para la categoría')),
      );
      return;
    }

    final categoriaActualizada = Categoria(
      id: widget.categoria.id,
      nombre: nombre,
    );
    await DatabaseHelper().updateCategoria(categoriaActualizada);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Categoría')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre de la Categoría'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarCambios,
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
