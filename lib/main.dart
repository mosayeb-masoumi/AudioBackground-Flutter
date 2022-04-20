import 'package:audio_background_flutter/audio_list/audio_list_page.dart';
import 'package:audio_background_flutter/audio_player_handler.dart';
import 'package:audio_background_flutter/home_page.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';


late AudioHandler _audioHandler;
Future<void> main() async{

  _audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home:  HomePage(audioHandler: _audioHandler,),
      home:  AudioListPage(),

    );
  }
}
