import 'package:flutter/material.dart';
import 'package:baby_pacifier/models/GifModel.dart';
import 'package:baby_pacifier/pages/gifPage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:images_picker/images_picker.dart';

class Animations extends StatefulWidget {
  @override
  _AnimationsState createState() => _AnimationsState();
}

class _AnimationsState extends State<Animations> {
  List gifs = new List();
  int dirLength;
  bool internetConnection = false;

  _openGifPage(String path, String type) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => GifPage(path: path, type : type)));
  }

  void _testInternetConnection() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internetConnection = true;
      } else {
        internetConnection = false;
      }
    } catch (t) {
      // some error
    }
  }

  @override
  void initState() {
    super.initState();
    _testInternetConnection();
    _listOfGifs();
  }

  Future getImage() async {
    List<Media> res =
        await ImagesPicker.pick(count: 1, pickType: PickType.image, gif: true);

    var path = res[0]?.path;
    //print(path);
    var ext = path.substring(path.length - 3);
    //print(ext);

    if (ext == 'gif') {
      try {
        Directory dir;

        if (Platform.isIOS) {
          dir = await getApplicationDocumentsDirectory();
        } else {
          dir = await getExternalStorageDirectory();
        }

        File file = File(path);
        await file.copy(dir.path +
            '/gifs/' +
            DateTime.now().millisecondsSinceEpoch.toString() +
            '.gif');
        await file.delete();

        _listOfGifs();
      } catch (e) {
        //print(e.toString());

        Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          content:
              Text('Se ha producido un error. No se ha podido añadir el gif'),
        ));
      }
    }
  }

  _createDir(Directory dir) async {
    final path = Directory(dir.path + '/gifs');

    if ((await path.exists())) {
      //print("exist gifs folder");
    } else {
      //print("not exist gifs folder");
      path.create();
    }
  }

  void _listOfGifs() async {
    Directory appDocDirectory;

    if (Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = await getExternalStorageDirectory();
    }

    _createDir(appDocDirectory);
    Directory gifsDirectory = Directory("${appDocDirectory.path}/gifs/");
    if (mounted)
      setState(() {
        if (gifsDirectory.existsSync()) gifs = gifsDirectory.listSync();
        dirLength = appDocDirectory.path.length + '/gifs/'.length;
      });
  }

   void _showDeleteConfirmation(File file){
    AlertDialog dialog = new AlertDialog(
      content : ListTile(
        leading: Icon(Icons.delete),
        title : Text('Confirmación'),
        subtitle: Text('¿Desea eliminar realmente el gif de nombre "${(file.path).substring(dirLength)}"'),
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

   void _deleteFile(File file) async {
        try {

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
          _listOfGifs();

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

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            RaisedButton(
                padding: EdgeInsets.all(10),
                color: Colors.blueAccent,
                onPressed: () => getImage(),
                child: Column(children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    'Subir nuevo GIF',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ])),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
            ),
            Text('Gifs de internet',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey[700], fontSize: 25)),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
            ),
            ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: gifDataUrl.length,
                itemBuilder: (context, i) => ListTile(
                      contentPadding: EdgeInsets.all(5),
                      leading: Image.network(
                        gifDataUrl[i].path,
                        width: 100,
                        height: 100,
                        errorBuilder: (context, exception, stackTrace) =>
                            //Image.asset('assets/images/fire.png')
                            Icon(Icons.error, color: Colors.red),
                      ),
                      title: Text(gifDataUrl[i].name),
                      trailing: IconButton(
                        onPressed: internetConnection ? 
                          () => _openGifPage(gifDataUrl[i].path, 'url') : null,
                        icon: Icon(Icons.remove_red_eye),
                      ),
                    )),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            Text('Gifs Subidos',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey[700], fontSize: 25)),
            if (gifs.length == 0)
              Text(
                'NO HAY GIFS',
                textAlign: TextAlign.center,
              )
            else
              Padding(
                padding: EdgeInsets.only(bottom: 15),
              ),
            ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: gifs.length,
                itemBuilder: (context, i) => ListTile(
                      contentPadding: EdgeInsets.all(5),
                      leading: Image.file(gifs[i], width: 100, height: 100),
                      title: Text((gifs[i].path).substring(dirLength)),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => _openGifPage(gifs[i].path, 'file'),
                              icon: Icon(Icons.remove_red_eye),
                            ),
                            IconButton(
                                icon: Icon(Icons.delete), onPressed: () => _showDeleteConfirmation(gifs[i])),
                          ],
                        ),
                      ),
                    ))
          ],
        ));
  }
}
