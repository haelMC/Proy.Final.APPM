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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'trabajoId': trabajoId,
      'userId': userId,
      'fechaPostulacion': fechaPostulacion,
    };
  }

  factory Postulacion.fromMap(Map<String, dynamic> map) {
    return Postulacion(
      id: map['id'] as int?, // Permitir que sea nulo
      trabajoId: map['trabajoId'] as int, // Campo obligatorio
      userId: map['userId'] as int, // Campo obligatorio
      fechaPostulacion: map['fechaPostulacion'] ?? '', // Valor predeterminado si es nulo
    );
  }
}
