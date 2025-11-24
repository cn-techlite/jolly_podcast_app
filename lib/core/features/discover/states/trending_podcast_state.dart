import 'dart:async';

import 'package:jolly_podcast/core/components/utils/constants.dart';
import 'package:jolly_podcast/core/components/utils/package_export.dart';
import 'package:jolly_podcast/core/features/discover/model/discover_podcast_model.dart';
import 'package:jolly_podcast/core/features/discover/model/trending_state_model.dart';
import 'package:jolly_podcast/core/features/discover/service/discover_service.dart';

class TrendingPodcastNotifier extends AsyncNotifier<TrendingPodcastStateModel> {
  late final HomeService _home;

  // Single POdcast
  // Internal caches & trackers
  final Map<int, bool> fetchedPodcastById = {};
  final Map<int, PodcastDataModel> _podcastCache = {};
  final Map<int, int> _podcastVisitCounter = {};

  @override
  FutureOr<TrendingPodcastStateModel> build() async {
    _home = ref.read(homeServiceProvider);
    return const TrendingPodcastStateModel();
  }

  Future<void> getTrendingPodcastData({bool forceRefresh = false}) async {
    final current = state.value ?? const TrendingPodcastStateModel();
    final visit = current.visitCount + 1;
    printData("Trending Podcast VisitCount", visit);
    if (!current.hasFetched || forceRefresh) {
      state = const AsyncLoading();
      final ads = await _home.getTrendingPodcastData(page: 1, pageNo: 5);
      final pods = ads.data;
      state = AsyncData(
        current.copyWith(podcast: pods, hasFetched: true, visitCount: visit),
      );
    } else {
      final ads = await _home.getTrendingPodcastData(page: 1, pageNo: 5);
      final pods = ads.data;
      state = AsyncData(current.copyWith(podcast: pods, visitCount: visit));
    }
  }

  PodcastDataModel? getPodcastById(int id) => _podcastCache[id];

  // ------------------------------
  // Single Podcast detail (with per-id visit counter & cache)
  // ------------------------------
  Future<void> getPodcastData1({
    required int id,
    bool forceRefresh = false,
  }) async {
    try {
      _podcastVisitCounter[id] = (_podcastVisitCounter[id] ?? 0) + 1;
      final visitCount = _podcastVisitCounter[id]!;

      final cached = _podcastCache[id];
      if (cached != null && visitCount > 1 && !forceRefresh) {
        final current = state.value!;
        state = AsyncData(current.copyWith(data: cached));
        return;
      }

      state = visitCount == 1
          ? const AsyncValue.loading()
          : const AsyncValue.loading();

      state = await AsyncValue.guard(() async {
        final response = await _home.getPodcastData(podcastId: id);

        // Cache
        _podcastCache[id] = response;
        fetchedPodcastById[id] = true;

        // Update list if present
        final current = state.value!;

        return current.copyWith(
          data: response,
          visitSingleCount: visitCount,
          hasSingleFetched: true,
        );
      });
    } catch (e) {
      state = AsyncData(
        state.value!.copyWith(),
      ); // keep previous state but you can set error separately
      // propagate error as AsyncError so UI can react
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> getPodcastData({required int id}) async {
    final cached = _podcastCache[id];
    final hasFetchedBefore = fetchedPodcastById[id] == true;
    final visitCount = _podcastVisitCounter[id]!;
    printData("Podcast VisitCount", visitCount);
    // 1️⃣ First Time Fetch → Show Loading
    //
    if (!hasFetchedBefore) {
      state = const AsyncValue.loading();
    }
    // 2️⃣ Subsequent Visits → Return cached data immediately (NO LOADING)
    else if (cached != null) {
      final current = state.value;
      state = AsyncData(
        (current ?? TrendingPodcastStateModel()).copyWith(
          data: cached,
          hasSingleFetched: true,
        ),
      );
    }
    // 3️⃣ Always Fetch Fresh Data (Silent if cached exists)
    try {
      final response = await _home.getPodcastData(podcastId: id);
      // Update cache
      _podcastCache[id] = response;
      fetchedPodcastById[id] = true;
      final current = state.value ?? TrendingPodcastStateModel();
      state = AsyncData(
        current.copyWith(data: response, hasSingleFetched: true),
      );
    } catch (e, st) {
      // If API fails and we already have cached data → keep UI stable
      if (_podcastCache.containsKey(id)) return;
      // Only error when there is no cached data
      state = AsyncError(e, st);
    }
  }
}

final homeServiceProvider = Provider<HomeService>((ref) {
  return HomeService();
});

final trendingPodcastProvider =
    AsyncNotifierProvider<TrendingPodcastNotifier, TrendingPodcastStateModel>(
      TrendingPodcastNotifier.new,
    );
