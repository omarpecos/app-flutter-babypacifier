import 'package:flutter/material.dart';

import 'package:baby_pacifier/models/SoundModel.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';

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
      loopMode: LoopMode.single,
      showNotification: true,
  );
}

void playStream(String streamUrl, String name) async{
  try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
         //toast
          Scaffold.of(context).showSnackBar(
            SnackBar(
              duration : Duration(seconds: 1),
              content: Text('Cargando estación de radio ...'),
            )
          );
      }else{
         throw new Error();
      }
      await _myPlayer.open(
          Audio.liveStream( streamUrl ,
            metas : Metas(
              title: name,
              album: 'Streaming'
            )
          ),
          showNotification: true,
      );
  } catch (t) {
     // await _myPlayer.updateCurrentAudioNotification(showNotifications: false);
      //toast
          Scaffold.of(context).showSnackBar(
            SnackBar(
              duration : Duration(seconds: 5),
              content: Text('Se ha producido un error. Conéctese a internet o inténtelo de nuevo'),
            )
          );
  }
}

@override
  void dispose() {
    _myPlayer.dispose();
      //print("dispose - sounds");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.all(10),
        children: [
          Text('Naturaleza', textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey[700], fontSize: 25)),
           GridView.builder(
             padding: EdgeInsets.only(top : 10),
              primary: false,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150.0,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: soundDataLocal.length,
              itemBuilder: (context, i) => Card(
                    color: Colors.lightBlue[300],
                    child: InkWell(
                      onTap: () => play(soundDataLocal[i].path,soundDataLocal[i].name),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(soundDataLocal[i].icon), width: 50,height: 50,),
                                Padding(padding: EdgeInsets.all(5)),
                                Flexible(
                                  child : AutoSizeText(soundDataLocal[i].name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                    maxLines: 2,
                                  )
                                ),
                              ],
                          ),
                      )
                    ),
                  )
              ),

            Padding(padding: EdgeInsets.all(10)),

             Text('Ruido Blanco / Canciones', textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey[700], fontSize: 25)),
                GridView.builder(
                  padding: EdgeInsets.only(top : 10),
                    primary: false,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150.0,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: whiteSoundDataLocal.length,
                    itemBuilder: (context, i) => Card(
                          color: Colors.lightBlue[300],
                          child: InkWell(
                            onTap: () => play(whiteSoundDataLocal[i].path,whiteSoundDataLocal[i].name),
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(image: AssetImage(whiteSoundDataLocal[i].icon), width: 50,height: 50,),
                                      Padding(padding: EdgeInsets.all(5)),
                                      Flexible(
                                        child : AutoSizeText(whiteSoundDataLocal[i].name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white, fontSize: 18),
                                          maxLines: 2,
                                        )
                                      ),
                                    ],
                                ),
                            )
                          ),
                        )
                    ),

            Padding(padding: EdgeInsets.all(10)),

            Text('Radio por Internet', textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey[700], fontSize: 25)),
             GridView.builder(
               padding: EdgeInsets.only(top : 10),
                primary: false,
               shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: soundDataStream.length,
                itemBuilder: (context, i) => Card(
                      color: Colors.lightBlue[300],
                      child: InkWell(
                        onTap: () => playStream(soundDataStream[i].path, soundDataStream[i].name),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(soundDataStream[i].icon),width: 75,),
                                Padding(padding: EdgeInsets.all(5)),
                                Flexible(
                                  child : AutoSizeText(soundDataStream[i].name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white, fontSize: 26),
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            ),
                        )
                      ),
                    )
              ),
        ],
    );
  }
}
