import 'package:flutter/material.dart';

class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text("WELCOM", style: TextStyle(color: Colors.red)),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // centra verticalmente
          children: [
            ElevatedButton(
              onPressed: () => Login(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // botón rojo estilo Netflix
              ),
              child: Text(
                "Iniciar sesion",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => Registro(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Registrate", style: TextStyle(color: Colors.white)),
            ),

              const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Home(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Entrar al Home", style: TextStyle(color: Colors.white)),
            ),
          ], // centra verticalmente
        ),
      ),
    );
  }
}

void Login(BuildContext context) {
  Navigator.pushNamed(context, "/LoginScreen");
}

void Registro(context) {
  Navigator.pushNamed(context, "/RegistroScreen");
}

void Home(BuildContext context) {
  Navigator.pushNamed(context, "/HomeScreen");
}