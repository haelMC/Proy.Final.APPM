import 'package:flutter/material.dart';
import 'package:appmovil/screens/roles/user/user_jobs_screen.dart';
import 'package:appmovil/screens/roles/user/user_applications_screen.dart';

class UserHomeScreen extends StatelessWidget {
  final int userId; // ID del usuario

  const UserHomeScreen({required this.userId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bienvenido, Usuario',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserJobsScreen(userId: userId), // Pasa el userId aquí
                  ),
                );
              },
              child: Text('Ver Ofertas Disponibles'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserApplicationsScreen(userId: userId), // Pasa el userId aquí
                  ),
                );
              },
              child: Text('Mis Postulaciones'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
