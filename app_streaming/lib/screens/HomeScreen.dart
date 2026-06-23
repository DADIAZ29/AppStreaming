import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> peliculas = const [
    {
      "titulo": "Inception",
      "descripcion": "Un ladrón roba secretos a través de sueños.",
      "imagen": "https://image.tmdb.org/t/p/w500/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg"
    },
    {
      "titulo": "Interstellar",
      "descripcion": "Exploración espacial para salvar la humanidad.",
      "imagen": "https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg"
    },
    {
      "titulo": "The Dark Knight",
      "descripcion": "Batman enfrenta al Joker en Gotham.",
      "imagen": "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Series y Películas", style: TextStyle(color: Colors.white)),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.7, 
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: peliculas.length,
        itemBuilder: (context, index) {
          final pelicula = peliculas[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/PlayerScreen", arguments: pelicula);
            },
            child: Card(
              color: Colors.black,
              child: Column(
                children: [
                  Image.network(pelicula["imagen"]!, fit: BoxFit.cover),
                  SizedBox(height: 8),
                  Text(
                    pelicula["titulo"]!,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    pelicula["descripcion"]!,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
