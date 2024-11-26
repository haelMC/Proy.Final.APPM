class Postulacion {
  final int? id;
  final int trabajoId;
  final int userId;
  final String fechaPostulacion;

  Postulacion({
    this.id,
    required this.trabajoId,
    required this.userId,
    required this.fechaPostulacion,
  });

  // Constructor para crear un objeto desde un mapa
  factory Postulacion.fromMap(Map<String, dynamic> map) {
    return Postulacion(
      id: map['id'],
      trabajoId: map['trabajoId'],
      userId: map['userId'],
      fechaPostulacion: map['fechaPostulacion'],
    );
  }

  // Convertir objeto a mapa para insertar en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'trabajoId': trabajoId,
      'userId': userId,
      'fechaPostulacion': fechaPostulacion,
    };
  }
}
