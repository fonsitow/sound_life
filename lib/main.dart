import 'package:flutter/material.dart';
import 'package:sound_life/components/register_modal.dart';
import 'package:sound_life/screens/dashboard.dart';
import 'package:sound_life/screens/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://iuwhqqszwwsfeagiytci.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1d2hxcXN6d3dzZmVhZ2l5dGNpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE0MzUwMzEsImV4cCI6MjA3NzAxMTAzMX0.h4Trqci82QK5_VA74gEARL4fBQvmvBE3XWwzcezri6c',
  );
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    checkSession(context);
    super.initState();
  }

  void checkSession(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final session = Supabase.instance.client.auth.currentSession;
    final user = session?.user;

    if (user != null && user.emailConfirmedAt != null) {
      Navigator.pushReplacementNamed(context, '/dashboard'); // Ruta corregida
    } else {
      showDialog(
        context: context,
        builder: (_) => const RegisterModal(),
      );
    }
  });
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sound Life',
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/dashboard': (context) => const Dashboard(),
      },
    );
  }
}
