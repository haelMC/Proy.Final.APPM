import 'package:appmovil/screens/roles/empresa/gestionar_ofertas_screen.dart';
import 'package:flutter/material.dart';
import 'package:appmovil/screens/roles/empresa/agregar_trabajo_empresa_screen.dart';

class EmpresaHomeScreen extends StatelessWidget {
  final int empresaId;

  const EmpresaHomeScreen({required this.empresaId, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestión de Vacantes"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Bienvenido, Empresa",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AgregarTrabajoEmpresaScreen(empresaId: 1), // Proporciona el ID de la empresa
              ),
            );
          },
          child: Text("Crear Trabajo"),
        ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción para ver postulantes
              },
              child: Text("Ver Postulantes"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GestionarOfertasScreen(empresaId: 1), // Pasa el ID de la empresa
                  ),
                );
              },
              child: Text("Gestionar Ofertas"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
