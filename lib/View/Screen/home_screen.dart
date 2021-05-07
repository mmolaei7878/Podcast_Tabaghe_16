import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tabaghe_16_podcast/Controllers/PlayerController.dart';
import 'package:tabaghe_16_podcast/Controllers/connection_controller.dart';
import 'package:tabaghe_16_podcast/Controllers/podcast_controller.dart';
import 'package:tabaghe_16_podcast/Model/podcast.dart';
import 'package:tabaghe_16_podcast/View/Screen/play_screen.dart';
import 'package:tabaghe_16_podcast/View/Widget/CustomButton.dart';

class HomeScreen extends StatelessWidget {
  final playerController = Get.put(PlayerController());
  final playerControlleronnection = Get.find<ConnectionController>();
  final pc = Get.find<PodCastController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: !playerControlleronnection.isConnected.value
              ? Center(
                  child: Lottie.asset(
                    'lib/View/Animation/no_internet.json',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    height: 10.0.h,
                    width: 100.0.w,
                  ),
                )
              : pc.loading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 40.0.h,
                          elevation: 50,
                          backgroundColor: Theme.of(context).primaryColor,
                          flexibleSpace: FlexibleSpaceBar(
                              centerTitle: true,
                              background: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      'Tabaghe',
                                      style: GoogleFonts.bangers(
                                        color: Colors.white,
                                        fontSize: 55.0.sp,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  Container(
                                    child: Text(
                                      '16',
                                      style: GoogleFonts.bangers(
                                        color: Colors.white,
                                        fontSize: 55.0.sp,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ],
                              )),
                        ),
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (ctx, i) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xff03DAC6),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    showmodal(
                                        context, pc.podList.value.results[i]);
                                  },
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 15.0,
                                        right: 15.0,
                                        child: Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 15.0,
                                        left: 15.0,
                                        child: Text(
                                          pc.podList.value.results[i].podnum
                                              .toString(),
                                          style: GoogleFonts.bangers(
                                            color: Colors.white,
                                            fontSize: 35.0.sp,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount: pc.podList.value.results.length,
                          ),
                        ),
                      ],
                    )),
    );
  }

  showmodal(BuildContext context, SinglePod podcast) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (c) => Container(
        margin: EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Scrollbar(
                isAlwaysShown: true,
                showTrackOnHover: true,
                radius: Radius.circular(80),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Episode  ' + podcast.podnum.toString(),
                        style: GoogleFonts.acme(
                            fontSize: 23, color: Colors.black87),
                      ),
                      Text(
                        podcast.podName,
                        style: GoogleFonts.acme(
                            fontSize: 21, color: Colors.black87),
                      ),
                      Text(
                        podcast.speaker,
                        style: GoogleFonts.acme(
                            fontSize: 19, color: Colors.black87),
                      ),
                      Text(
                        podcast.description,
                        style: GoogleFonts.alegreya(
                            fontSize: 17, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomButton(
              text: 'Play',
              size: Size(70.0.w, 65),
              function: () {
                Get.off(
                  () => PlayScreen(),
                  arguments: podcast,
                  transition: Transition.leftToRight,
                );
                playerController.play(podcast.audioUrl);
              },
            )
          ],
        ),
      ),
    );
  }
}
