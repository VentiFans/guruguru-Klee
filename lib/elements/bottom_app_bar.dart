import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:guruguru_klee_flutter/main.dart';

import 'package:guruguru_klee_flutter/models/character_model.dart';
import 'package:provider/provider.dart';

class BottomAppBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomAppBarState();
  }
}

class BottomAppBarState extends State<BottomAppBarWidget> {
  bool isNowPlaying = false;
  AudioPlayer player = AudioPlayer();
  Future playMusic(int index) async {
    player.play(AssetSource(
        "${ChModel.characters[index].engName}/music/song.mp3"));
  }

  Future pauseMusic() async {
    player.stop();
  }

  @override
  Widget build(BuildContext context) {
    int nowIndex = Provider.of<ChData>(context, listen: true).nowCharacterIndex;
    return BottomAppBar(
      child: Row(
        children: <Widget>[
          IconButton(
              tooltip: 'Play Arrow',
              onPressed: () {
                setState(() {
                  isNowPlaying = !isNowPlaying;
                  if(isNowPlaying){
                    playMusic(nowIndex);
                  }else{
                    pauseMusic();
                  }
                  print(nowIndex);
                });
              },
              icon: Icon(isNowPlaying ? Icons.pause : Icons.play_arrow)),
          const IconButton(
            tooltip: 'Rule',
            icon: Icon(Icons.rule),
            onPressed: null,
          ),
          const IconButton(
            tooltip: 'Public',
            icon: Icon(Icons.public),
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
