import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jolly_podcast/core/components/utils/colors.dart';
import 'package:jolly_podcast/core/components/utils/constants.dart';
import 'package:jolly_podcast/core/components/utils/size_config.dart';
import 'package:jolly_podcast/core/components/widgets/app_text.dart';
import 'package:jolly_podcast/core/features/discover/states/player_state.dart';

class PodcastDetailsScreen extends ConsumerStatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String audioUrl;
  final double duration;

  const PodcastDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.audioUrl,
    required this.duration,
  });

  @override
  ConsumerState<PodcastDetailsScreen> createState() =>
      _PodcastDetailsScreenState();
}

class _PodcastDetailsScreenState extends ConsumerState<PodcastDetailsScreen> {
  String formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(
      playerStateControllerProvider(widget.audioUrl),
    );

    final notifier = ref.read(
      playerStateControllerProvider(widget.audioUrl).notifier,
    );
    printData("identifier", widget.duration);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF0DCB63),

      body: Container(
        decoration: BoxDecoration(
          // 3. Semi-transparent dark overlay for contrast
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomCenter,
            colors: AppColors.cardGradient,
          ),
        ),
        child: Column(
          children: [
            addVerticalSpacing(5),
            GestureDetector(
              onTap: () => Navigator.pop(context), // <--- TRIGGER HERE
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 1.5),
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    addVerticalSpacing(5),
                    // ARTWORK
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: NetworkImage(widget.imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    addVerticalSpacing(2),

                    // TITLE
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppText(
                        isBody: true,
                        text: widget.title,
                        textAlign: TextAlign.start,
                        fontSize: 20,
                        color: AppColors.bodyWhite,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .3,
                      ),
                    ),

                    addVerticalSpacing(2),
                    // DESCRIPTION
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppText(
                        isBody: true,
                        text: widget.description,
                        textAlign: TextAlign.start,
                        fontSize: 15,
                        color: AppColors.bodyWhite,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .3,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                    addVerticalSpacing(2),
                    controller.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Center(child: Text("Error: $e")),
                      data: (state) {
                        final duration =
                            state.duration ??
                            Duration(seconds: widget.duration.toInt());
                        final position = state.position;

                        return Column(
                          children: [
                            // SEEK BAR
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 3,
                                inactiveTrackColor: AppColors.bodyGrey,
                                activeTrackColor: AppColors.white,
                                thumbColor: AppColors.white,
                                overlayColor: AppColors.white,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius:
                                      6, // small circle like screenshot
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 12,
                                ),
                              ),
                              child: Slider(
                                value: position.inSeconds.toDouble(),
                                min: 0,
                                max: duration.inSeconds.toDouble(),
                                onChanged: (v) {
                                  notifier.seek(Duration(seconds: v.toInt()));
                                },
                              ),
                            ),

                            // TIME LABELS
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatTime(position),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    formatTime(duration),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // PLAYER CONTROLS
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.replay_10, size: 34),
                                  color: AppColors.white,
                                  onPressed: () {
                                    notifier.seek(
                                      position - const Duration(seconds: 10),
                                    );
                                  },
                                ),

                                addHorizontalSpacing(6),

                                GestureDetector(
                                  onTap: () => notifier.playPause(),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: AppColors.white,
                                        width: 1.5,
                                      ),

                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      state.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 24,
                                      color: AppColors.bodyWhite,
                                    ),
                                  ),
                                ),

                                addHorizontalSpacing(6),

                                IconButton(
                                  icon: const Icon(Icons.forward_10, size: 34),
                                  color: Colors.white,
                                  onPressed: () {
                                    notifier.seek(
                                      position + const Duration(seconds: 10),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),

                    addVerticalSpacing(4),

                    // BOTTOM BUTTONS
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 4,
                        runSpacing: 18,
                        children: [
                          _circleButton("Add to queue", Icons.add),
                          _circleButton("Save", Icons.favorite_border),
                          _circleButton("Share episode", Icons.share),
                          _circleButton("Add to playlist", Icons.playlist_add),
                          _circleButton(
                            "Go to episode page",
                            Icons.open_in_new,
                          ),
                        ],
                      ),
                    ),

                    addVerticalSpacing(2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white, width: 1.5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // 👈 VERY IMPORTANT
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 6),
          AppText(
            isBody: true,
            text: label,
            textAlign: TextAlign.center,
            fontSize: 12,
            color: AppColors.bodyWhite,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
