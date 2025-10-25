import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_music_player/screens/playlist.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: PlaylistScreen(),
      ),
    ),
  );
}
