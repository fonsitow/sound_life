import 'package:flutter/material.dart';
import 'package:sound_life/screens/home.dart';
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sound Life',
      home: Home(),
    );
  }
}
