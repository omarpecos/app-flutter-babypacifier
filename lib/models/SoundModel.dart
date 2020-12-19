
class SoundModel{
  String name;
  String icon;
  String path;

  SoundModel({this.name,this.icon,this.path});
}

List<SoundModel> soundData = [
  SoundModel(
    name: 'Agapornis',
    icon : 'assets/images/bird.png',
    path: 'assets/sounds/birds.mp3'
  ),
   SoundModel(
    name: 'Pájaros de fondo',
    icon : 'assets/images/forest_birds.png',
    path: 'assets/sounds/birds_far.mp3'
  ),
   SoundModel(
    name: 'Insectos',
    icon : 'assets/images/insects.png',
    path: 'assets/sounds/forest_insects.mp3'
  ),
  SoundModel(
    name: 'Bosque',
    icon : 'assets/images/forest.png',
    path: 'assets/sounds/forest_Australia.mp3'
  ),
   SoundModel(
    name: 'Pájaros tropicales',
    icon : 'assets/images/forest_birds.png',
    path: 'assets/sounds/birds_safari.mp3'
  ),
  SoundModel(
    name: 'Fuego',
    icon : 'assets/images/fire.png',
    path: 'assets/sounds/incinerator_fire.mp3'
  ),
   SoundModel(
    name: 'Viento',
    icon : 'assets/images/wind.png',
    path: 'assets/sounds/light_wind.mp3'
  ),
  SoundModel(
    name: 'Ballena',
    icon : 'assets/images/whale.png',
    path: 'assets/sounds/whale.mp3'
  ),
   SoundModel(
    name: 'Waves',
    icon : 'assets/images/waves.png',
    path: 'assets/sounds/waves.mp3'
  ),
   SoundModel(
    name: 'Cascada',
    icon : 'assets/images/waterfall.png',
    path: 'assets/sounds/waterfall.mp3'
  )
];