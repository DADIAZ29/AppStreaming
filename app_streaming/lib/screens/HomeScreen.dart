import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController portadaController = TextEditingController();
  final TextEditingController videoController = TextEditingController();

  final supabase = Supabase.instance.client;

  Future<void> guardar() async {
    final titulo = tituloController.text;
    final descripcion = descripcionController.text;
    final categoria = categoriaController.text;
    final portada = portadaController.text;
    final video = videoController.text;

    if (titulo.isEmpty ||
        descripcion.isEmpty ||
        categoria.isEmpty ||
        portada.isEmpty ||
        video.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos")),
      );
      return;
    }

    try {
      await supabase.from('peliculas').insert({
        'titulo': titulo,
        'descripcion': descripcion,
        'categoria': categoria,
        'portada': portada,
        'video': video,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Película guardada correctamente")),
      );

      tituloController.clear();
      descripcionController.clear();
      categoriaController.clear();
      portadaController.clear();
      videoController.clear();
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error al guardar: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Catálogo",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Agregar Película",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 25),

              buildTextField(tituloController, "Título", Icons.movie),
              const SizedBox(height: 12),
              buildTextField(
                descripcionController,
                "Descripción",
                Icons.description,
              ),
              const SizedBox(height: 12),
              buildTextField(categoriaController, "Categoría", Icons.category),
              const SizedBox(height: 12),
              buildTextField(portadaController, "URL de portada", Icons.image),
              const SizedBox(height: 12),
              buildTextField(
                videoController,
                "URL del video",
                Icons.play_circle_fill,
              ),

              const SizedBox(height: 25),

              FilledButton(
                onPressed: () => guardar(),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  "Guardar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              FilledButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "/CatalogoScreen"),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  "Mostrar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(controller, label, icon) => TextField(
    controller: controller,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      prefixIcon: Icon(icon, color: Colors.black),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
