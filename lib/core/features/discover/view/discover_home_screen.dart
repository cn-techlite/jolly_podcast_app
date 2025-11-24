import 'package:jolly_podcast/core/components/architecture/mvc.dart';
import 'package:jolly_podcast/core/components/utils/colors.dart';
import 'package:jolly_podcast/core/components/utils/helper_functions.dart';
import 'package:jolly_podcast/core/components/utils/package_export.dart';
import 'package:jolly_podcast/core/components/utils/size_config.dart';
import 'package:jolly_podcast/core/components/widgets/app_text.dart';
import 'package:jolly_podcast/core/components/widgets/custom_snackbar.dart';
import 'package:jolly_podcast/core/features/discover/controller/discover_home_screen.dart';
import 'package:jolly_podcast/core/features/discover/model/discover_podcast_model.dart';
import 'package:jolly_podcast/core/features/discover/states/editors_pick_state.dart';
import 'package:jolly_podcast/core/features/discover/states/trending_podcast_state.dart';
import 'package:jolly_podcast/core/features/discover/view/podcast_details_screen.dart';
import 'package:jolly_podcast/core/features/discover/widget/editors_podcast_widget.dart';
import 'package:jolly_podcast/core/features/discover/widget/trending_podcast_card.dart';

class DiscoverHomeScreenView
    extends StatelessView<DiscoverHomeScreen, DiscoverHomeScreenController> {
  const DiscoverHomeScreenView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    //Editors Pick PodcastDataModel
    final editorsPickPodcastState = controller.ref.watch(
      editorsPickPodcastProvider,
    );
    controller.ref.watch(editorsPickPodcastProvider.notifier);
    final model = editorsPickPodcastState.value;
    final isEditorsPickPodcastFetched = model?.hasFetched ?? false;
    final isEditorsPickPodcastLoading =
        editorsPickPodcastState.isLoading && !isEditorsPickPodcastFetched;
    final editorsPickPodcasts = model?.data ?? PodcastDataModel();

    // Trending Podcast
    final trendingPodcastState = controller.ref.watch(trendingPodcastProvider);
    controller.ref.watch(trendingPodcastProvider.notifier);
    final trendingPodcastModel = trendingPodcastState.value;
    final isTrendingPodcastFetched = trendingPodcastModel?.hasFetched ?? false;
    final isTrendingPodcastLoading =
        trendingPodcastState.isLoading && !isTrendingPodcastFetched;
    final trendingPodcast =
        trendingPodcastModel?.podcast ?? <PodcastDataModel>[];

    return Scaffold(
      backgroundColor: AppColors.greenBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.greenBackground,
        title: Image.asset(
          "assets/images/logo_path.png",
          width: SizeConfig.width(27),
          height: SizeConfig.width(27),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 12,
                  left: 8,
                  right: 8,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(
                        "assets/images/profile_image.png",
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.notifications, size: 28, color: AppColors.white),
                    const SizedBox(width: 16),
                    Icon(Icons.search, size: 28, color: AppColors.white),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpacing(5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AppText(
                isBody: true,
                text: "🔥 Hot & trending episodes",
                textAlign: TextAlign.start,
                fontSize: 20,
                color: AppColors.bodyWhite,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                letterSpacing: .3,
              ),
            ),
            addVerticalSpacing(2),
            if (isTrendingPodcastLoading)
              buildBookingShimmerCard(context)
            else if (trendingPodcast.isNotEmpty)
              SizedBox(
                height: 45.heightAdjusted,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingPodcast.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.widthAdjusted,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          navigateToRoute(
                            context,
                            PodcastDetailsScreen(
                              title: trendingPodcast[index].title!,
                              imageUrl: trendingPodcast[index].pictureUrl!,
                              description: trendingPodcast[index].description!,
                              audioUrl: trendingPodcast[index].contentUrl!,
                              duration: trendingPodcast[index].duration!
                                  .toDouble(),
                            ),
                          );
                        },
                        child: TrendingPodcastCard(
                          imageUrl: trendingPodcast[index].pictureUrl!,
                          title: trendingPodcast[index].title!,
                          description: trendingPodcast[index].description!,
                          podcastName:
                              trendingPodcast[index].podcast!.categoryType!,
                          onPlay: () {
                            navigateToRoute(
                              context,
                              PodcastDetailsScreen(
                                title: trendingPodcast[index].title!,
                                imageUrl: trendingPodcast[index].pictureUrl!,
                                description:
                                    trendingPodcast[index].description!,
                                audioUrl: trendingPodcast[index].contentUrl!,
                                duration: trendingPodcast[index].duration!
                                    .toDouble(),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            addVerticalSpacing(3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AppText(
                isBody: true,
                text: "⭐ Editor's pick",
                textAlign: TextAlign.start,
                fontSize: 20,
                color: AppColors.bodyWhite,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                letterSpacing: .3,
              ),
            ),

            addVerticalSpacing(2),
            if (isEditorsPickPodcastLoading)
              buildBookingShimmerCard(context)
            else if (trendingPodcast.isNotEmpty)
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    navigateToRoute(
                      context,
                      PodcastDetailsScreen(
                        title: editorsPickPodcasts.title!,
                        imageUrl: editorsPickPodcasts.pictureUrl!,
                        description: editorsPickPodcasts.description!,
                        audioUrl: editorsPickPodcasts.contentUrl!,
                        duration: editorsPickPodcasts.duration!.toDouble(),
                      ),
                    );
                  },
                  child: EditorsPickCard(
                    imageUrl: editorsPickPodcasts.pictureUrl!,
                    title: editorsPickPodcasts.title!,
                    description: editorsPickPodcasts.description!,
                    author: editorsPickPodcasts.podcast!.author!,
                    onPlay: () {
                      navigateToRoute(
                        context,
                        PodcastDetailsScreen(
                          title: editorsPickPodcasts.title!,
                          imageUrl: editorsPickPodcasts.pictureUrl!,
                          description: editorsPickPodcasts.description!,
                          audioUrl: editorsPickPodcasts.contentUrl!,
                          duration: editorsPickPodcasts.duration!.toDouble(),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
