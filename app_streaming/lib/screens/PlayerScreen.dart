import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  final String videoUrl;
  const PlayerScreen({super.key, required this.videoUrl});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late VideoPlayerController controller;
  bool hasError = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    try {
      controller = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {});
            controller.play();
          }
        }).catchError((error) {
          setState(() {
            hasError = true;
            errorMessage = "Error al inicializar video: $error";
          });
        });
    } catch (error) {
      setState(() {
        hasError = true;
        errorMessage = "Error inesperado: $error";
      });
    }
  }

  @override
  void dispose() {
    try {
      controller.dispose();
    } catch (error) {
      debugPrint("Error al liberar controlador: $error");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (widget.videoUrl.isEmpty) {
        return const Scaffold(
          body: Center(child: Text("No se encontró URL de video")),
        );
      }

      if (hasError) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Center(child: Text(errorMessage, style: const TextStyle(color: Colors.white))),
        );
      }

      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context), // retrocede al catálogo
          ),
        ),
        body: Center(
          child: controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                )
              : const CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            try {
              setState(() {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
              });
            } catch (error) {
              setState(() {
                hasError = true;
                errorMessage = "Error al reproducir: $error";
              });
            }
          },
          child: Icon(
            controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      );
    } catch (error) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(child: Text("Error inesperado en build: $error")),
      );
    }
  }
}
