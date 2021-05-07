import 'package:http/http.dart' as http;
import 'package:tabaghe_16_podcast/Model/podcast.dart';

class Service {
  static Future<Podcasts> getAllPodcast() async {
    final url = 'YourUrl';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "X-Parse-Application-Id": "Application-Id",
          "X-Parse-REST-API-Key": "YourAPiKey",
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final podcasts = podcastsFromJson(response.body);
        return podcasts;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }
}
