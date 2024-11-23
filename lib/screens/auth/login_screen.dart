import 'package:flutter/material.dart';
import 'package:appmovil/models/roles.dart';
import 'package:appmovil/screens/roles/admin/admin_home_screen.dart';
import 'package:appmovil/screens/roles/user/user_home_screen.dart';
import 'package:appmovil/screens/roles/guest/guest_home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email == DefaultCredentials.adminEmail && password == DefaultCredentials.adminPassword) {
      // Credenciales de administrador
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminHomeScreen()),
      );
    } else if (email == DefaultCredentials.userEmail && password == DefaultCredentials.userPassword) {
      // Credenciales de usuario
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserHomeScreen()),
      );
    } else {
      // Credenciales incorrectas
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Correo o contraseña incorrectos"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inicio de Sesión")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleLogin,
              child: Text("Iniciar Sesión"),
            ),
            SizedBox(height: 20),
            Text("O continúa como invitado"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GuestHomeScreen()),
                );
              },
              child: Text("Ingresar como Invitado"),
            ),
          ],
        ),
      ),
    );
  }
}
