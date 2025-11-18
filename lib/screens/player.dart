import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_music_player/data/songs.dart';
import 'package:new_music_player/providers/mode_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_music_player/providers/song_started_provider.dart';

class PlayerScreen extends ConsumerStatefulWidget {
  const PlayerScreen({super.key, required this.songIndex});

  final int songIndex;

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  final player = AudioPlayer();

  void setAndPlayInitialMusic() async {
    final playlist = <AudioSource>[
      AudioSource.uri(Uri.parse('https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3')),
      AudioSource.uri(Uri.parse('https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Sevish_-__nbsp_.mp3')),
      AudioSource.uri(Uri.parse('https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg')),
    ];
    // Load the playlist
    await player.setAudioSources(
      playlist,
      initialIndex: 0,
      initialPosition: Duration.zero, // Load each item just in time
      shuffleOrder: DefaultShuffleOrder(), // Customise the shuffle algorithm
    );
    if (widget.songIndex != player.currentIndex){
      player.pause();
      player.seek(Duration.zero,index: widget.songIndex);  
      player.play();
    }else{
      if (player.playing){
        print('----------------ooooo');
        return;
      }else{
        player.play();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setAndPlayInitialMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
        title: const Text(
          'PLAYER',
          style: TextStyle(
            letterSpacing: 7,
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                    elevation: 8.0,
                    child: Container(
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
                      child: Center(
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 8,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                      image: AssetImage('assets/ocean.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 20,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'In My Heart',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: ref.watch(isDarkmodeProvider)
                                                ? Colors.white.withValues(
                                                    alpha: 0.3,
                                                  )
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      const Flexible(
                                        child: Text(
                                          'Acid',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '0:00',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.shuffle,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.repeat,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '3:00',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text('seek goes here'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 35,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      clipBehavior: Clip.hardEdge,
                      elevation: 10,
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
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.skip_previous,
                              color: ref.watch(isDarkmodeProvider)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          ref.watch(songStartedProvider)
                              ? player.pause()
                              : player.play();

                          ref
                              .read(songStartedProvider.notifier)
                              .changeSongStartedMode(
                                !ref.watch(songStartedProvider),
                              );
                        },
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          elevation: 10,
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
                            width: double.infinity,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                child: ref.watch(songStartedProvider)
                                    ? Icon(
                                        Icons.pause,
                                        color: ref.watch(isDarkmodeProvider)
                                            ? Colors.white
                                            : Colors.black,
                                      )
                                    : Icon(
                                        Icons.play_arrow,
                                        color: ref.watch(isDarkmodeProvider)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.hardEdge,
                      elevation: 10,
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
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.skip_next,
                              color: ref.watch(isDarkmodeProvider)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
