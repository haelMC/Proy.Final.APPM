import 'package:flutter/material.dart';
import 'package:appmovil/models/trabajo.dart';
import 'package:appmovil/models/categoria.dart';
import 'package:appmovil/database_helper.dart';


class AgregarTrabajoEmpresaScreen extends StatefulWidget {
  final int empresaId; // ID de la empresa que crea el trabajo

  const AgregarTrabajoEmpresaScreen({required this.empresaId, Key? key}) : super(key: key);

  @override
  _AgregarTrabajoEmpresaScreenState createState() => _AgregarTrabajoEmpresaScreenState();
}

class _AgregarTrabajoEmpresaScreenState extends State<AgregarTrabajoEmpresaScreen> {
  final _descripcionController = TextEditingController();
  final _imagenController = TextEditingController();
  final _salarioController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Categoria> _categorias = [];
  Categoria? _categoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    _cargarCategorias();
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

    if (descripcion.isEmpty || imagen.isEmpty || salario == null || _categoriaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos correctamente')),
      );
      return;
    }

    final nuevoTrabajo = Trabajo(
      descripcion: descripcion,
      imagen: imagen,
      salario: salario,
      empresaId: widget.empresaId, // Asocia automáticamente con la empresa actual
      categoriaId: _categoriaSeleccionada!.id!, // Selecciona la categoría
    );

    try {
      await _dbHelper.insertTrabajo(nuevoTrabajo);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Trabajo agregado exitosamente')),
      );
      Navigator.pop(context); // Regresa a la pantalla anterior
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
