import 'package:flutter/material.dart';
import 'package:appmovil/models/trabajo.dart';
import 'package:appmovil/database_helper.dart';
import 'package:appmovil/screens/roles/empresa/agregar_trabajo_empresa_screen.dart';
import 'package:appmovil/screens/roles/empresa/editar_trabajo_screen.dart';

class GestionarOfertasScreen extends StatefulWidget {
  final int empresaId;

  const GestionarOfertasScreen({required this.empresaId, Key? key}) : super(key: key);

  @override
  _GestionarOfertasScreenState createState() => _GestionarOfertasScreenState();
}

class _GestionarOfertasScreenState extends State<GestionarOfertasScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Trabajo> _ofertas = [];

  @override
  void initState() {
    super.initState();
    _cargarOfertas();
  }

  void _cargarOfertas() async {
    final ofertas = await _dbHelper.getTrabajosByEmpresaId(widget.empresaId);
    setState(() {
      _ofertas = ofertas;
    });
  }

  void _eliminarOferta(int id) async {
    await _dbHelper.deleteTrabajo(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Oferta eliminada exitosamente")),
    );
    _cargarOfertas(); // Recarga las ofertas
  }

  void _editarOferta(Trabajo trabajo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarTrabajoScreen(trabajo: trabajo),
      ),
    ).then((_) => _cargarOfertas()); // Recarga las ofertas al volver
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Ofertas'),
        backgroundColor: Colors.orange,
      ),
      body: _ofertas.isEmpty
          ? Center(
        child: Text(
          "No tienes ofertas creadas.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        itemCount: _ofertas.length,
        itemBuilder: (context, index) {
          final oferta = _ofertas[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(oferta.descripcion),
              subtitle: Text("Salario: ${oferta.salario}"),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Editar') {
                    _editarOferta(oferta);
                  } else if (value == 'Eliminar') {
                    _eliminarOferta(oferta.id!);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'Editar',
                    child: Text('Editar'),
                  ),
                  PopupMenuItem(
                    value: 'Eliminar',
                    child: Text('Eliminar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
