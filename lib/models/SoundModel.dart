
class SoundModel{
  String name;
  String icon;
  String path;

  SoundModel({this.name,this.icon,this.path});
}

List<SoundModel> soundDataLocal = [
  SoundModel(
    name: 'Periquitos',
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
    name: 'Olas',
    icon : 'assets/images/waves.png',
    path: 'assets/sounds/waves.mp3'
  ),
   SoundModel(
    name: 'Cascada',
    icon : 'assets/images/waterfall.png',
    path: 'assets/sounds/waterfall.mp3'
  )
];

List<SoundModel> whiteSoundDataLocal = [
  SoundModel(
    name: 'Ventilador',
    icon : 'assets/images/fan.png',
    path: 'assets/sounds/fan.ogg'
  ),
  SoundModel(
    name: 'Campanillas',
    icon : 'assets/images/chimes.png',
    path: 'assets/sounds/windchimes.ogg'
  ),
  SoundModel(
    name: 'Verano',
    icon : 'assets/images/heat.png',
    path: 'assets/sounds/heatwave.ogg'
  ),
  SoundModel(
    name: 'Meditación',
    icon : 'assets/images/meditacion.png',
    path: 'assets/sounds/meditation.ogg'
  ),
  SoundModel(
    name: 'Principe encantador',
    icon : 'assets/images/instrumental.png',
    path: 'assets/sounds/handsome-prince.mp3'
  ),
   SoundModel(
    name: 'Entre las estrellas',
    icon : 'assets/images/instrumental.png',
    path: 'assets/sounds/among_the_stars_no_piano.mp3'
  ),
    SoundModel(
    name: 'Banco del parque',
    icon : 'assets/images/instrumental.png',
    path: 'assets/sounds/park_bench.mp3'
  ),
   SoundModel(
    name: 'Tonos de naranja',
    icon : 'assets/images/instrumental.png',
    path: 'assets/sounds/shades_of_orange.mp3'
  ),
   SoundModel(
    name: 'Tómalo todo',
    icon : 'assets/images/instrumental.png',
    path: 'assets/sounds/take-it-all-in.mp3'
  ),
  SoundModel(
    name: 'Un camino corto',
    icon : 'assets/images/blues.png',
    path: 'assets/sounds/piano_a_short_walk.mp3'
  ),
   SoundModel(
    name: 'Si fuera un barco',
    icon : 'assets/images/blues.png',
    path: 'assets/sounds/piano_ifaboat.mp3'
  ),
   SoundModel(
    name: 'María',
    icon : 'assets/images/blues.png',
    path: 'assets/sounds/piano_mary.mp3'
  ),
];

List<SoundModel> soundDataStream = [
  SoundModel(
    name: 'Clásica',
    icon : 'assets/images/orquesta.png',
    path: 'http://174.36.206.197:8000/;stream/1'
  ),
  SoundModel(
    name: 'Instrumental',
    icon : 'assets/images/instrumental.png',
    path: 'http://104.251.118.50:8626/;stream/1'
  ),
  SoundModel(
    name: 'Hindú',
    icon : 'assets/images/hindu.png',
    path: 'https://us3.internet-radio.com/proxy/ritu?mp=/live'
  ),
  SoundModel(
    name: 'Meditación',
    icon : 'assets/images/meditacion.png',
    path: 'https://us2.internet-radio.com/proxy/mattjohnsonradio?mp=/stream;'
  ),
   SoundModel(
    name: 'Jazz',
    icon : 'assets/images/jazz.png',
    path: 'https://us4.internet-radio.com/proxy/wsjf?mp=/stream;'
  ),
   SoundModel(
    name: 'Soul',
    icon : 'assets/images/soul.png',
    path: 'https://uk3.internet-radio.com/proxy/majesticjukebox?mp=/live'
  ),
   SoundModel(
    name: 'Chillout',
    icon : 'assets/images/chillout.png',
    path: 'https://uk2.internet-radio.com/proxy/ambientradio?mp=/;'
  ),
   SoundModel(
    name: 'Blues',
    icon : 'assets/images/blues.png',
    path: 'https://us3.internet-radio.com/proxy/topblues?mp=/stream;'
  ),
  
];