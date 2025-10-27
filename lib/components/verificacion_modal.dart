import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase, OtpType;

class VerificationModal extends StatefulWidget {
  const VerificationModal({super.key});

  @override
  State<VerificationModal> createState() => _VerificationModalState();
}

class _VerificationModalState extends State<VerificationModal> {
  final code = TextEditingController();

  void handleVerify() async {
    final response = await Supabase.instance.client.auth.verifyOTP(
      type: OtpType.email,
      token: code.text.trim(),
      email: Supabase.instance.client.auth.currentUser?.email ?? '',
    );

    if (response.user != null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo verificado. Ahora inicia sesión')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código inválido')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Verificación de correo'),
      content: TextField(controller: code, decoration: const InputDecoration(labelText: 'Código de verificación')),
      actions: [
        ElevatedButton(onPressed: handleVerify, child: const Text('Verificar')),
      ],
    );
  }
}