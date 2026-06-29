import 'package:app_streaming/screens/BienvenidaScreen.dart';
import 'package:app_streaming/screens/CatalogoScreen.dart';
import 'package:app_streaming/screens/HomeScreen.dart';
import 'package:app_streaming/screens/LoginScreen.dart';
import 'package:app_streaming/screens/RegistroScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main () async {

    await Supabase.initialize(
    url: 'https://ynovomymlqlekndcjomo.supabase.co',
    publishableKey: 'sb_publishable_VFxN7urbQZMnTK74idwBuQ_NdbO6i9i',
  );
runApp(MiStreaming());  
}
final supabase = Supabase.instance.client;



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
        "/HomeScreen":(context) => HomeScreen(),
        "/CatalogoScreen":(context) => CatalogoScreen()
        
        
      },
    );
  }
}