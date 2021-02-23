import 'dart:async';

import 'package:SMLingg/app/lesson/lesson.provider.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    this.playBackRate = 1,
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
  AudioPlayer audioPlayer = AudioPlayer();
  int currentIndex = 0;
  AudioCache audioCache = AudioCache();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.release();
    if (widget.playBackRate >= 1.0) {
      onPress();
    }
    currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex as int;
  }

  // ignore: avoid_void_async
  void onPress() async {
    audioCache.clearCache();
    audioPlayer.stop();
    audioPlayer.release();
    audioPlayer.play(widget.soundUrl, isLocal: false);
    audioPlayer.setPlaybackRate(playbackRate: widget.playBackRate);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioCache.clearCache();
    audioPlayer.stop();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return Consumer<LessonModel>(builder: (_, lessonModel, __) {
      if (currentIndex != lessonModel.focusWordIndex) {
        lessonModel.startSound;
        if (widget.playBackRate >= 1.0) {
          onPress();
        }
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
              child: Container(
                alignment: Alignment.center,
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                    color: (widget.playBackRate >= 1.0) ? Color(0xff48CEE0) : Color(0xFFFFAA5C),
                    borderRadius: BorderRadius.all(Radius.circular(90))),
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
                  child: (widget.playBackRate >= 1.0)
                      ? FaIcon(
                          FontAwesomeIcons.volumeUp,
                          size: 40,
                          color: Colors.white,
                        )
                      : Image.asset(
                          "assets/snail.jpg",
                          height: 20,
                        ),
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
