import 'package:app_streaming/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Registro",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              const Text(
                "Regístrate Ahora",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 25),
              Registro(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget Registro(BuildContext context) {

  TextEditingController correo = TextEditingController();
  TextEditingController password = TextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center, 
    children: [
      TextField(
        controller: correo,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          labelText: "Correo electronico",
          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(Icons.person, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),

      const SizedBox(height: 12),

      TextField(
        controller: password,
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
        onPressed: () => registro(context, correo, password),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.deepPurpleAccent,
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
        ),
        child: const Text(
          "Registrarse",
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

Future<void> registro(BuildContext context, TextEditingController correo, TextEditingController password) async {
  try {
    final AuthResponse res = await supabase.auth.signUp(
      email: correo.text,
      password: password.text,
    );
    final Session? session = res.session;
    final User? user = res.user;

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registro exitoso")),
      );
      Navigator.pushNamed(context, "/LoginScreen");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo registrar el usuario")),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error en registro: $error")),
    );
  }
}
