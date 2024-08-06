// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

// class MusicWidget extends StatefulWidget {
//   const MusicWidget({super.key});

//   @override
//   State<MusicWidget> createState() => _MusicWidgetState();
// }

// class _MusicWidgetState extends State<MusicWidget> {
//   String musicUrl = "https://drive.google.com/uc?export=download&id=1laa-cfh6ReJNQ-rv-_jSwWcrhtLGBlYy"; // Direct download link
//   String thumbnailImgUrl = "https://user-images.githubusercontent.com/103574856/284043171-92d46587-43eb-4e6d-a180-77485083878e.jpg"; // Thumbnail URL
//   var player = AudioPlayer();
//   bool loaded = false;
//   bool playing = false;

//   void loadMusic() async {
//     await player.setUrl(musicUrl);
//     setState(() {
//       loaded = true;
//       playing = true;
//     });
//     player.play();
//   }

//   void playMusic() async {
//     setState(() {
//       playing = true;
//     });
//     await player.play();
//   }

//   void pauseMusic() async {
//     setState(() {
//       playing = false;
//     });
//     await player.pause();
//   }

//   @override
//   void initState() {
//     loadMusic();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: StreamBuilder<Duration>(
//               stream: player.positionStream,
//               builder: (context, snapshot1) {
//                 final duration = snapshot1.data ?? Duration.zero;
//                 return StreamBuilder<Duration>(
//                   stream: player.bufferedPositionStream,
//                   builder: (context, snapshot2) {
//                     final bufferedDuration = snapshot2.data ?? Duration.zero;
//                     return SizedBox(
//                       height: 30,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: ProgressBar(
//                           progress: duration,
//                           total: player.duration ?? Duration.zero,
//                           buffered: bufferedDuration,
//                           timeLabelPadding: -1,
//                           timeLabelTextStyle: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.black,
//                           ),
//                           progressBarColor: Colors.red,
//                           baseBarColor: Colors.grey[200],
//                           bufferedBarColor: Colors.grey[350],
//                           thumbColor: Colors.red,
//                           onSeek: loaded
//                               ? (duration) async {
//                                   await player.seek(duration);
//                                 }
//                               : null,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const SizedBox(width: 10),
//               IconButton(
//                 onPressed: loaded
//                     ? () async {
//                         if (player.position.inSeconds >= 10) {
//                           await player.seek(Duration(seconds: player.position.inSeconds - 10));
//                         } else {
//                           await player.seek(Duration.zero);
//                         }
//                       }
//                     : null,
//                 icon: const Icon(Icons.fast_rewind_rounded),
//               ),
//               Container(
//                 height: 50,
//                 width: 50,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.red,
//                 ),
//                 child: IconButton(
//                   onPressed: loaded
//                       ? () {
//                           if (playing) {
//                             pauseMusic();
//                           } else {
//                             playMusic();
//                           }
//                         }
//                       : null,
//                   icon: Icon(
//                     playing ? Icons.pause : Icons.play_arrow,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               IconButton(
//                 onPressed: loaded
//                     ? () async {
//                         if (player.position.inSeconds + 10 <= player.duration!.inSeconds) {
//                           await player.seek(Duration(seconds: player.position.inSeconds + 10));
//                         } else {
//                           await player.seek(Duration.zero);
//                         }
//                       }
//                     : null,
//                 icon: const Icon(Icons.fast_forward_rounded),
//               ),
//               const SizedBox(width: 10),
//             ],
//           ),
//           const Spacer(flex: 2),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class MusicWidget extends StatefulWidget {
  const MusicWidget({super.key});

  @override
  State<MusicWidget> createState() => _MusicWidgetState();
}

class _MusicWidgetState extends State<MusicWidget> {
  final String localMusicPath = "assets/music/hare-krishna.mp3";
  final String thumbnailImgUrl =
      "https://user-images.githubusercontent.com/103574856/284043171-92d46587-43eb-4e6d-a180-77485083878e.jpg";
  final AudioPlayer player = AudioPlayer();
  bool loaded = false;
  bool playing = false;

  void loadMusic() async {
    await player.setAsset(localMusicPath);
    setState(() {
      loaded = true;
      playing = true;
    });
    player.play();
  }

  void playMusic() async {
    setState(() {
      playing = true;
    });
    await player.play();
  }

  void pauseMusic() async {
    setState(() {
      playing = false;
    });
    await player.pause();
  }

  @override
  void initState() {
    loadMusic();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: StreamBuilder<Duration>(
              stream: player.positionStream,
              builder: (context, snapshot1) {
                final duration = snapshot1.data ?? Duration.zero;
                return StreamBuilder<Duration>(
                  stream: player.bufferedPositionStream,
                  builder: (context, snapshot2) {
                    final bufferedDuration = snapshot2.data ?? Duration.zero;
                    return SizedBox(
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ProgressBar(
                          progress: duration,
                          total: player.duration ?? Duration.zero,
                          buffered: bufferedDuration,
                          timeLabelPadding: -1,
                          timeLabelTextStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          progressBarColor:
                              const Color.fromARGB(255, 218, 142, 11),
                          baseBarColor: Colors.grey[200],
                          bufferedBarColor: Colors.grey[350],
                          thumbColor: const Color.fromARGB(255, 218, 142, 11),
                          onSeek: loaded
                              ? (duration) async {
                                  await player.seek(duration);
                                }
                              : null,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 10),
              IconButton(
                onPressed: loaded
                    ? () async {
                        if (player.position.inSeconds >= 10) {
                          await player.seek(Duration(
                              seconds: player.position.inSeconds - 10));
                        } else {
                          await player.seek(Duration.zero);
                        }
                      }
                    : null,
                icon: const Icon(Icons.fast_rewind_rounded),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 218, 142, 11),
                ),
                child: IconButton(
                  onPressed: loaded
                      ? () {
                          if (playing) {
                            pauseMusic();
                          } else {
                            playMusic();
                          }
                        }
                      : null,
                  icon: Icon(
                    playing ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: loaded
                    ? () async {
                        if (player.position.inSeconds + 10 <=
                            player.duration!.inSeconds) {
                          await player.seek(Duration(
                              seconds: player.position.inSeconds + 10));
                        } else {
                          await player.seek(Duration.zero);
                        }
                      }
                    : null,
                icon: const Icon(Icons.fast_forward_rounded),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
