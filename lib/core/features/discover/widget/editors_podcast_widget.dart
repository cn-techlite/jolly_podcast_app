import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/components/utils/colors.dart';
import 'package:jolly_podcast/core/components/utils/size_config.dart';
import 'package:jolly_podcast/core/components/widgets/app_text.dart';

class EditorsPickCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String description;
  final VoidCallback onPlay;

  const EditorsPickCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.description,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F17),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // === LEFT IMAGE & PLAY BUTTON ===
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 35.widthAdjusted,
                  height: 20.heightAdjusted,
                  fit: BoxFit.fill,
                ),
              ),

              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
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
              ),
            ],
          ),

          addHorizontalSpacing(4),

          // === RIGHT TEXT SECTION ===
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Title
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

                // Author
                AppText(
                  isBody: true,
                  text: author,
                  textAlign: TextAlign.start,
                  fontSize: 15,
                  color: AppColors.bodyWhite,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  letterSpacing: .3,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),

                addVerticalSpacing(.5),

                // Description
                AppText(
                  isBody: true,
                  text: title,
                  textAlign: TextAlign.start,
                  fontSize: 15,
                  color: AppColors.bodyWhite,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  letterSpacing: .3,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),

                addVerticalSpacing(.5),

                // FOLLOW BUTTON + SHARE + MORE
                Row(
                  children: [
                    // Follow Button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.bodyGrey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.add, color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text(
                              "Follow",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Share
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share_outlined,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
