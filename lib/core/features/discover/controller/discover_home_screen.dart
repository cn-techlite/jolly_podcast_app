import 'package:jolly_podcast/core/components/utils/package_export.dart';
import 'package:jolly_podcast/core/features/discover/states/editors_pick_state.dart';
import 'package:jolly_podcast/core/features/discover/states/trending_podcast_state.dart';
import 'package:jolly_podcast/core/features/discover/view/discover_home_screen.dart';

class DiscoverHomeScreen extends ConsumerStatefulWidget {
  const DiscoverHomeScreen({super.key});

  @override
  ConsumerState<DiscoverHomeScreen> createState() =>
      DiscoverHomeScreenController();
}

class DiscoverHomeScreenController extends ConsumerState<DiscoverHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Editors Pick Podcast
    final editorsPickPodcast = ref.read(editorsPickPodcastProvider.notifier);

    // Trending Podcast
    var dataProvider = ref.read(trendingPodcastProvider.notifier);
    Future.microtask(() {
      editorsPickPodcast.getEditorsPickPodcastData();
      dataProvider.getTrendingPodcastData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DiscoverHomeScreenView(this);
  }
}
