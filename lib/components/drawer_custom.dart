import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:sound_life/services/auth_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Drawer drawerCustom() {
  final authService = AuthServices();

  return Drawer(
    backgroundColor: const Color.fromARGB(94, 1, 1, 1),
    width: 200,
    child: StreamBuilder(
      //Para conocer los cambios de perfil
      stream: Supabase.instance.client.auth.onAuthStateChange,

      builder: (context, snapshot){
      //Carga de usuarios
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      
      //Si hay una sesion valida
      final session = snapshot.hasData ? snapshot.data?.session : null;

      if (session != null){
        return Scaffold(
          appBar: AppBar(
            title: Text('Bienvenido'),
            actions: [
              IconButton(onPressed: authService.logout, icon: Icon(Pixel.logout))
            ],
          ),
          body: Column(

          ),
        );
      }else{
          return Scaffold(
          appBar: AppBar(
            title: Text('Inicia Sesion'),
          ),
          body: Column(

          ),
        );
      }
      }
      
    ),
  );
}
