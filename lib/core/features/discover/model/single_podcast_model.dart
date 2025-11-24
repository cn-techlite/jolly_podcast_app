// To parse this JSON data, do
//
//     final singlePodcastResponseModel = singlePodcastResponseModelFromJson(jsonString);

import 'package:jolly_podcast/core/features/discover/model/discover_podcast_model.dart';

class SinglePodcastResponseModel {
  final String? message;
  final SinglePodcastResponseModelData? data;

  SinglePodcastResponseModel({this.message, this.data});

  SinglePodcastResponseModel copyWith({
    String? message,
    SinglePodcastResponseModelData? data,
  }) => SinglePodcastResponseModel(
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory SinglePodcastResponseModel.fromJson(Map<String, dynamic> json) =>
      SinglePodcastResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? null
            : SinglePodcastResponseModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class SinglePodcastResponseModelData {
  final String? message;
  final PodcastDataModel? data;

  SinglePodcastResponseModelData({this.message, this.data});

  SinglePodcastResponseModelData copyWith({
    String? message,
    PodcastDataModel? data,
  }) => SinglePodcastResponseModelData(
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory SinglePodcastResponseModelData.fromJson(Map<String, dynamic> json) =>
      SinglePodcastResponseModelData(
        message: json["message"],
        data: json["data"] == null
            ? null
            : PodcastDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}
