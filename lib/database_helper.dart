import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/trabajo.dart';
import '../models/empresa.dart';
import '../models/categoria.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'trabajos.db');
    return await openDatabase(
      path,
      version: 4, // Incrementa la versión según los cambios
      onCreate: (db, version) async {
        // Crear tabla trabajos
        await db.execute('''
          CREATE TABLE trabajos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            descripcion TEXT NOT NULL,
            imagen TEXT NOT NULL,
            salario REAL NOT NULL,
            empresaId INTEGER NOT NULL,
            categoriaId INTEGER NOT NULL,
            FOREIGN KEY (empresaId) REFERENCES empresas (id),
            FOREIGN KEY (categoriaId) REFERENCES categorias (id)
          )
        ''');
        // Crear tabla empresas
        await db.execute('''
          CREATE TABLE empresas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            direccion TEXT NOT NULL,
            telefono TEXT NOT NULL,
            logo TEXT
          )
        ''');
        // Crear tabla categorias
        await db.execute('''
          CREATE TABLE categorias (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          await db.execute('ALTER TABLE trabajos ADD COLUMN categoriaId INTEGER NOT NULL DEFAULT 0');
        }
        if (oldVersion < 4) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS categorias (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nombre TEXT NOT NULL
            )
          ''');
        }
      },
    );
  }

  // ********** CRUD para Trabajos **********
  Future<int> insertTrabajo(Trabajo trabajo) async {
    final db = await database;
    return await db.insert('trabajos', trabajo.toMap());
  }

  Future<List<Trabajo>> getTrabajos() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
      trabajos.id, 
      trabajos.descripcion, 
      trabajos.imagen, 
      trabajos.salario, 
      trabajos.empresaId, 
      trabajos.categoriaId,
      empresas.nombre AS empresaNombre,
      categorias.nombre AS categoriaNombre
    FROM trabajos
    LEFT JOIN empresas ON trabajos.empresaId = empresas.id
    LEFT JOIN categorias ON trabajos.categoriaId = categorias.id
  ''');
    return result.map((map) => Trabajo.fromMap(map)).toList();
  }


  Future<int> updateTrabajo(Trabajo trabajo) async {
    final db = await database;
    return await db.update(
      'trabajos',
      trabajo.toMap(),
      where: 'id = ?',
      whereArgs: [trabajo.id],
    );
  }

  Future<int> deleteTrabajo(int id) async {
    final db = await database;
    return await db.delete('trabajos', where: 'id = ?', whereArgs: [id]);
  }

  // ********** CRUD para Empresas **********
  Future<int> insertEmpresa(Empresa empresa) async {
    final db = await database;
    return await db.insert('empresas', empresa.toMap());
  }

  Future<List<Empresa>> getEmpresas() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('empresas');
    return result.map((map) => Empresa.fromMap(map)).toList();
  }

  Future<int> updateEmpresa(Empresa empresa) async {
    final db = await database;
    return await db.update(
      'empresas',
      empresa.toMap(),
      where: 'id = ?',
      whereArgs: [empresa.id],
    );
  }

  Future<int> deleteEmpresa(int id) async {
    final db = await database;
    return await db.delete('empresas', where: 'id = ?', whereArgs: [id]);
  }

  // ********** CRUD para Categorías **********
  Future<int> insertCategoria(Categoria categoria) async {
    final db = await database;
    return await db.insert('categorias', categoria.toMap());
  }

  Future<List<Categoria>> getCategorias() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('categorias');
    return result.map((map) => Categoria.fromMap(map)).toList();
  }

  Future<int> updateCategoria(Categoria categoria) async {
    final db = await database;
    return await db.update(
      'categorias',
      categoria.toMap(),
      where: 'id = ?',
      whereArgs: [categoria.id],
    );
  }

  Future<int> deleteCategoria(int id) async {
    final db = await database;
    return await db.delete('categorias', where: 'id = ?', whereArgs: [id]);
  }
}
