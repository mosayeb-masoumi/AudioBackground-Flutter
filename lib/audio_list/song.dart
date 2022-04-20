class Song{
  final String url;
  final String name;
  final String artist;
  final String icon;
  final String album;
  final Duration duration;

  Song({required this.url, required this.name, required this.artist, required this.icon, required this.album, required this.duration});
}

List<Song> songList = [

  Song(
      url :"https://filesamples.com/samples/audio/mp3/sample3.mp3",
      name :"name 1",
      artist:"artist 1",
      icon:"https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Sunflower_from_Silesia2.jpg/800px-Sunflower_from_Silesia2.jpg?20091008132228",
      album:"album 1",
      duration :Duration(minutes: 1 ,seconds: 45)),

  Song(
      url :"https://filesamples.com/samples/audio/mp3/sample3.mp3",
      name :"name 2",
      artist:"artist 2",
      icon:"https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Sunflower_from_Silesia2.jpg/800px-Sunflower_from_Silesia2.jpg?20091008132228",
      album:"album 2",
      duration :Duration(minutes: 1 ,seconds: 45)),

  Song(
      url :"https://filesamples.com/samples/audio/mp3/sample3.mp3",
      name :"name 3",
      artist:"artist 3",
      icon:"https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Sunflower_from_Silesia2.jpg/800px-Sunflower_from_Silesia2.jpg?20091008132228",
      album:"album 3",
      duration :Duration(minutes: 1 ,seconds: 45)),

];