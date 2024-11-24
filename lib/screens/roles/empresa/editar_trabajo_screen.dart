import 'package:flutter/material.dart';
import 'package:appmovil/models/trabajo.dart';
import 'package:appmovil/models/categoria.dart';
import 'package:appmovil/database_helper.dart';

class EditarTrabajoScreen extends StatefulWidget {
  final Trabajo trabajo;

  const EditarTrabajoScreen({required this.trabajo, Key? key}) : super(key: key);

  @override
  _EditarTrabajoScreenState createState() => _EditarTrabajoScreenState();
}

class _EditarTrabajoScreenState extends State<EditarTrabajoScreen> {
  final _descripcionController = TextEditingController();
  final _imagenController = TextEditingController();
  final _salarioController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Categoria> _categorias = [];
  Categoria? _categoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    // Inicializar los campos con los datos actuales del trabajo
    _descripcionController.text = widget.trabajo.descripcion;
    _imagenController.text = widget.trabajo.imagen;
    _salarioController.text = widget.trabajo.salario.toString();

    // Cargar categorías y establecer la categoría actual
    _cargarCategorias();
  }

  Future<void> _cargarCategorias() async {
    final categorias = await _dbHelper.getCategorias();
    setState(() {
      _categorias = categorias;
      _categoriaSeleccionada = categorias.firstWhere(
            (categoria) => categoria.id == widget.trabajo.categoriaId,
        orElse: () => categorias.isNotEmpty
            ? categorias[0]
            : Categoria(id: 0, nombre: 'Sin categoría'),
      );
    });
  }

  void _guardarCambios() async {
    // Validar campos
    if (_descripcionController.text.isNotEmpty &&
        _imagenController.text.isNotEmpty &&
        _salarioController.text.isNotEmpty &&
        _categoriaSeleccionada != null) {
      final salario = double.tryParse(_salarioController.text);
      if (salario == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('El salario debe ser un número válido')),
        );
        return;
      }

      // Crear una copia del trabajo actualizado
      final trabajoActualizado = Trabajo(
        id: widget.trabajo.id,
        descripcion: _descripcionController.text,
        imagen: _imagenController.text,
        salario: salario,
        empresaId: widget.trabajo.empresaId, // La empresa no cambia
        categoriaId: _categoriaSeleccionada!.id!, // Actualiza categoría seleccionada
      );

      // Guardar los cambios en la base de datos
      try {
        await _dbHelper.updateTrabajo(trabajoActualizado);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Trabajo actualizado exitosamente')),
        );
        Navigator.pop(context); // Regresar a la lista de trabajos
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar los cambios')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor completa todos los campos')),
      );
    }
  }

  @override
  void dispose() {
    _descripcionController.dispose();
    _imagenController.dispose();
    _salarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Trabajo'),
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
            SizedBox(height: 20),
            DropdownButton<Categoria>(
              value: _categoriaSeleccionada,
              items: _categorias
                  .map(
                    (categoria) => DropdownMenuItem<Categoria>(
                  value: categoria,
                  child: Text(categoria.nombre),
                ),
              )
                  .toList(),
              onChanged: (Categoria? nuevaCategoria) {
                setState(() {
                  _categoriaSeleccionada = nuevaCategoria;
                });
              },
              hint: Text('Seleccionar Categoría'),
              isExpanded: true,
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
