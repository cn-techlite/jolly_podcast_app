import 'package:jolly_podcast/core/features/discover/model/discover_podcast_model.dart';

class TrendingPodcastStateModel {
  final bool hasFetched;
  final int visitCount;
  final List<PodcastDataModel> podcast;
  final PodcastDataModel? data;
  final bool hasSingleFetched;
  final int visitSingleCount;

  const TrendingPodcastStateModel({
    this.hasFetched = false,
    this.visitCount = 0,
    this.podcast = const [],
    this.data,
    this.hasSingleFetched = false,
    this.visitSingleCount = 0,
  });

  TrendingPodcastStateModel copyWith({
    bool? hasFetched,
    int? visitCount,
    List<PodcastDataModel>? podcast,
    PodcastDataModel? data,
    bool? hasSingleFetched,
    int? visitSingleCount,
  }) {
    return TrendingPodcastStateModel(
      hasFetched: hasFetched ?? this.hasFetched,
      visitCount: visitCount ?? this.visitCount,
      podcast: podcast ?? this.podcast,
      data: data ?? this.data,
      hasSingleFetched: hasSingleFetched ?? this.hasSingleFetched,
      visitSingleCount: visitSingleCount ?? this.visitSingleCount,
    );
  }
}
