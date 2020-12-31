import 'package:flutter/material.dart';

import 'package:baby_pacifier/pages/animations.dart';
import 'package:baby_pacifier/pages/records.dart';
import 'package:baby_pacifier/pages/sounds.dart';

import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
      title: 'Baby Pacifier',
      home: App(),
      color: Colors.grey[350],
      theme : ThemeData(
        disabledColor: Colors.grey[350]
      )
    )
  );
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
            'Se ha producido un error. Conéctese a internet o inténtelo de nuevo'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby Pacifier'),
      ),
      body: TabBarView(
        controller: tabController,
        children: [Sounds(), Records(), Animations()],
      ),
      drawer: Drawer(
        child: ListView(children: [
          DrawerHeader(child: Container()),
          AboutListTile(
            icon: Icon(Icons.info),
            applicationName: 'Baby Pacifier',
            applicationVersion: '1.0.1',
            applicationIcon: Image.asset('assets/icon/icon.png', width: 50),
            child: Text('Sobre esta App', style: TextStyle(fontSize: 15, color: Colors.grey[700])),
            aboutBoxChildren: [
              Text(
                  'Aplicación para tranquilizar a los más pequeños con sonidos relajantes, música de internet o grabaciones personales y llamar su atención con animaciones'),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              ListTile(
                  leading: Icon(Icons.arrow_right),
                  title: RichText(
                      text: new TextSpan(children: [
                        new TextSpan(
                          text: 'Imágenes de ',
                          style: new TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        new TextSpan(
                            text: 'icon-icons.com',
                            style: new TextStyle(color: Colors.blue, fontSize: 18),
                            recognizer: new TapGestureRecognizer()
                              ..onTap =
                                  () => _launchURL('https://icon-icons.com/')),
                      ]))),
              ListTile(
                  leading: Icon(Icons.arrow_right),
                  title: RichText(
                      text: new TextSpan(children: [
                        new TextSpan(
                          text: 'Gifs de ',
                          style: new TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        new TextSpan(
                            text: 'giphy.com',
                            style: new TextStyle(color: Colors.blue, fontSize: 18),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () => _launchURL('https://giphy.com/')),
                      ]))),
              ListTile(
                  leading: Icon(Icons.arrow_right),
                  title: RichText(
                      text: new TextSpan(children: [
                        new TextSpan(
                          text: 'Estaciones de radio de ',
                          style: new TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        new TextSpan(
                            text: 'internet-radio.com',
                            style: new TextStyle(color: Colors.blue, fontSize: 18),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () =>
                                  _launchURL('https://www.internet-radio.com/')),
                      ]))),
              ListTile(
                  leading: Icon(Icons.arrow_right),
                  title: RichText(
                      text: new TextSpan(children: [
                        new TextSpan(
                          text: 'Sonidos de ',
                          style: new TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        new TextSpan(
                            text: 'zapsplat.com',
                            style: new TextStyle(color: Colors.blue, fontSize: 18),
                            recognizer: new TapGestureRecognizer()
                              ..onTap =
                                  () => _launchURL('https://www.zapsplat.com/')),
                      ]))),
            ],
          )
        ]),
      ),
      bottomNavigationBar:
          TabBar(labelColor: Colors.blue, controller: tabController, tabs: [
        Tab(icon: Icon(Icons.surround_sound), text: 'Audios'),
        Tab(icon: Icon(Icons.record_voice_over), text: 'Grabaciones'),
        Tab(icon: Icon(Icons.animation), text: 'Animaciones')
      ]),
    );
  }
}