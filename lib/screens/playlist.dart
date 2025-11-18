import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_music_player/providers/mode_provider.dart';
import 'package:new_music_player/screens/player.dart';
import 'package:new_music_player/widgets/drawer.dart';

class PlaylistScreen extends ConsumerWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ref.watch(isDarkmodeProvider)
          ? Colors.black
          : Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: ref.watch(isDarkmodeProvider)
              ? const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 58, 58, 58),
                      Colors.black,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                )
              : null,
        ),
        centerTitle: true,
        title: const Text(
          'PLAYLIST',
          style: TextStyle(
            letterSpacing: 7,
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const SideDrawer(),
      body: Container(
        decoration: ref.watch(isDarkmodeProvider)
            ? const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 58, 58, 58),
                    Color.fromARGB(255, 0, 0, 0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              )
            : null,
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerScreen(songIndex: index,),)),
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: const DecorationImage(
                    image: AssetImage('assets/ocean.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                'ACID',
              ),
              subtitle: Text(
                'In My Heart',
              ),
              titleTextStyle: TextStyle(
                color: ref.watch(isDarkmodeProvider) ? Colors.white : Colors.grey,
                fontSize: 14,
              ),
              subtitleTextStyle: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            );
          },
        ),
      ),
    );
  }
}
