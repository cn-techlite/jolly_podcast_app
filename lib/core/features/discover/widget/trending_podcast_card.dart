// ignore_for_file: deprecated_member_use
import 'dart:ui' as ui; // 1. Import for ImageFilter

import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/components/utils/colors.dart';
import 'package:jolly_podcast/core/components/utils/size_config.dart';
import 'package:jolly_podcast/core/components/widgets/app_text.dart';

class TrendingPodcastCard extends StatelessWidget {
  final String imageUrl;
  final String podcastName;
  final String title;
  final String description;
  final VoidCallback onPlay;

  const TrendingPodcastCard({
    super.key,
    required this.imageUrl,
    required this.podcastName,
    required this.title,
    required this.description,
    required this.onPlay,
  });

  // --- Helper Widget for Circular Icons ---
  Widget _iconCircle(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.35), width: 1),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.widthAdjusted,
      height: 160.heightAdjusted,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // ====== Background Image (FULL) ======
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit
                    .fill, // Changed from BoxFit.fill to BoxFit.cover for better image scaling
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.white70,
                    size: 50,
                  ),
                ),
              ),
            ),

            // Play button in top-image area
            Positioned(
              top: 13.heightAdjusted,
              left: 24,
              child: GestureDetector(
                onTap: onPlay, // <--- TRIGGER HERE
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 1.5),
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.green,
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: 30,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),

            // ====== BOTTOM TEXT AREA with BackdropFilter (BLUR) ======
            Positioned(
              left: 0,
              right: 0,
              bottom: 0, // Positioned at the very bottom
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                child: BackdropFilter(
                  // 2. Apply Gaussian blur
                  filter: ui.ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      // 3. Semi-transparent dark overlay for contrast
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomCenter,
                        colors: AppColors.cardGradient,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 12,
                        top: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            isBody: true,
                            text: podcastName,
                            textAlign: TextAlign.start,
                            fontSize: 12,
                            color: AppColors.bodyWhite,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            letterSpacing: .3,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),

                          addVerticalSpacing(.5),
                          AppText(
                            isBody: true,
                            text: title,
                            textAlign: TextAlign.start,
                            fontSize: 20,
                            color: AppColors.bodyWhite,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            letterSpacing: .3,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),

                          addVerticalSpacing(.5),
                          AppText(
                            isBody: true,
                            text: description,
                            textAlign: TextAlign.start,
                            fontSize: 12,
                            color: AppColors.bodyWhite,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            letterSpacing: .3,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),

                          addVerticalSpacing(1),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: _iconCircle(Icons.favorite_border),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: _iconCircle(Icons.share_outlined),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: _iconCircle(Icons.download_outlined),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: _iconCircle(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
