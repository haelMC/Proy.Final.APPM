// role_based_access.dart
import 'package:flutter/material.dart';

import 'models/roles.dart';

class RoleBasedAccess extends StatelessWidget {
  final String userRole;
  final String requiredRole;
  final Widget child;

  RoleBasedAccess({
    required this.userRole,
    required this.requiredRole,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (userRole == requiredRole || userRole == Roles.admin) {
      return child;
    }
    return Center(child: Text("No tienes permiso para acceder a esta página"));
  }
}
