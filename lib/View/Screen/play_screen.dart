import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:tabaghe_16_podcast/Controllers/PlayerController.dart';
import 'package:tabaghe_16_podcast/Controllers/connection_controller.dart';
import 'package:tabaghe_16_podcast/Model/podcast.dart';
import 'package:tabaghe_16_podcast/View/Widget/custom_slider.dart';
import 'package:tabaghe_16_podcast/View/Widget/play_pause_button.dart';

class PlayScreen extends StatelessWidget {
  final podc = Get.find<PlayerController>();
  final podconnection = Get.find<ConnectionController>();
  final SinglePod podcast = Get.arguments;
  @override
  Widget build(BuildContext context) {
    podc.delay2();
    podc.readFromLastDuration(id: podcast.objectId);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          podc.box.remove(podcast.objectId);
          podc.getTimeWhenBack(
              id: podcast.objectId,
              value: podc.currentPlayPosition.value.inMilliseconds);
          await podc.stop();
          podc.currentPlayPosition.value = Duration(seconds: 0);

          Get.back();
          Future.delayed(Duration(seconds: 1), () {
            podc.futureLoad.value = true;
          });

          return;
        },
        child: Obx(
          () => !podconnection.isConnected.value
              ? Center(
                  child: Lottie.asset(
                    'lib/View/Animation/no_internet.json',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    height: 10.0.h,
                    width: 100.0.w,
                  ),
                )
              : Stack(
                  children: [
                    Positioned.fill(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.0.h,
                          ),
                          Container(
                            width: 80.0.w,
                            height: 40.0.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CustomSlider(),
                                Positioned.fill(
                                  bottom: 40.0,
                                  top: 40.0,
                                  left: 30.0,
                                  right: 30.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(190.0),
                                    child: Image.asset(
                                      'lib/16.jpg',
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 100.0.w,
                            height: 10.0.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Obx(
                                  () => Text(
                                    podc.format(podc.currentPlayPosition),
                                    style: GoogleFonts.cairo(fontSize: 16.0.sp),
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    podc.format(podc.wholeplayPosition),
                                    style: GoogleFonts.cairo(fontSize: 16.0.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 100.0.w,
                            height: 10.0.h,
                            child: Text(
                              podcast.podnum.toString(),
                              style: GoogleFonts.aBeeZee(
                                fontSize: 27.0.sp,
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0.w,
                            height: 20.0.h,
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 250,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          width: 1.0, color: Colors.black12),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.fast_rewind),
                                            onPressed: () {
                                              podc.tenSecondrewind();
                                            }),
                                        IconButton(
                                            icon: Icon(Icons.fast_forward),
                                            onPressed: () {
                                              podc.tenSecondForwad();
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                                PlayPauseButton(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (podc.futureLoad.value)
                      Positioned.fill(
                        child: Container(
                          color: Theme.of(context).accentColor,
                          alignment: Alignment.center,
                          width: Get.width,
                          height: podc.animatedWidth.value,
                          child: Center(
                            child: Lottie.asset(
                              'lib/View/Animation/microphone.json',
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              height: 10.0.h,
                              width: 100.0.w,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
