import 'package:flutter/material.dart';
import '../models/empresa.dart';
import '../database_helper.dart';
import 'editar_empresa_screen.dart';

class ListaEmpresasScreen extends StatefulWidget {
  @override
  _ListaEmpresasScreenState createState() => _ListaEmpresasScreenState();
}

class _ListaEmpresasScreenState extends State<ListaEmpresasScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<List<Empresa>> _empresas;

  @override
  void initState() {
    super.initState();
    _cargarEmpresas();
  }

  void _cargarEmpresas() {
    setState(() {
      _empresas = _dbHelper.getEmpresas();
    });
  }

  void _eliminarEmpresa(int id) async {
    await _dbHelper.deleteEmpresa(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Empresa eliminada')),
    );
    _cargarEmpresas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Empresas'),
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder<List<Empresa>>(
        future: _empresas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar las empresas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay empresas disponibles'));
          }

          final empresas = snapshot.data!;
          return ListView.builder(
            itemCount: empresas.length,
            itemBuilder: (context, index) {
              final empresa = empresas[index];
              return ListTile(
                leading: empresa.logo != null
                    ? Image.network(
                  empresa.logo!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : Icon(Icons.business, size: 50, color: Colors.grey),
                title: Text(empresa.nombre),
                subtitle: Text('Tel: ${empresa.telefono}\nDir: ${empresa.direccion}'),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarEmpresaScreen(empresa: empresa),
                          ),
                        ).then((_) => _cargarEmpresas());
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _eliminarEmpresa(empresa.id!),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
