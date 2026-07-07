import 'package:app_streaming/main.dart';
import 'package:flutter/material.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

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
      body: lista(),
    );
  }
}

Future<List<dynamic>> catalogo() async {
  try {
    final data = await supabase.from('peliculas').select();
    return data;
  } catch (error) {
    debugPrint("Error al consultar catálogo: $error");
    return [];
  }
}

Future<void> eliminarPelicula(BuildContext context, String id) async {
  try {
    await supabase.from('peliculas').delete().eq('id', id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Película eliminada correctamente")),
    );
    // refrescar pantalla
    Navigator.pushReplacementNamed(context, "/CatalogoScreen");
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error al eliminar: $error")),
    );
  }
}

Widget lista() {
  return FutureBuilder<List<dynamic>>(
    future: catalogo(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      }
      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text("No hay películas"));
      }

      final data = snapshot.data!;
      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          final videoUrl = item['video'] ?? "";

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    item['portada'] ?? "",
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("Error al cargar imagen"),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['titulo'] ?? "Sin título",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const SizedBox(height: 6),
                      Text("Categoría: ${item['categoria'] ?? "N/A"}",
                          style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 6),
                      Text(item['descripcion'] ?? "Sin descripción",
                          style: const TextStyle(color: Colors.black87)),
                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FilledButton(
                              onPressed: () {
                                if (videoUrl.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("No hay URL de video")),
                                  );
                                  return;
                                }
                                Navigator.pushNamed(
                                  context,
                                  "/PlayerScreen",
                                  arguments: videoUrl,
                                );
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Reproducir",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14)),
                            ),
                            const SizedBox(width: 10),
                            FilledButton(
                              onPressed: () =>
                                  eliminarPelicula(context, item['id']),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Eliminar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
