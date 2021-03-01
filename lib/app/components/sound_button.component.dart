import 'dart:async';
import 'dart:io';

import 'package:SMLingg/app/lesson/lesson.provider.dart';
// import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class SoundButton extends StatefulWidget {
  final double height;
  final double width;
  final String soundUrl;
  final bool deactivate;
  final double playBackRate;

  SoundButton({
    @required this.height,
    @required this.width,
    @required this.playBackRate,
    this.deactivate = false,
    this.soundUrl,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SoundButtonState();
  }
}

class _SoundButtonState extends State<SoundButton> {
  bool onClickBool = false;

  // AudioPlayer audioPlayer = AudioPlayer();
  final player = AudioPlayer();
  int currentIndex = 0;
  File file;
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // audioPlayer.release();
    first();
    downloadMp3();
    currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
  }

  Future<void> first() async {
    // await audioPlayer.setReleaseMode(ReleaseMode.STOP);
    // int result = await audioPlayer.setUrl(widget.soundUrl,isLocal: false);
    var duration = await player.setUrl(widget.soundUrl);
    if (widget.playBackRate == 1) {
      await player.play();
    } else {
      player.stop();
    }
    // AudioSource.uri(Uri.parse(widget.soundUrl));
  }

  Future<void> downloadMp3() async {
    // http.Client client = http.Client();
    // var req = await client.get(Uri.parse(widget.soundUrl));
    // var bytes = req.bodyBytes;
    // String dir = (await getApplicationDocumentsDirectory()).path;
    // file = File("${"$dir/"}${DateTime.now().millisecondsSinceEpoch}.mp3");
    // await file.writeAsBytes(bytes);
    // print("path: ${file.path}");
    // if(widget.playBackRate >= 1) {
    //   int result = await audioPlayer.play(file.path, isLocal: true);
    // }
  }

  Future<void> onPress() async {
    print("link sound: ${widget.soundUrl}");
    print("widget.playBackRate: ${widget.playBackRate}");
    player.stop();
    var duration = await player.setUrl(widget.soundUrl);
    player.setSpeed(widget.playBackRate);
    var play = await player.play();
    // audioPlayer.stop();
    // await audioPlayer.setReleaseMode(ReleaseMode.STOP);
    // int result = await audioPlayer.play(file.path, isLocal: true);
    // audioPlayer.setPlaybackRate(playbackRate: widget.playBackRate);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.stop();
    player.dispose();
    // audioPlayer.stop();
    // audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return Consumer<LessonModel>(builder: (_, lessonModel, __) {
      if (currentIndex != lessonModel.focusWordIndex) {
        first();
        // downloadMp3();
        currentIndex = lessonModel.focusWordIndex;
      }
      return Container(
        height: widget.height + 4,
        width: widget.width,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  if (!widget.deactivate) {
                    setState(() {
                      onClickBool = true;
                    });
                    Future.delayed(const Duration(milliseconds: 100), () {
                      setState(() {
                        onClickBool = false;
                      });
                      onPress();
                    });
                  }
                },
                // hien thi shadow
                child: Container(
                  height: widget.height,
                  width: widget.width,
                  decoration: BoxDecoration(
                    color: (widget.playBackRate >= 1.0) ? Color(0xff2FB3C5) : Color(0xFFF68E2F),
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              child: GestureDetector(
               onTap: () {
                 if (!widget.deactivate) {
                   setState(() {
                     onClickBool = true;
                   });
                   Future.delayed(const Duration(milliseconds: 100), () {
                     setState(() {
                       onClickBool = false;
                     });
                     onPress();
                   });
                 }
               },
               child: Container(
                 alignment: Alignment.center,
                 height: widget.height,
                 width: widget.width,
                 decoration: BoxDecoration(
                     color: (widget.playBackRate >= 1.0) ? Color(0xff48CEE0) : Color(0xFFFFAA5C), borderRadius: BorderRadius.all(Radius.circular(90))),
                 child: (widget.playBackRate >= 1.0) ?
                 FaIcon(FontAwesomeIcons.volumeUp, size: 40, color: Colors.white) : Image.asset( "assets/snail.png", height: 40),
               ),
                ),
              duration: Duration(milliseconds: 100),
              bottom: onClickBool ? 0 : 4,
            )
          ],
        ),
      );
    });
  }
}
