import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:sound_life/services/auth_services.dart';
import 'package:sound_life/styles/styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // visualizar contraseña
  bool visualizar = true;

  // ! servicio de autenticacion
  final auth = AuthServices();

  // ! Controllers
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmedPassword = TextEditingController();

  // ! boton registrarse
  void register() async {
    final email = _email.text;
    final password = _password.text;
    final confirmedPassword = _confirmedPassword.text;

    if (password != confirmedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'La contraseñas no coinciden asegurate de colocar tu contraseña correctamente',
          ),
        ),
      );
      return;
    }

    try {
      await auth.register(email, password);

      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 325,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              border: Border.all(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Pixel.userplus, size: 64),
                  SizedBox(height: 8),
                  Text('Registrate', style: CustomStyles().textoGrande),
                  SizedBox(height: 8),
                  TextField(
                    controller: _email,
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    obscureText: visualizar,
                    controller: _password,
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
                  SizedBox(height: 8),
                  TextField(
                    obscureText: visualizar,
                    controller: _confirmedPassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        visualizar = !visualizar;
                      });
                      }, icon: visualizar ?  Icon(Pixel.eyeclosed) : Icon(Pixel.eye)),
                      labelText: 'Confirma tu Contraseña',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(
                        Colors.blueAccent,
                      ),
                      foregroundColor: const WidgetStatePropertyAll(
                        Colors.white,
                      ),
                    ),
                    onPressed: register,
                    child: Text('Registrate'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
