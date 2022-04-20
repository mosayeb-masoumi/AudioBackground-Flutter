
import 'package:audio_background_flutter/audio_player_handler.dart';
import 'package:audio_background_flutter/common.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  AudioHandler audioHandler;

  HomePage({Key? key, required this.audioHandler}) : super(key: key);



  static final music_item = MediaItem(
    // id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
    id: 'https://filesamples.com/samples/audio/mp3/sample3.mp3',
    album: "فردای بهتر",
    title: "تلاش برای ساختن فردایی بهتر  تلاش برای ساختن فردایی بهتر",
    artist: "مسیب باند",
    // duration: const Duration(milliseconds: 5739820),
    duration: const Duration(milliseconds: 105000),
    // artUri: Uri.parse('https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
    artUri: Uri.parse('https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Sunflower_from_Silesia2.jpg/800px-Sunflower_from_Silesia2.jpg?20091008132228'),
  );

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {




  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Service Test'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show media item title
            StreamBuilder<MediaItem?>(
              stream: widget.audioHandler.mediaItem,
              builder: (context, snapshot) {
                final mediaItem = snapshot.data;
                return Text(mediaItem?.title ?? '');
              },
            ),
            // Play/pause/stop buttons.
            StreamBuilder<bool>(
              stream: widget.audioHandler.playbackState
                  .map((state) => state.playing)
                  .distinct(),
              builder: (context, snapshot) {
                final playing = snapshot.data ?? false;
                return Container(

                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)) ,
                    color: Colors.blueGrey,
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _button(Icons.fast_rewind, widget.audioHandler.rewind),

                      if (playing)
                        _button(Icons.pause, widget.audioHandler.pause)

                      else
                        _button(Icons.play_arrow, widget.audioHandler.play),
                      _button(Icons.stop, widget.audioHandler.stop),
                      _button(Icons.fast_forward, widget.audioHandler.fastForward),

                    ],
                  ),
                );
              },
            ),
            // A seek bar.
            StreamBuilder<MediaState>(
              stream: _mediaStateStream,
              builder: (context, snapshot) {
                final mediaState = snapshot.data;


                return SeekBar(
                  duration: mediaState?.mediaItem?.duration ?? Duration.zero,
                  position: mediaState?.position ?? Duration.zero,
                  onChangeEnd: (newPosition) {
                    widget.audioHandler.seek(newPosition);

                  },
                );
              },
            ),
            // Display the processing state.
            StreamBuilder<AudioProcessingState>(
              stream: widget.audioHandler.playbackState
                  .map((state) => state.processingState)
                  .distinct(),
              builder: (context, snapshot) {
                final processingState = snapshot.data ?? AudioProcessingState.idle;

                if(describeEnum(processingState) == "completed"){
                    widget.audioHandler.stop();
                    Duration duration = Duration(milliseconds: 0);
                    widget.audioHandler.seek(duration);
                }

                if(describeEnum(processingState) == "loading" || describeEnum(processingState) == "buffering" ){
                  return SpinKitWave(color: Colors.blue, size: 10,);
                }else{
                  return Text("Processing state: ${describeEnum(processingState)}");
                }

              },
            ),
          ],
        ),
      ),
    );
  }

  /// A stream reporting the combined state of the current media item and its
  /// current position.
  Stream<MediaState> get _mediaStateStream =>
      Rx.combineLatest2<MediaItem?, Duration, MediaState>(
          widget.audioHandler.mediaItem,
          AudioService.position,
              (mediaItem, position) => MediaState(mediaItem, position));

  IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
    icon: Icon(iconData),
    iconSize: 50.0,
    onPressed: onPressed,
  );


}

class MediaState {
  final MediaItem? mediaItem;
  final Duration position;

  MediaState(this.mediaItem, this.position);
}

