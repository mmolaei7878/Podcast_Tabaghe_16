import 'package:http/http.dart' as http;
import 'package:tabaghe_16_podcast/Model/podcast.dart';

class Service {
  static Future<Podcasts> getAllPodcast() async {
    final url = 'https://parseapi.back4app.com/classes/AllPodcasts';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "X-Parse-Application-Id": "RSgVbDzfHf125ja8WZNe9FQWfFThED1fHTMlk47p",
          "X-Parse-REST-API-Key": "8RPSmE62YaYmC1Z4diuLm81csnnFvvCkEDWa3iMy",
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
