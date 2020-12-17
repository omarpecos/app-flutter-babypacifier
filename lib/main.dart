import 'package:baby_pacifier/pages/animations.dart';
import 'package:baby_pacifier/pages/records.dart';
import 'package:baby_pacifier/pages/sounds.dart';
import 'package:flutter/material.dart';

 void main() { 
  runApp(MaterialApp( 
    home : App())
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
    tabController = new TabController(length: 3, vsync : this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby Pacifier'),
      ),
      body: TabBarView(
        controller : tabController,
        children: [
          Sounds(),
          Records(),
          Animations()
        ],
      ),
      bottomNavigationBar: TabBar(
        labelColor: Colors.blue,
        controller: tabController,
        tabs: [
          Tab(
            icon: Icon(Icons.surround_sound),
            text: 'Audios'
          ),
           Tab(
            icon: Icon(Icons.record_voice_over),
            text: 'Grabaciones'
          ),
           Tab(
            icon: Icon(Icons.animation),
            text: 'Animaciones'
          )
        ]
      ),
    );
  }
}