import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/trabajo.dart';
import '../models/empresa.dart';
import '../models/categoria.dart';
import '../models/postulacion.dart';

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
      version: 5,
      onCreate: (db, version) async {
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
        await db.execute('''
      CREATE TABLE empresas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        direccion TEXT NOT NULL,
        telefono TEXT NOT NULL,
        logo TEXT
      )
    ''');
        await db.execute('''
      CREATE TABLE categorias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL
      )
    ''');
        await createPostulacionesTable(db); // Asegúrate de que se llama aquí.
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 5) {
          await createPostulacionesTable(db);
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

  Future<List<Trabajo>> getTrabajosByEmpresaId(int empresaId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'trabajos',
      where: 'empresaId = ?',
      whereArgs: [empresaId],
    );
    return result.map((map) => Trabajo.fromMap(map)).toList();
  }

  Future<Trabajo?> getTrabajoById(int id) async {
    final db = await database; // Asegúrate de que la base de datos esté inicializada
    final result = await db.query(
      'trabajos', // Nombre de la tabla de trabajos
      where: 'id = ?', // Condición para filtrar por ID
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Trabajo.fromMap(result.first); // Convierte el primer resultado en un objeto Trabajo
    } else {
      return null; // Retorna null si no encuentra el trabajo
    }
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

  // ********** CRUD para Postulaciones **********
  Future<void> createPostulacionesTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS postulaciones (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      trabajoId INTEGER NOT NULL,
      userId INTEGER NOT NULL,
      fechaPostulacion TEXT NOT NULL,
      FOREIGN KEY (trabajoId) REFERENCES trabajos (id),
      FOREIGN KEY (userId) REFERENCES usuarios (id)
    )
  ''');
  }

  Future<void> insertPostulacion(Postulacion postulacion) async {
    final db = await database;
    await db.insert(
      'postulaciones',
      postulacion.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Postulacion>> getPostulacionesByUserId(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'postulaciones',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return List.generate(maps.length, (i) {
      return Postulacion.fromMap(maps[i]);
    });
  }



}
