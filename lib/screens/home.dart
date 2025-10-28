import 'package:flutter/material.dart';
import 'package:sound_life/screens/dashboard.dart';
import 'package:sound_life/screens/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

var screen = 0;

List<Widget> paginas = [
  Dashboard(),
  Profile()
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: paginas[screen],

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            screen = index;
          });
        },
        selectedItemColor: Colors.purple,
        currentIndex: screen,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_2), label: 'Profile'),
        ],
      ),
    );
  }
}