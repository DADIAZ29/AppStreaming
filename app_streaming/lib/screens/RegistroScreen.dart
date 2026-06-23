import 'package:flutter/material.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, 
      title: Text("Registro", style: TextStyle(color: Colors.white),
      )),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text("Registrate Ahora", style: TextStyle(color: Colors.white)),
            Registro(),
          ],
        ),
      ),
    );
  }
}

Widget Registro() {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  return Column(
    children: [
      TextField(
        controller: name,
        decoration: InputDecoration(
          labelText: "Usuario",
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
        ),
      ),
      TextField(
        controller: password,
        decoration: InputDecoration(
          labelText: "Contraseña",
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
        ),
      ),
            SizedBox(height: 20),

      FilledButton(
        onPressed: () => (),
        style: FilledButton.styleFrom(backgroundColor: Colors.red),
        child: Text("Registrate"),
      ),
    ],
  );
}
