import 'package:flutter/material.dart';

import 'package:baby_pacifier/models/SoundModel.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Sounds extends StatefulWidget {
  @override
  _SoundsState createState() => _SoundsState();
}

class _SoundsState extends State<Sounds> {

AssetsAudioPlayer _myPlayer = new AssetsAudioPlayer();

void play(String path,String name){
    _myPlayer.open(
      Audio(
        path,
        metas: Metas(
          title: name,
          album: 'Sonidos',
        )
      ),
      loopMode: LoopMode.playlist,
      showNotification: true,
  );
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 130.0,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: soundData.length,
        itemBuilder: (context, i) => Card(
              color: Colors.lightBlue[300],
              child: InkWell(
                onTap: () => play(soundData[i].path,soundData[i].name),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage(soundData[i].icon), width: 50,height: 50,),
                    Padding(padding: EdgeInsets.all(5)),
                    Text(soundData[i].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
            )
          ),
    );
  }
}
