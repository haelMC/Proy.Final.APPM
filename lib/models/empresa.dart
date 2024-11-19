class Empresa {
  int? id;
  String nombre;
  String direccion;
  String telefono;
  String? logo;

  Empresa({
    this.id,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    this.logo,
  });

  // Convierte un objeto a un mapa para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
      'logo': logo,
    };
  }

  // Crea un objeto Empresa desde un mapa (al leer desde la base de datos)
  factory Empresa.fromMap(Map<String, dynamic> map) {
    return Empresa(
      id: map['id'],
      nombre: map['nombre'],
      direccion: map['direccion'],
      telefono: map['telefono'],
      logo: map['logo'],
    );
  }
}
