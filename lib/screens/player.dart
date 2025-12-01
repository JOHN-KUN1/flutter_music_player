import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_music_player/providers/loop_provider.dart';
import 'package:new_music_player/providers/mode_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_music_player/providers/player_provider.dart';
import 'package:new_music_player/providers/shuffle_provider.dart';

class PlayerScreen extends ConsumerStatefulWidget {
  const PlayerScreen({super.key, required this.songIndex});

  final int songIndex;

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  bool songPlaying = true;
  int currentLoopState = 0;

  void setAndPlayInitialMusic() async {
    if (ref.watch(playerProvider).audioSource == null) {
      final playlist = <AudioSource>[
        AudioSource.uri(
          Uri.parse(
            'https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3',
          ),
        ),
        AudioSource.uri(
          Uri.parse(
            'https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Sevish_-__nbsp_.mp3',
          ),
        ),
        AudioSource.uri(
          Uri.parse(
            'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg',
          ),
        ),
      ];
      await ref
          .watch(playerProvider)
          .setAudioSources(
            playlist,
            initialIndex: widget.songIndex,
            initialPosition: Duration.zero, // Load each item just in time
            shuffleOrder:
                DefaultShuffleOrder(), // Customise the shuffle algorithm
          );
      await ref.watch(playerProvider).play();
    } else {
      // Load the playlist
      if (widget.songIndex != ref.watch(playerProvider).currentIndex) {
        await ref.watch(playerProvider).pause();
        await ref
            .watch(playerProvider)
            .seek(Duration.zero, index: widget.songIndex);
        await ref.watch(playerProvider).play();
      } else {
        if (ref.watch(playerProvider).playing) {
          return;
        } else {
          await ref.watch(playerProvider).play();
        }
      }
    }
    // var duration = await ref.watch(playerProvider).positionStream.last;
    // songD = duration.inSeconds.toDouble();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '0:00',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    IconButton(
                      onPressed: () async {
                        ref.read(shuffleProvider.notifier).shuffleActive(!ref.watch(shuffleProvider));
                        await ref.watch(playerProvider).setShuffleModeEnabled(ref.watch(shuffleProvider));
                      },
                      icon: Icon(
                        Icons.shuffle,
                        color: ref.watch(shuffleProvider) ? Colors.lightBlue : Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () async{
                        ref.read(loopProvider.notifier).loopActive(true);
                        currentLoopState++;
                        if (currentLoopState == 1){
                          await ref.watch(playerProvider).setLoopMode(LoopMode.all);
                        }else if(currentLoopState == 2){
                          await ref.watch(playerProvider).setLoopMode(LoopMode.one);
                          setState(() {
                            //
                          });
                        }else if (currentLoopState == 3){
                          await ref.watch(playerProvider).setLoopMode(LoopMode.off);
                          ref.read(loopProvider.notifier).loopActive(false);
                          currentLoopState = 0;
                        }
                      },
                      icon: Icon(
                        currentLoopState == 2 ? Icons.repeat_one : Icons.repeat,
                        color: ref.watch(loopProvider) ? Colors.lightBlue : Colors.grey,
                      ),
                    ),
                    // Text(
                    //   '${ref.watch(playerProvider).duration.toString().substring(2,4)}:${ref.watch(playerProvider).duration.toString().substring(5,7)}',
                    //   style: TextStyle(fontSize: 14, color: Colors.grey),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  left: 20.0,
                  right: 20.0,
                ),

                // child: Slider(value: _currentSliderValue, onChanged: (value) {
                //   setState(() {
                //     ref.watch(playerProvider).positionStream
                //     _currentSliderValue = value;

                //   });
                // },),

                //TODO: MAKE IT SO THAT WHEN THE SEEK SLIDER IS MOVED AND THE MUSIC CONTINUES PLAYING 
                //THE SEEK SLIDER ALSO ANIMATES THE PLAY PROGRESS TOO.
                
                child: StreamBuilder(
                  stream: ref.watch(playerProvider).positionStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Slider(
                        value:
                            snapshot.data?.inSeconds.toDouble() ?? 0.0,
                        max:
                            ref
                                .watch(playerProvider)
                                .duration
                                ?.inSeconds
                                .toDouble() ??
                            800,
                        onChanged: (value) async {
                          await ref
                              .watch(playerProvider)
                              .seek(Duration(seconds: value.toInt()));
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
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
                    InkWell(
                      onTap: () async {
                        await ref.watch(playerProvider).seekToPrevious();
                        if (ref.watch(playerProvider).playing) {
                          return;
                        } else {
                          setState(() {
                            songPlaying = !songPlaying;
                          });
                          ref.watch(playerProvider).play();
                        }
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
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          songPlaying
                              ? ref.watch(playerProvider).pause()
                              : ref.watch(playerProvider).play();

                          setState(() {
                            songPlaying = !songPlaying;
                          });
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
                                child: songPlaying
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
                    InkWell(
                      onTap: () async {
                        await ref.watch(playerProvider).seekToNext();
                        if (ref.watch(playerProvider).playing) {
                          return;
                        } else {
                          setState(() {
                            songPlaying = !songPlaying;
                          });
                          ref.watch(playerProvider).play();
                        }
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
