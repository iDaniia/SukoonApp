import 'package:flutter/material.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DeviceInstr extends StatefulWidget {
  const DeviceInstr({super.key});

  @override
  State<DeviceInstr> createState() => _DeviceInstrState();
}

class _DeviceInstrState extends State<DeviceInstr> {
  final videoURL = "https://www.youtube.com/watch?v=oRFiHhm-mQc";
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final viedoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
        initialVideoId: viedoID!,
        flags: const YoutubePlayerFlags(autoPlay: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: 236,
            decoration: const BoxDecoration(color: Color(darkBlue), boxShadow: [
              BoxShadow(
                color: Color(darkerGray),
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(0, 2),
              )
            ]),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                /*
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: Color(lightBlue1),
                      iconSize: 30,
                    ),
                  ),
                ),
                */
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.settings_outlined),
                      color: Color(lightBlue1),
                      iconSize: 30,
                    ),
                  ),
                ),
                const Text(
                  "Instruction Device",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "5 ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "rounds",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "10 ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "min each",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "How to fit headband Muse? ",
                style: TextStyle(
                    color: Color(darkBlue),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () => debugPrint('Ready'),
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(
                    isExpanded: true,
                    colors: const ProgressBarColors(
                      playedColor: Colors.amber,
                      handleColor: Colors.amberAccent,
                    ),
                  ),
                  const PlaybackSpeedButton()
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
