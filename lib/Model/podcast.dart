// To parse this JSON data, do
//
//     final podcasts = podcastsFromJson(jsonString);

import 'dart:convert';

Podcasts podcastsFromJson(String str) => Podcasts.fromJson(json.decode(str));

String podcastsToJson(Podcasts data) => json.encode(data.toJson());

class Podcasts {
  Podcasts({
    this.results,
  });

  final List<SinglePod> results;

  factory Podcasts.fromJson(Map<String, dynamic> json) => Podcasts(
        results: json["results"] == null
            ? null
            : List<SinglePod>.from(
                json["results"].map((x) => SinglePod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class SinglePod {
  SinglePod({
    this.objectId,
    this.audioUrl,
    this.description,
    this.podnum,
    this.podName,
    this.speaker,
    this.createdAt,
    this.updatedAt,
  });

  final String objectId;
  final String audioUrl;
  final String description;
  final int podnum;
  final String podName;
  final String speaker;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory SinglePod.fromJson(Map<String, dynamic> json) => SinglePod(
        objectId: json["objectId"] == null ? null : json["objectId"],
        audioUrl: json["audio_url"] == null ? null : json["audio_url"],
        description: json["description"] == null ? null : json["description"],
        podnum: json["podnum"] == null ? null : json["podnum"],
        podName: json["pod_name"] == null ? null : json["pod_name"],
        speaker: json["speaker"] == null ? null : json["speaker"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "objectId": objectId == null ? null : objectId,
        "audio_url": audioUrl == null ? null : audioUrl,
        "description": description == null ? null : description,
        "podnum": podnum == null ? null : podnum,
        "pod_name": podName == null ? null : podName,
        "speaker": speaker == null ? null : speaker,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
