import 'package:get/get.dart';
import 'package:tabaghe_16_podcast/Model/podcast.dart';
import 'package:tabaghe_16_podcast/Service/Service.dart';

class PodCastController extends GetxController {
  var podList = Podcasts().obs;
  var loading = false.obs;

  getAllPodcast() async {
    loading(true);
    final podcasts = await Service.getAllPodcast();
    podList.value = podcasts;
    podList.value.results.sort((a, b) => a.podnum.compareTo(b.podnum));
    loading(false);
  }

  @override
  void onInit() {
    super.onInit();
    getAllPodcast();
  }
}
