import 'package:app_streaming/screens/BienvenidaScreen.dart';
import 'package:app_streaming/screens/HomeScreen.dart';
import 'package:app_streaming/screens/LoginScreen.dart';
import 'package:app_streaming/screens/RegistroScreen.dart';
import 'package:flutter/material.dart';

void main (){
runApp(MiStreaming());  
}

class MiStreaming extends StatelessWidget {
  const MiStreaming({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: "/", // Siempre la ruta inicial
      routes: { // Navegacion por rutas 
        "/":(context) => BienvenidaScreen(),
        "/LoginScreen":(context) => LoginScreen(),
        "/RegistroScreen":(context) => RegistroScreen(),
        "/HomeScreen":(context) => HomeScreen()
        
      },
    );
  }
}