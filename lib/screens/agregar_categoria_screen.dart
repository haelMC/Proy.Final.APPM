import 'package:flutter/material.dart';
import '../models/categoria.dart';
import '../database_helper.dart';

class AgregarCategoriaScreen extends StatefulWidget {
  @override
  _AgregarCategoriaScreenState createState() => _AgregarCategoriaScreenState();
}

class _AgregarCategoriaScreenState extends State<AgregarCategoriaScreen> {
  final _nombreController = TextEditingController();

  void _agregarCategoria() async {
    final nombre = _nombreController.text.trim();

    // Validar que el campo no esté vacío
    if (nombre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El nombre de la categoría no puede estar vacío')),
      );
      return;
    }

    final nuevaCategoria = Categoria(nombre: nombre);

    try {
      await DatabaseHelper().insertCategoria(nuevaCategoria);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Categoría agregada exitosamente')),
      );
      Navigator.pop(context); // Volver a la pantalla anterior
    } catch (e) {
      print('Error al agregar categoría: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al agregar la categoría')),
      );
    }
  }


  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Categoría')),
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
              onPressed: _agregarCategoria,
              child: Text('Agregar Categoría'),
            ),
          ],
        ),
      ),
    );
  }
}
