import 'package:flutter/material.dart';
import 'package:appmovil/models/roles.dart';
import 'package:appmovil/screens/roles/admin/admin_home_screen.dart';
import 'package:appmovil/screens/roles/user/user_home_screen.dart';
import 'package:appmovil/screens/roles/guest/guest_home_screen.dart';
import 'package:appmovil/screens/roles/empresa/empresa_home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Ejemplo de credenciales para pruebas (modificar según necesidad)
  final int adminId = 1;
  final int userId = 2;
  final int empresaId = 3;

  void handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email == DefaultCredentials.adminEmail &&
        password == DefaultCredentials.adminPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminHomeScreen(),
        ),
      );
    } else if (email == DefaultCredentials.userEmail &&
        password == DefaultCredentials.userPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserHomeScreen(userId: userId),
        ),
      );
    } else if (email == DefaultCredentials.empresaEmail && password == DefaultCredentials.empresaPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EmpresaHomeScreen(empresaId: empresaId), // Pasa el empresaId aquí
        ),
      );
    }
    else {
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
