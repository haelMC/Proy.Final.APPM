import 'package:appmovil/screens/roles/empresa/gestionar_ofertas_screen.dart';
import 'package:flutter/material.dart';
import 'package:appmovil/screens/roles/empresa/agregar_trabajo_empresa_screen.dart';

class EmpresaHomeScreen extends StatelessWidget {
  final int empresaId;

  const EmpresaHomeScreen({required this.empresaId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Fondo gris claro
      appBar: AppBar(
        title: const Text(
          "Gestión de Vacantes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mensaje de bienvenida
            Text(
              "Bienvenido, Empresa",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Botón Crear Trabajo
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgregarTrabajoEmpresaScreen(empresaId: empresaId),
                  ),
                );
              },
              style: _buttonStyle(Colors.orangeAccent),
              child: const Text(
                "Crear Trabajo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),

            // Botón Ver Postulantes
            ElevatedButton(
              onPressed: () {
                // Acción para ver postulantes
              },
              style: _buttonStyle(Colors.deepOrangeAccent),
              child: const Text(
                "Ver Postulantes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),

            // Botón Gestionar Ofertas
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GestionarOfertasScreen(empresaId: empresaId),
                  ),
                );
              },
              style: _buttonStyle(Colors.orange),
              child: const Text(
                "Gestionar Ofertas",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Espaciador al final
            Spacer(),
            Image.asset(
              'assets/logo_empresa.png',
              height: 120,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  // Estilo de los botones
  ButtonStyle _buttonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3.0,
    );
  }
}
