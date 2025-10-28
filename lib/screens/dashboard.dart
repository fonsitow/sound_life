import 'package:flutter/material.dart';
import 'package:sound_life/components/appbar_custom.dart';
import 'package:sound_life/components/drawer_custom.dart';
import 'package:sound_life/styles/styles.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Widget> screens = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerCustom(),
      appBar: customAppBar(),
      body: Column(),
    );
  }
}
