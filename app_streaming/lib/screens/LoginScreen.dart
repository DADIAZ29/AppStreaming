import 'package:app_streaming/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Login", style: TextStyle(color: Colors.white)),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // centra verticalmente
          children: [
            Text("Iniciar Sesion", style: TextStyle(color: Colors.white)),
            Ingreso(),
          ],
        ),
      ),
    );
  }
}

Widget Ingreso() {
  TextEditingController usuario = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  return (Column(
    children: [
      TextField(
        controller: usuario,
        decoration: InputDecoration(
          labelText: "Usuario",
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
        ),
      ),

      TextField(
        controller: contrasena,
        decoration: InputDecoration(
          labelText: "Contraseña",
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
        ),
      ),

      FilledButton(
        onPressed: () => (),
        style: FilledButton.styleFrom(backgroundColor: Colors.red),
        child: Text("Ingresar"),
      ),
    ],
  ));
}
