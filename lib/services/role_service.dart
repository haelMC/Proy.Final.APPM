// role_service.dart
class RoleService {
  static String getRoleForUser(String userId) {
    // Simula una base de datos para obtener el rol del usuario
    if (userId == "1") return Roles.admin;
    if (userId == "2") return Roles.user;
    return Roles.guest;
  }
}
