import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabaghe_16_podcast/Controllers/PlayerController.dart';

class PlayPauseButton extends StatefulWidget {
  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final podc = Get.find<PlayerController>();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: 100,
      height: 125,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          iconSize: 60,
          icon: AnimatedIcon(
              icon: AnimatedIcons.pause_play, progress: _animationController),
          onPressed: () {
            setState(() {
              podc.playPod.value
                  ? _animationController.forward()
                  : _animationController.reverse();
            });
            podc.playPod.value ? podc.pause() : podc.resume();
          },
        ),
      ),
    );
  }
}
