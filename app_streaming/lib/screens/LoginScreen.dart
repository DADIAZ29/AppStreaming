import 'package:app_streaming/main.dart';
import 'package:app_streaming/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Login",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Iniciar Sesión",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 60),
            Ingreso(context),
          ],
        ),
      ),
    );
  }
}

Widget Ingreso(BuildContext context) {
  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  return Column(
    children: [
      TextField(
        controller: correo,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          labelText: "Usuario",
          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(Icons.person, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),

      const SizedBox(height: 12),

      TextField(
        controller: contrasena,
        obscureText: true,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          labelText: "Contraseña",
          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(Icons.lock, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),

      const SizedBox(height: 20),

      FilledButton(
        onPressed: () => login(context, correo, contrasena),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.blueAccent, 
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 12), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
        ),
        child: const Text(
          "Ingresar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16, 
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
          ),
        ),
      ),
    ],
  );
}

Future<void> login(BuildContext context, TextEditingController correo, TextEditingController contrasena) async {
  try {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: correo.text,
      password: contrasena.text,
    );

    final Session? session = res.session;
    final User? user = res.user;

    if (user != null) {
      Navigator.pushNamed(context, "/HomeScreen");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Credenciales incorrectas")),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error en login: $error")),
    );
  }
}
