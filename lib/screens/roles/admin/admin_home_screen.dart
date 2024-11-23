import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido, Administrador'),
            ElevatedButton(
              onPressed: () {
                // Agrega funcionalidades para el administrador aquí
              },
              child: Text("Gestionar Usuarios"),
            ),
          ],
        ),
      ),
    );
  }
}
