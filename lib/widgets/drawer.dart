import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_music_player/providers/mode_provider.dart';
import 'package:new_music_player/screens/settings.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Container(
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
        child: Center(
          child: Column(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.music_note,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              const ListTile(
                title: Text(
                  'HOME',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                leading: Icon(Icons.home),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
                title: const Text(
                  'SETTINGS',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                leading: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
