import 'package:flutter/material.dart';
import '../models/empresa.dart';
import '../database_helper.dart';

class AgregarEmpresaScreen extends StatefulWidget {
  @override
  _AgregarEmpresaScreenState createState() => _AgregarEmpresaScreenState();
}

class _AgregarEmpresaScreenState extends State<AgregarEmpresaScreen> {
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _logoController = TextEditingController();

  void _agregarEmpresa() async {
    final nombre = _nombreController.text.trim();
    final direccion = _direccionController.text.trim();
    final telefono = _telefonoController.text.trim();
    final logo = _logoController.text.trim();

    // Validación de campos obligatorios
    if (nombre.isEmpty || direccion.isEmpty || telefono.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos obligatorios')),
      );
      return;
    }

    // Creación de una nueva empresa
    final nuevaEmpresa = Empresa(
      nombre: nombre,
      direccion: direccion,
      telefono: telefono,
      logo: logo.isNotEmpty ? logo : null, // Logo es opcional
    );

    try {
      // Inserción en la base de datos
      await DatabaseHelper().insertEmpresa(nuevaEmpresa);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Empresa agregada exitosamente')),
      );
      Navigator.pop(context); // Vuelve a la pantalla anterior
    } catch (e) {
      print('Error al agregar empresa: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al agregar la empresa')),
      );
    }
  }

  @override
  void dispose() {
    // Limpieza de controladores
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Empresa'),
        backgroundColor: Colors.indigo, // Color del AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre de la Empresa'),
            ),
            TextField(
              controller: _direccionController,
              decoration: InputDecoration(labelText: 'Dirección'),
            ),
            TextField(
              controller: _telefonoController,
              decoration: InputDecoration(labelText: 'Teléfono'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _logoController,
              decoration: InputDecoration(labelText: 'URL del Logo (opcional)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarEmpresa,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Agregar Empresa',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
