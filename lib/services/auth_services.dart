import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class AuthServices {
  final SupabaseClient _client = Supabase.instance.client;

  

  //Iniciar sesion con correo y contraseña
  Future<AuthResponse?> login(String email, String password) async {
  try {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  } on AuthException catch (e) {
    debugPrint('Error de autenticación: ${e.message}');
    return null;
  } catch (e) {
    debugPrint('Error inesperado: $e');
    return null;
  }
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
    if(user != null){
    return user.email;
    }else{
      return 'Usuario Invitado';
    }
  }
}
