import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class PlayerController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  final box = GetStorage();
  var playPod = false.obs;
  var futureLoad = true.obs;
  var currentPlayPosition = Duration().obs;
  var wholeplayPosition = Duration().obs;
  var animatedWidth = 0.0.obs;

  format(Rx<Duration> d) => d.toString().split('.').first.padLeft(8, "0");

  play(String url) async {
    animatedWidth.value = Get.width;
    await audioPlayer.play(url);
    playPod(true);
    currentPlayingtime();
    wholePlayingTime();
  }

  getTimeWhenBack({String id, Object value}) async {
    final data = {"time": value};
    if (!box.hasData(id)) {
      await box.write(id, jsonEncode(data));
    }
  }

  delay2() {
    Future.delayed(Duration(seconds: 2), () {
      futureLoad.value = false;
    });
  }

  readFromLastDuration({String id}) async {
    if (box.hasData(id)) {
      var playTime = await box.read(id);
      final decodeData = jsonDecode(playTime)['time'];
      currentPlayPosition.value = Duration(milliseconds: decodeData);
      await audioPlayer.seek(Duration(milliseconds: decodeData));
    }
  }

  currentPlayingtime() async {
    audioPlayer.onAudioPositionChanged
        .listen((p) => {currentPlayPosition.value = p});
  }

  sliderOnChange(double value) async {
    await audioPlayer.seek(
        currentPlayPosition.value.inMilliseconds.milliseconds +
            Duration(milliseconds: int.parse(value.toStringAsFixed(0))));
  }

  tenSecondForwad() async {
    await audioPlayer.seek(
        currentPlayPosition.value.inMilliseconds.milliseconds +
            Duration(milliseconds: 10000));
  }

  tenSecondrewind() async {
    await audioPlayer.seek(
        currentPlayPosition.value.inMilliseconds.milliseconds -
            Duration(milliseconds: 10000));
  }

  wholePlayingTime() async {
    audioPlayer.onDurationChanged.listen((p) => {wholeplayPosition.value = p});
  }

  pause() async {
    await audioPlayer.pause();
    playPod(false);
  }

  stop() async {
    await audioPlayer.stop();
  }

  resume() async {
    await audioPlayer.resume();
    playPod(true);
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
