import 'package:jolly_podcast/core/features/discover/model/discover_podcast_model.dart';

class EditorsPickPodcastStateModel {
  final bool hasFetched;
  final int visitCount;
  final PodcastDataModel? data;

  const EditorsPickPodcastStateModel({
    this.hasFetched = false,
    this.visitCount = 0,
    this.data,
  });

  EditorsPickPodcastStateModel copyWith({
    bool? hasFetched,
    int? visitCount,
    PodcastDataModel? data,
  }) {
    return EditorsPickPodcastStateModel(
      hasFetched: hasFetched ?? this.hasFetched,
      visitCount: visitCount ?? this.visitCount,
      data: data ?? this.data,
    );
  }
}
