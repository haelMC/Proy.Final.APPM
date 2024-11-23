import 'package:flutter/material.dart';

class GuestHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Guest Dashboard')),
      body: Center(child: Text('Bienvenido, Invitado')),
    );
  }
}
