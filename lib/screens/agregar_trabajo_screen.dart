import 'package:flutter/material.dart';
import '../models/trabajo.dart';
import '../models/empresa.dart';
import '../models/categoria.dart';
import '../database_helper.dart';

class AgregarTrabajoScreen extends StatefulWidget {
  @override
  _AgregarTrabajoScreenState createState() => _AgregarTrabajoScreenState();
}

class _AgregarTrabajoScreenState extends State<AgregarTrabajoScreen> {
  final _descripcionController = TextEditingController();
  final _imagenController = TextEditingController();
  final _salarioController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Empresa> _empresas = [];
  Empresa? _empresaSeleccionada;

  List<Categoria> _categorias = [];
  Categoria? _categoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    _cargarEmpresas();
    _cargarCategorias();
  }

  void _cargarEmpresas() async {
    final empresas = await _dbHelper.getEmpresas();
    setState(() {
      _empresas = empresas;
      _empresaSeleccionada = empresas.isNotEmpty ? empresas[0] : null;
    });
  }

  void _cargarCategorias() async {
    final categorias = await _dbHelper.getCategorias();
    setState(() {
      _categorias = categorias;
      _categoriaSeleccionada = categorias.isNotEmpty ? categorias[0] : null;
    });
  }

  void _agregarTrabajo() async {
    final descripcion = _descripcionController.text.trim();
    final imagen = _imagenController.text.trim();
    final salario = double.tryParse(_salarioController.text);

    if (descripcion.isEmpty || imagen.isEmpty || salario == null || _empresaSeleccionada == null || _categoriaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos correctamente')),
      );
      return;
    }

    final nuevoTrabajo = Trabajo(
      descripcion: descripcion,
      imagen: imagen,
      salario: salario,
      empresaId: _empresaSeleccionada!.id!,
      categoriaId: _categoriaSeleccionada!.id!, // Campo añadido aquí
    );


    try {
      await _dbHelper.insertTrabajo(nuevoTrabajo);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Trabajo agregado exitosamente')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error al agregar trabajo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al agregar el trabajo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Trabajo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción del Trabajo'),
            ),
            TextField(
              controller: _imagenController,
              decoration: InputDecoration(labelText: 'URL de la Imagen'),
            ),
            TextField(
              controller: _salarioController,
              decoration: InputDecoration(labelText: 'Salario'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            DropdownButton<Empresa>(
              value: _empresaSeleccionada,
              items: _empresas
                  .map((empresa) => DropdownMenuItem(
                value: empresa,
                child: Text(empresa.nombre),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _empresaSeleccionada = value;
                });
              },
              hint: Text('Seleccionar Empresa'),
            ),
            SizedBox(height: 10),
            DropdownButton<Categoria>(
              value: _categoriaSeleccionada,
              items: _categorias
                  .map((categoria) => DropdownMenuItem(
                value: categoria,
                child: Text(categoria.nombre),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _categoriaSeleccionada = value;
                });
              },
              hint: Text('Seleccionar Categoría'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarTrabajo,
              child: Text('Agregar Trabajo'),
            ),
          ],
        ),
      ),
    );
  }
}
