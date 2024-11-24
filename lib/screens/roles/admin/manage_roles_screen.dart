import 'package:flutter/material.dart';

class ManageRolesScreen extends StatefulWidget {
  @override
  _ManageRolesScreenState createState() => _ManageRolesScreenState();
}

class _ManageRolesScreenState extends State<ManageRolesScreen> {
  // Lista de roles (puedes reemplazar esto con una base de datos)
  List<String> roles = ['Admin', 'User', 'Guest'];

  final TextEditingController roleController = TextEditingController();

  void addRole() {
    if (roleController.text.isNotEmpty) {
      setState(() {
        roles.add(roleController.text);
        roleController.clear();
      });
    }
  }

  void deleteRole(int index) {
    setState(() {
      roles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Roles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: roleController,
              decoration: InputDecoration(
                labelText: 'Nuevo Rol',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addRole,
              child: Text('Agregar Rol'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: roles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(roles[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteRole(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
