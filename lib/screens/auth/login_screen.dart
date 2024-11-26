import 'package:flutter/material.dart';
import 'package:appmovil/screens/roles/admin/admin_home_screen.dart';
import 'package:appmovil/screens/roles/user/user_home_screen.dart';
import 'package:appmovil/screens/roles/guest/guest_home_screen.dart';
import 'package:appmovil/screens/roles/empresa/empresa_home_screen.dart';

// Clase para almacenar las credenciales predeterminadas (puedes cambiar según tus necesidades)
class DefaultCredentials {
  static const Map<String, String> admin = {
    'email': "admin@gmail.com",
    'password': "12345678"
  };

  static const Map<String, String> user = {
    'email': "user@gmail.com",
    'password': "12345678"
  };

  static const Map<String, String> empresa = {
    'email': "empresa@gmail.com",
    'password': "12345678"
  };
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // IDs de ejemplo para roles
  final int adminId = 1;
  final int userId = 2;
  final int empresaId = 3;

  // Método para manejar el inicio de sesión
  void handleLogin() {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError("Por favor, ingresa tu correo y contraseña.");
      return;
    }

    // Validación de credenciales
    if (email == DefaultCredentials.admin['email'] &&
        password == DefaultCredentials.admin['password']) {
      _navigateTo(AdminHomeScreen());
    } else if (email == DefaultCredentials.user['email'] &&
        password == DefaultCredentials.user['password']) {
      _navigateTo(UserHomeScreen(userId: userId));
    } else if (email == DefaultCredentials.empresa['email'] &&
        password == DefaultCredentials.empresa['password']) {
      _navigateTo(EmpresaHomeScreen(empresaId: empresaId));
    } else {
      _showError("Correo o contraseña incorrectos");
    }
  }

  // Método para mostrar errores en un SnackBar
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Método para navegar a la pantalla correspondiente
  void _navigateTo(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Fondo azul principal
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white, // Fondo blanco para el formulario
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Título "Bolsa Laboral" encima de la imagen
                Text(
                  "Bolsa Laboral",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),

                // Imagen decorativa
                Image.asset(
                  'assets/logo1.png',
                  height: 150, // Altura de la imagen
                ),
                SizedBox(height: 20),

                // Campo de correo electrónico
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Correo Electrónico',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),

                // Campo de contraseña
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, // Ocultar texto para contraseña
                ),
                SizedBox(height: 20),

                // Botón de inicio de sesión
                ElevatedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Iniciar Sesión",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),

                // Texto para continuar como invitado
                Text(
                  "O continúa como invitado",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 10),

                // Botón para invitado
                ElevatedButton(
                  onPressed: () => _navigateTo(GuestHomeScreen()),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Ingresar como Invitado",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
