import 'package:flutter/material.dart';

class ManageUsersScreen extends StatefulWidget {
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  // Lista de usuarios simulados (puedes reemplazar esto con datos de una base de datos)
  List<Map<String, String>> users = [
    {'name': 'Juan Perez', 'email': 'juan.perez@example.com'},
    {'name': 'Maria Lopez', 'email': 'maria.lopez@example.com'},
    {'name': 'Carlos Diaz', 'email': 'carlos.diaz@example.com'},
  ];

  // Eliminar usuario
  void deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestionar Usuarios"),
        backgroundColor: Colors.blue,
      ),
      body: users.isEmpty
          ? Center(
        child: Text(
          "No hay usuarios registrados.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text(users[index]['name']!),
              subtitle: Text(users[index]['email']!),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Confirmar antes de eliminar
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Eliminar Usuario"),
                      content: Text(
                          "¿Estás seguro de que deseas eliminar este usuario?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text("Cancelar"),
                        ),
                        TextButton(
                          onPressed: () {
                            deleteUser(index);
                            Navigator.of(ctx).pop();
                          },
                          child: Text("Eliminar"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
