import 'package:flutter/material.dart';
import 'package:sound_life/components/appbar_custom.dart';
import 'package:sound_life/components/drawer_custom.dart';
import 'package:sound_life/services/auth_services.dart';
import 'package:sound_life/styles/styles.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerCustom(),
      appBar: customAppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            DashboardHeader(),
            SectionTitle(title: 'Tus playlists'),
            HorizontalScroller(items: ['Rock', 'Jazz', 'Pop']),
            SectionTitle(title: 'Artistas que sigues'),
            HorizontalScroller(items: ['Queen', 'Adele', 'Bad Bunny']),
            SectionTitle(title: 'Recomendado para ti'),
            HorizontalScroller(items: ['Lo-fi', 'Indie', 'Electrónica']),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Text(
            title,
            style: CustomStyles().textoSubtitulo
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              // Acción de "Ver todo"
            },
            child: const Text(
              'Ver todo',
              style: TextStyle(color: Color.fromARGB(255, 240, 105, 220), fontFamily: 'KiwiSoda'),
            ),
          ),
        ],
      ),
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

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {

  final authService = AuthServices();
  final profile = authService.emailUser();

    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('assets/user.jpg'),
        ),
        const SizedBox(width: 12),
        Text(
          'Hola, $profile',
          style: CustomStyles().textoSimple,
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}

class HorizontalScroller extends StatelessWidget {
  final List<String> items;

  const HorizontalScroller({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Container(
            width: 140,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/cover_${index + 1}.jpg'),
                fit: BoxFit.cover,
                colorFilter: const ColorFilter.mode(
                  Colors.black45,
                  BlendMode.darken,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  items[index],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
