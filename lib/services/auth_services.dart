import 'package:flutter/material.dart';
import 'package:sound_life/models/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final SupabaseClient _client = Supabase.instance.client;

  //Iniciar sesion con correo y contraseña
  Future<AuthResponse> login(String email, String password) async {
    return await _client.auth.signInWithPassword(
      password: password,
      email: email,
    );
  }

  //Registrarse con email y contraseña
  Future<AuthResponse> register(String email, String password) async {
    return await _client.auth.signUp(password: password, email: email);
  }
  
  //Logout
  Future<void> logout() async{
    await _client.auth.signOut();
  }

  //Obtener el correo para usarlo como nombre de usuario
  String? emailUser () {
    final session = _client.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
