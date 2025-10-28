import 'package:flutter/material.dart';
import 'package:sound_life/services/auth_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Controllers
  final _email = TextEditingController();
  final _password = TextEditingController();

  //servicios de autenticacion
  final auth = AuthServices();

  //Login button
  void login() async {
    // preparar datos
    final email = _email.text;
    final password = _password.text;

    try {
      auth.login(email, password);
    } catch (e) {
      if (mounted) {
        debugPrint('$e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ha ocurrido un error, intenta nuevamente')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 325,
          height: 450,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 64),
              const SizedBox(height: 8),
              const Text(
                'Iniciar sesión',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextField(
                  controller: _email,
                  decoration: const InputDecoration(
                    labelText: 'Correo',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: SizedBox(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(
                        Colors.blueAccent,
                      ),
                      foregroundColor: const WidgetStatePropertyAll(
                        Colors.white,
                      ),
                    ),
                    onPressed: () {},
                    child: Text('hello'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
