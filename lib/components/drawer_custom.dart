import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:sound_life/screens/login.dart';
import 'package:sound_life/screens/register.dart';
import 'package:sound_life/services/auth_services.dart';
import 'package:sound_life/styles/styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Drawer drawerCustom() {
  final authService = AuthServices();
  final profile = authService.emailUser();

  return Drawer(
    shape: Border(),
    backgroundColor: const Color.fromARGB(166, 255, 255, 255),
    width: 200,
    child: StreamBuilder<AuthState>(
      // ! Para conocer los cambios de perfil
      stream: Supabase.instance.client.auth.onAuthStateChange,

      builder: (context, snapshot) {
        // ! Carga de usuarios
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // ! Si hay una sesion valida
        final session = snapshot.hasData ? snapshot.data?.session : null;

        return ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsetsGeometry.only(top: 48, left: 28),
              margin: EdgeInsets.all(0),
              child: Text(
                session != null ? 'Bienvenido' : 'Inicia Sesión',
                style: CustomStyles().textoTitulo,
              ),
            ),
            if (session != null)
              ListTile(
                leading: Icon(Pixel.logout),
                title: Text('Cerrar sesión', style: CustomStyles().textoSimple),
                onTap: authService.logout,
              )
            else ...[
              ListTile(
                splashColor: const Color.fromARGB(83, 101, 101, 101),
                leading: Icon(Pixel.login),
                title: Text('Inicia sesión', style: CustomStyles().textoSimple),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                },
              ),
              ListTile(
                splashColor: const Color.fromARGB(83, 101, 101, 101),
                leading: Icon(Pixel.login),
                title: Text('Registrate', style: CustomStyles().textoSimple),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                },
              ),
            ]
              
          ],
        );
      },
    ),
  );
}
