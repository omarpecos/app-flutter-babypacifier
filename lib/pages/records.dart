import 'package:baby_pacifier/pages/recordAudio.dart';
import 'package:flutter/material.dart';

import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';


class Records extends StatefulWidget {
  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  String directory;
  int dirLength;
  List files = new List();
  AssetsAudioPlayer _myPlayer = new AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    
      _listofRecords();
  }

   _createDir(io.Directory dir) async{
    final path = io.Directory(dir.path + '/records');

    if ((await path.exists())){
        //print("exist Records folder");
    }else{
        //print("not exist Records folder");
        path.create();
    }
  }

  void _listofRecords() async {

    io.Directory appDocDirectory;

    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = await getExternalStorageDirectory();
    }

    _createDir(appDocDirectory);
    io.Directory recordsDirectory = io.Directory("${appDocDirectory.path}/records/");

  if(mounted)
    setState(() {
      if (recordsDirectory.existsSync())
        files = recordsDirectory.listSync();
      dirLength = appDocDirectory.path.length + '/records/'.length;
    });
      // print('/storage/emulated/0/Android/data/com.omarpv.babypacifier/files/'.length);
  }

  String _formatPath(String path){
    return path.substring( dirLength );
  }

   void _play(String filePath) {
     if (_myPlayer != null){
      _myPlayer.dispose();
      _myPlayer = new AssetsAudioPlayer();
     }
    
    _myPlayer.open(
        Audio.file(filePath,
         metas: Metas(
          title: _formatPath(filePath),
          album: 'Grabaciones',
        )),
        loopMode: LoopMode.single,
        showNotification: true,
      );
  }

  @override
  void dispose() {
    _myPlayer.dispose();
      //print("dispose - records");
    super.dispose();
  }


  void _showDeleteConfirmation(io.File file){
    AlertDialog dialog = new AlertDialog(
      content : ListTile(
        leading: Icon(Icons.delete),
        title : Text('Confirmación'),
        subtitle: Text('¿Desea eliminar realmente la grabacion "${(file.path).substring(dirLength)}"'),
      ),
      actions: [
        FlatButton(
          onPressed: () => _deleteFile(file),
          child: Text('Eliminar')
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar')
        ),
      ],
    );

    showDialog(context: context, child : dialog);
  }

   void _deleteFile(io.File file) async {
        try {
          //final file = await _localFile;

          await file.delete();

          Navigator.of(context).pop();

          //toast
          Scaffold.of(context).showSnackBar(
            SnackBar(
              duration : Duration(seconds: 5),
              content: Text('Se ha eliminado el archivo correctamente'),
            )
          );

          //reloadData
          _listofRecords();

        } catch (e) {
          Navigator.of(context).pop();
           //toast
          Scaffold.of(context).showSnackBar(
            SnackBar(
              duration : Duration(seconds: 5),
              content: Text('Ha ocurrido un error y no se ha podido eliminar'),
            )
          );
        } 
      }

  void _showRenameInput(io.File file){
    String nameFile = (file.path).substring(dirLength);
    List<String> values = nameFile.split('.');
    String name = values[0];
    String ext = values[1];

    TextEditingController textEditingController = new TextEditingController();
    textEditingController.text = name;


    AlertDialog dialog = new AlertDialog(
          content : Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Cambiar el nombre', style: TextStyle(fontSize: 20),),
                Padding(padding: EdgeInsets.all(20)),
                Text('Introduce el nuevo nombre', style: TextStyle(fontSize: 15, color: Colors.grey)),
                TextField(
                  controller : textEditingController,
                )
              ],
            )
          ),
          
          actions: [
            FlatButton(
              onPressed: () => _renameFile(file, textEditingController.text + '.' + ext),
              child: Text('Renombrar')
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar')
            ),
          ],
        );

    showDialog(context: context, child : dialog);
  }
  void _renameFile(io.File file, String newName) async{
    String dir;

    if (io.Platform.isIOS) {
      dir= (await getApplicationDocumentsDirectory()).path;
    } else {
      dir = (await getExternalStorageDirectory()).path;
    }

    String newPath = dir + '/records/' + newName;
    try {
      //crea el nuevo archivo
      await file.copy(newPath);
      //elimina el archivo antiguo
      await file.delete();

      Navigator.of(context).pop();
      _listofRecords();

      //toast
        Scaffold.of(context).showSnackBar(
          SnackBar(
            duration : Duration(seconds: 5),
            content: Text('Se ha cambiado el nombre'),
          )
        );
    } catch (e) {
       Navigator.of(context).pop();
      Scaffold.of(context).showSnackBar(
            SnackBar(
              duration : Duration(seconds: 5),
              content: Text('Ha ocurrido un error y no se ha podido cambiar el nombre'),
            )
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(10)),
        RaisedButton(
            padding: EdgeInsets.all(10),
            color: Colors.blueAccent,
            child: Column(
              children: [
                 Icon(
                  Icons.fiber_manual_record,
                  color: Colors.white,
                ),
                 Text(
                  'Grabar nuevo',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color : Colors.white),
                ),
              ],
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                    builder: (context) => RecordAudioPage()
              )
            ).then((value){
              //print('>>> RETURNED FROM GRABAR');
               _myPlayer.dispose();
               setState(() {
                 _myPlayer = new AssetsAudioPlayer();
               });
             
              _listofRecords();
            })
        ),
        Padding(padding: EdgeInsets.only(bottom: 20)),

        if (files.length == 0)
          Text('NO HAY GRABACIONES', textAlign: TextAlign.center,)
        else
          Expanded(
              child: ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, i) => ListTile(
                          leading: Icon(Icons.record_voice_over_sharp),
                          title: Text( _formatPath(files[i].path) ),
                          trailing:  
                              Container(
                                width: 150,
                                child : Row(
                                  children: [
                                    IconButton(icon: Icon(Icons.play_arrow), onPressed: () =>  _play(files[i].path) ),
                                    IconButton(icon: Icon(Icons.edit), onPressed: () => _showRenameInput( files[i]) ),
                                    IconButton(icon: Icon(Icons.delete), onPressed: () => _showDeleteConfirmation( files[i]) ),
                                  ],
                                ),
                          ),
                        )
                    )
              )
      ],
    );
  }
}
