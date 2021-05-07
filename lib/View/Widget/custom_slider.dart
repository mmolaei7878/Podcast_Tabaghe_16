import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabaghe_16_podcast/Controllers/PlayerController.dart';

class CustomSlider extends StatefulWidget {
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final podc = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Obx(
        () => SleekCircularSlider(
          appearance: CircularSliderAppearance(
            customWidths: CustomSliderWidths(progressBarWidth: 10),
            customColors: CustomSliderColors(
              progressBarColor: Theme.of(context).accentColor,
              dotColor: Colors.white,
              trackColor: Colors.black26,
            ),
          ),
          min: 0.0,
          max: double.parse(
              podc.wholeplayPosition.value.inMilliseconds.toStringAsFixed(2)),
          initialValue: double.parse(
              podc.currentPlayPosition.value.inMilliseconds.toStringAsFixed(2)),
          onChange: (value) {
            setState(
              () {
                podc.audioPlayer.seek(
                  Duration(
                    milliseconds: value.round(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
