import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabaghe_16_podcast/Controllers/connection_controller.dart';
import 'package:tabaghe_16_podcast/Controllers/podcast_controller.dart';
import 'View/Screen/home_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
  Get.put(ConnectionController());
  Get.put(PodCastController());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff191919),
          accentColor: Color(0xff03DAC6),
        ),
        home: HomeScreen(),
      );
    });
  }
}
