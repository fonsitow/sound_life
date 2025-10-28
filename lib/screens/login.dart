import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:sound_life/screens/register.dart';
import 'package:sound_life/services/auth_services.dart';
import 'package:sound_life/styles/styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visualizar = true;

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
      Navigator.pop(context);
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
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: 325,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            border: Border.all(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Pixel.user, size: 64),
              const SizedBox(height: 8),
              Text('Iniciar sesion', style: CustomStyles().textoGrande),
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
                  obscureText: visualizar,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        visualizar = !visualizar;
                      });
                      }, icon: visualizar ?  Icon(Pixel.eyeclosed) : Icon(Pixel.eye)),
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
                    onPressed: login,
                    child: Text('Inicia Sesion'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Center(
                  child: Text('No tienes una cuenta?, Registrate YA!!'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
