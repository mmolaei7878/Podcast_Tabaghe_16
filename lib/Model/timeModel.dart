import 'package:get/get.dart';

class TimeModel {
  final Rx<Duration> duration;
  TimeModel(this.duration);
  TimeModel.fromJson(Map<String, dynamic> json) : duration = json['duration'];
  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
    };
  }
}
