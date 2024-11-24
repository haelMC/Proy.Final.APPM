import 'package:flutter/material.dart';
import 'package:appmovil/screens/lista_trabajos_screen.dart';
import 'package:appmovil/screens/agregar_trabajo_screen.dart';
import 'package:appmovil/screens/lista_empresas_screen.dart';
import 'package:appmovil/screens/agregar_empresa_screen.dart';
import 'package:appmovil/screens/roles/empresa/empresa_home_screen.dart';
import 'package:appmovil/screens/lista_categorias_screen.dart'; // Importa la pantalla de lista de categorías
import 'package:appmovil/screens/agregar_categoria_screen.dart'; // Importa la pantalla de agregar categoría
import 'package:appmovil/screens/roles/admin/manage_roles_screen.dart' as roles;
import 'package:appmovil/screens/roles/admin/manage_users_screen.dart' as users;

class AdminHomeScreen extends StatelessWidget {
  // Colores utilizados (puedes personalizarlos según tu diseño)
  final Color backgroundGray = const Color(0xFFF5F5F5); // Fondo gris claro
  final Color primaryBlue = const Color(0xFF1E88E5); // Azul principal
  final Color lightBlue = const Color(0xFF64B5F6); // Azul claro

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
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
              SizedBox(height: 40), // Separador entre roles y usuarios

              // Botón para gestionar roles
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => roles.ManageRolesScreen()),
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
                  'Gestionar Roles',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),

              // Botón para gestionar usuarios
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => users.ManageUsersScreen()),
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
                  'Gestionar Usuarios',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmpresaHomeScreen(empresaId: 1), // Pasa el ID de la empresa
                    ),
                  );

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Gestionar Empresas',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
