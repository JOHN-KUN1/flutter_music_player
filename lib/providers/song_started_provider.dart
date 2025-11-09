import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

// final player = AudioPlayer();

final songStartedProvider = NotifierProvider<SongStartedNotifier, bool>(() {
  return SongStartedNotifier();
});

class SongStartedNotifier extends Notifier<bool> {
  @override
  bool build() {
    return state = true;
  }

  void changeSongStartedMode(bool value) {
    state = value;
  }

  void setMusic() async {
    
  }
}
