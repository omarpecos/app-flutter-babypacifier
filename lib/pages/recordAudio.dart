import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'dart:async';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:path_provider/path_provider.dart';

class RecordAudioPage extends StatefulWidget {
  @override
  _RecordAudioPageState createState() => _RecordAudioPageState();
}

class _RecordAudioPageState extends State<RecordAudioPage> {

  AssetsAudioPlayer _myPlayer;
  FlutterAudioRecorder _recorder;
  int dirLength;
  Recording _recording;
  Timer _t;
  Widget _buttonIcon = Icon(Icons.do_not_disturb_on);

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _prepare();
      _myPlayer = new AssetsAudioPlayer();
    });
  }
  
  String dateFormat(){
    //hora en formato GMT + 1 -- por defecto es GMT 00
   var date = DateTime.now().add(Duration(hours: 1));
   var result = '${date.day}-${date.month}-${date.year}_${date.hour}-${date.minute}-${date.second}';
   return result;
  }

  void _opt() async {
    switch (_recording.status) {
      case RecordingStatus.Initialized:
        {
          await _startRecording();
          break;
        }
      case RecordingStatus.Recording:
        {
          await _stopRecording();
          break;
        }
      case RecordingStatus.Stopped:
        {
          await _prepare();
          break;
        }

      default:
        break;
    }

    // 刷新按钮
    setState(() {
      _buttonIcon = _playerIcon(_recording.status);
    });
  }


  Future _init() async {
    var hasPermission = await FlutterAudioRecorder.hasPermissions;
    if (hasPermission) {
      String customPath = '/records/record_';
      io.Directory appDocDirectory;
      if (io.Platform.isIOS) {
        appDocDirectory = await getApplicationDocumentsDirectory();
      } else {
        appDocDirectory = await getExternalStorageDirectory();
      }

      dirLength = appDocDirectory.path.length + '/records/'.length;

      // can add extension like ".mp4" ".wav" ".m4a" ".aac"
      customPath = appDocDirectory.path +
          customPath +
          dateFormat() + '.wav';
          //DateTime.now().millisecondsSinceEpoch.toString() + '.wav';
          //(DateTime.now().add(Duration(hours: 1))).toString() + '.wav';

      // .wav <---> AudioFormat.WAV
      // .mp4 .m4a .aac <---> AudioFormat.AAC
      // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.

      _recorder = FlutterAudioRecorder(customPath,
          audioFormat: AudioFormat.WAV, sampleRate: 22050);
      await _recorder.initialized;
    }
  }

  Future _prepare() async {
    await _init();
    var result = await _recorder.current();
    setState(() {
      _recording = result;
      _buttonIcon = _playerIcon(_recording.status);
    });
  }

  Future _startRecording() async {
    await _recorder.start();
    var current = await _recorder.current();
    setState(() {
      _recording = current;
    });

    _t = Timer.periodic(Duration(milliseconds: 10), (Timer t) async {
      var current = await _recorder.current();
      setState(() {
        _recording = current;
        _t = t;
      });
    });
  }

  Future _stopRecording() async {
    var result = await _recorder.stop();
    _t.cancel();

    setState(() {
      _recording = result;
    });
  }

  void _play() {
    if (_myPlayer != null){
      _myPlayer.dispose();
      _myPlayer = new AssetsAudioPlayer();
    }

    _myPlayer.open(
        Audio.file(_recording.path,
         metas: Metas(
          title: (_recording.path).substring( dirLength ),
          album: 'Grabaciones',
        )),
        showNotification: true
      );
  }

  void _pause() async{
   await _recorder.pause();
   var result = await _recorder.current();
  // _t.cancel();

   setState((){
     _recording = result;
   });
  }

  void _resume() async{
    await _recorder.resume();
    /*var current = await _recorder.current();
    setState(() {
      _recording = current;
    });*/

    _t = Timer.periodic(Duration(milliseconds: 10), (Timer t) async {
      var current = await _recorder.current();
     
     if(mounted)
      setState(() {
        _recording = current;
        _t = t;
      });
    });
  }

  Widget _playerIcon(RecordingStatus status) {
    switch (status) {
      case RecordingStatus.Initialized:
        {
          return Icon(Icons.fiber_manual_record);
        }
      case RecordingStatus.Recording:
        {
          return Icon(Icons.stop);
        }
      case RecordingStatus.Stopped:
        {
          return Icon(Icons.replay);
        }
      default:
        return Icon(Icons.do_not_disturb_on);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grabar'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Archivo',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${(_recording?.path)?.substring( dirLength )}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Duración',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${_recording?.duration}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Medición de dB',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${_recording?.metering?.averagePower}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   FlatButton(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                         Icon(Icons.play_arrow, color: Colors.black,),
                         Text('Reproducir'),
                      ],
                    ),
                    textColor: Colors.white,
                    color: Colors.grey.withOpacity(0.7),
                    disabledColor: Colors.grey.withOpacity(0.2),
                    onPressed: _recording?.status == RecordingStatus.Stopped
                        ? _play
                        : null,
                  ),
                   FlatButton(
                     padding: EdgeInsets.all(10),
                     child: Column(
                      children: [
                         Icon(Icons.pause, color: Colors.black,),
                         Text('Pausar'),
                      ],
                    ),
                    textColor: Colors.white,
                    color: Colors.grey.withOpacity(0.7),
                    disabledColor: Colors.grey.withOpacity(0.2),
                    onPressed: _recording?.status == RecordingStatus.Recording
                        ? _pause
                        : null,
                  ),
                   FlatButton(
                     padding: EdgeInsets.all(10),
                     child: Column(
                      children: [
                         Icon(Icons.assistant_direction, color: Colors.black,),
                         Text('Continuar'),
                      ],
                    ),
                    textColor: Colors.white,
                    color: Colors.grey.withOpacity(0.7),
                    disabledColor: Colors.grey.withOpacity(0.2),
                    onPressed: _recording?.status == RecordingStatus.Paused
                        ? _resume
                        : null,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _opt,
        child: _buttonIcon,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}