import 'package:flutter/material.dart';
import '../models/empresa.dart';
import '../database_helper.dart';

class EditarEmpresaScreen extends StatefulWidget {
  final Empresa empresa;

  const EditarEmpresaScreen({Key? key, required this.empresa}) : super(key: key);

  @override
  _EditarEmpresaScreenState createState() => _EditarEmpresaScreenState();
}

class _EditarEmpresaScreenState extends State<EditarEmpresaScreen> {
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _logoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los datos actuales de la empresa
    _nombreController.text = widget.empresa.nombre;
    _direccionController.text = widget.empresa.direccion;
    _telefonoController.text = widget.empresa.telefono;
    _logoController.text = widget.empresa.logo ?? '';
  }

  void _guardarCambios() async {
    final nombre = _nombreController.text.trim();
    final direccion = _direccionController.text.trim();
    final telefono = _telefonoController.text.trim();
    final logo = _logoController.text.trim();

    if (nombre.isEmpty || direccion.isEmpty || telefono.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos requeridos')),
      );
      return;
    }

    final empresaActualizada = Empresa(
      id: widget.empresa.id,
      nombre: nombre,
      direccion: direccion,
      telefono: telefono,
      logo: logo.isNotEmpty ? logo : null,
    );

    try {
      await DatabaseHelper().updateEmpresa(empresaActualizada);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Empresa actualizada exitosamente')),
      );
      Navigator.pop(context); // Vuelve a la pantalla anterior
    } catch (e) {
      print('Error al actualizar empresa: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar la empresa')),
      );
    }
  }

  @override
  void dispose() {
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
        title: Text('Editar Empresa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre de la Empresa'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _direccionController,
                decoration: InputDecoration(labelText: 'Dirección'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _telefonoController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _logoController,
                decoration: InputDecoration(labelText: 'URL del Logo (Opcional)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarCambios,
                child: Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
