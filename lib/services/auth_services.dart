import 'package:flutter/material.dart';
import 'package:sound_life/models/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final SupabaseClient _client = Supabase.instance.client;

  Future<Auth?> login(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user != null) {
        return Auth(id: user.id, email: user.email ?? '');
      }
      return null; // Usuario no existe o credenciales inválidas
    } catch (error) {
      // Puedes personalizar el manejo de error aquí
      debugPrint('Error en login: $error');
      return null;
    }
  }

  Future<bool> logout() async {
    try {
      await _client.auth.signOut();
      return true;
    } catch (error) {
      debugPrint('Error en logout: $error');
      return false;
    }
  }

  Auth? get currentUser {
    final user = _client.auth.currentUser;
    if (user != null) {
      return Auth(id: user.id, email: user.email ?? '');
    }
    return null;
  }

  Future<Map<String, dynamic>> register(String email, String password, String username) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'username': username}, // Almacena username en metadata
      );

      final user = response.user;
      if (user != null) {
        return {
          'success': true,
          'user': Auth(id: user.id, email: user.email ?? '')
        };
      }
      return {'success': false, 'message': 'Registro fallido.'};
    } catch (error) {
      String message = 'Error desconocido';
      if (error is AuthException) {
        message = error.message;
      } else if (error.toString().contains('duplicate')) {
        message = 'El correo ya está en uso.';
      }
      return {
        'success': false,
        'message': message,
      };
    }
  }
}
