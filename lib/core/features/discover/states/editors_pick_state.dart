import 'dart:async';

import 'package:jolly_podcast/core/components/utils/constants.dart';
import 'package:jolly_podcast/core/components/utils/package_export.dart';
import 'package:jolly_podcast/core/features/discover/model/editors_pick_state_model.dart';
import 'package:jolly_podcast/core/features/discover/service/discover_service.dart';

class EditorsPickPodcastNotifier
    extends AsyncNotifier<EditorsPickPodcastStateModel> {
  late final HomeService _home;

  @override
  FutureOr<EditorsPickPodcastStateModel> build() async {
    _home = ref.read(homeServiceProvider);
    return const EditorsPickPodcastStateModel();
  }

  Future<void> getEditorsPickPodcastData({bool forceRefresh = false}) async {
    final current = state.value ?? const EditorsPickPodcastStateModel();
    final visit = current.visitCount + 1;
    printData("EditorsPick Podcast VisitCount", visit);
    if (!current.hasFetched || forceRefresh) {
      state = const AsyncLoading();
      final ads = await _home.getEditorsPickPodcast();
      state = AsyncData(
        current.copyWith(data: ads, hasFetched: true, visitCount: visit),
      );
    } else {
      final ads = await _home.getEditorsPickPodcast();
      state = AsyncData(current.copyWith(data: ads, visitCount: visit));
    }
  }
}

final homeServiceProvider = Provider<HomeService>((ref) {
  return HomeService();
});

final editorsPickPodcastProvider =
    AsyncNotifierProvider<
      EditorsPickPodcastNotifier,
      EditorsPickPodcastStateModel
    >(EditorsPickPodcastNotifier.new);
