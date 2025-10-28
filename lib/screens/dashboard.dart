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
      body: FeedList()
    );
  }
}


class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(10, (index) => 'Elemento #$index');

    return RefreshIndicator(
      onRefresh: () async {
        // Simula recarga
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return FeedCard(title: items[index]);
        },
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  final String title;

  const FeedCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.dashboard)),
        title: Text(title),
        subtitle: const Text('Descripción breve del contenido'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Acción al tocar
        },
      ),
    );
  }
}