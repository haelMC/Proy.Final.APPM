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
      id: map['id'],
      descripcion: map['descripcion'],
      imagen: map['imagen'],
      salario: map['salario'],
      empresaId: map['empresaId'],
      categoriaId: map['categoriaId'],
      empresaNombre: map['empresaNombre'],
      categoriaNombre: map['categoriaNombre'],
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
    };
  }
}
