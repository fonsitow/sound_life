import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:sound_life/screens/dashboard.dart';
import 'package:sound_life/screens/favorite.dart';
import 'package:sound_life/screens/search.dart';
import 'package:sound_life/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

bool selected = false;
var screen = 0;

List<Widget> paginas = [Dashboard(), SearchPage(), Favoritos()];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginas[screen],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: CustomStyles().textomini,
        unselectedLabelStyle: CustomStyles().textomini,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            screen = index;
            if (index == 2) {
              selected = false;
            } else {
              selected = true;
            }
          });
        },
        selectedItemColor: Colors.purple,
        currentIndex: screen,
        items: [
          BottomNavigationBarItem(icon: Icon(Pixel.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Pixel.search), label: 'Search'),
          BottomNavigationBarItem(  icon: Icon(selected ? Pixel.moon : Pixel.moonstar),label: 'Favorite',),
        ],
      ),
    );
  }
}
