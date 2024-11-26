class Trabajo {
  final int? id;
  final String descripcion;
  final String imagen;
  final double salario;
  final int empresaId;
  final int categoriaId;
  final String? empresaNombre; // Campo opcional para mostrar la empresa
  final String? categoriaNombre; // Campo opcional para mostrar la categoría

  Trabajo({
    this.id,
    required this.descripcion,
    required this.imagen,
    required this.salario,
    required this.empresaId,
    required this.categoriaId,
    this.empresaNombre,
    this.categoriaNombre,
  });

  // Método para convertir un mapa en un objeto Trabajo
  factory Trabajo.fromMap(Map<String, dynamic> map) {
    return Trabajo(
      id: map['id'] as int?,
      descripcion: map['descripcion'] as String,
      imagen: map['imagen'] as String,
      salario: map['salario'] as double,
      empresaId: map['empresaId'] as int,
      categoriaId: map['categoriaId'] as int,
      empresaNombre: map['empresaNombre'] as String?,
      categoriaNombre: map['categoriaNombre'] as String?,
    );
  }

  // Método para convertir un objeto Trabajo en un mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descripcion': descripcion,
      'imagen': imagen,
      'salario': salario,
      'empresaId': empresaId,
      'categoriaId': categoriaId,
      // No se incluyen campos opcionales en la salida de toMap() porque son calculados o mostrados
    };
  }
}
