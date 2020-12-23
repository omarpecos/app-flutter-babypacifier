import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';
import 'package:noise_meter/noise_meter.dart';

class GifPage extends StatefulWidget {
  final path;
  final type;
  GifPage({this.path,this.type});

  @override
  _GifPageState createState() => _GifPageState(path: path, type : type);
}

class _GifPageState extends State<GifPage> with SingleTickerProviderStateMixin {
  
  final String path;
  final String type;
  double opacity;

  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;
  double maxDb = 60;
  double minDb = 20;

  
  _GifPageState({@required this.path, @required this.type});


  @override
  void initState() {
    super.initState();
    opacity = 1;
    _noiseMeter = new NoiseMeter(onError);
  }

  @override
  void dispose() {
    stopRecorder();
    super.dispose();
  }

  start() async {
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } on Exception catch (exception) {
      //print(exception);
    }
  }

  void onData(NoiseReading noiseReading) {
    double dbValue = noiseReading.maxDecibel;

    this.setState(() {
      if (!this._isRecording) {
        this._isRecording = true;
      }

      if (dbValue < minDb) {
        minDb = dbValue;
      } else if (dbValue > maxDb) {
        maxDb = dbValue;
      }

     // if (dbValue > minDb && dbValue < minDb + 20 || dbValue > maxDb - 20 && dbValue < maxDb) {
        var value = minDb / dbValue;
        if (value < 0.3)
          opacity = 0.1;
        else
          opacity = 1;
     // }
    });

    /// Do someting with the noiseReading object
    //print('>>> ' + dbValue.toString());
  }

  void onError(Exception e) {
      //print(e.toString());
    _isRecording = false;
  }

  stopRecorder() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
      // if(this.mounted)
      this.setState(() {
        this._isRecording = false;
        this.opacity = 1;
      });
    } catch (err) {
        //print('stopRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Opacity(
        opacity: opacity,
        child:
           type == 'url' ? 
            Image.network(
              path,
              fit: BoxFit.contain,
              height: double.infinity,
              width: double.infinity,
            ) 
            : 
            Image.file(
              File(path),
              fit: BoxFit.contain,
              height: double.infinity,
              width: double.infinity,
            ) ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: !_isRecording 
          ? () => start() : () => stopRecorder(),
        child:
            !_isRecording
               ? Icon(Icons.hearing) : Icon(Icons.hearing_disabled),
      ),
    );
  }
}
