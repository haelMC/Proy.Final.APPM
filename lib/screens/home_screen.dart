import 'package:flutter/material.dart';
import 'lista_trabajos_screen.dart';
import 'agregar_trabajo_screen.dart';
import 'lista_empresas_screen.dart';
import 'agregar_empresa_screen.dart';
import 'lista_categorias_screen.dart'; // Importa la pantalla de lista de categorías
import 'agregar_categoria_screen.dart'; // Importa la pantalla de agregar categoría

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Definimos colores basados en la paleta del logo
    const Color primaryBlue = Color(0xFF0066A2); // Azul principal del logo
    const Color lightBlue = Color(0xFF0099CC); // Azul claro
    const Color backgroundGray = Color(0xFFF2F2F2); // Fondo claro

    return Scaffold(
      backgroundColor: backgroundGray, // Fondo general de la app
      appBar: AppBar(
        title: Text(
          'Bolsa Laboral Puno',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: primaryBlue, // Color principal del AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Botones ocupan el ancho
          children: [
            // Imagen decorativa
            Image.asset(
              'assets/logo.png',
              height: 150,
            ),
            SizedBox(height: 40), // Espacio entre la imagen y los botones
            // Botón para ver lista de trabajos
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaTrabajosScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Ver Lista de Trabajos',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20), // Espacio entre botones
            // Botón para agregar nuevo trabajo
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgregarTrabajoScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: lightBlue,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Agregar Nuevo Trabajo',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 40), // Separador entre secciones
            // Botón para ver lista de empresas
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaEmpresasScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Ver Lista de Empresas',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20), // Espacio entre botones
            // Botón para agregar nueva empresa
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgregarEmpresaScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: lightBlue,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Agregar Nueva Empresa',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 40), // Separador entre categorías y empresas
            // Botón para ver lista de categorías
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaCategoriasScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Ver Lista de Categorías',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20), // Espacio entre botones
            // Botón para agregar nueva categoría
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgregarCategoriaScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: lightBlue,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Agregar Nueva Categoría',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
