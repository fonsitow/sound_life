import 'package:flutter/material.dart';
import 'package:sound_life/components/verificacion_modal.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

class RegisterModal extends StatefulWidget {
  const RegisterModal({super.key});

  @override
  State<RegisterModal> createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  bool loading = false;

  void handleRegister() async {
    if (email.text.isEmpty || password.text.length < 6 || username.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos correctamente')),
      );
      return;
    }

    setState(() => loading = true);

    final response = await Supabase.instance.client.auth.signUp(
      email: email.text.trim(),
      password: password.text.trim(),
      data: {'username': username.text.trim()},
    );

    setState(() => loading = false);

    if (response.user != null) {
      Navigator.pop(context); // Cierra modal
      showDialog(
        context: context,
        builder: (_) => const VerificationModal(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo registrar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registro'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: username, decoration: const InputDecoration(labelText: 'Usuario')),
          TextField(controller: email, decoration: const InputDecoration(labelText: 'Correo')),
          TextField(controller: password, decoration: const InputDecoration(labelText: 'Contraseña'), obscureText: true),
        ],
      ),
      actions: [
        loading
            ? const CircularProgressIndicator()
            : ElevatedButton(onPressed: handleRegister, child: const Text('Registrarse')),
      ],
    );
  }
}