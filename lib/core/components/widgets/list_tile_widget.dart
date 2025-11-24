import 'package:jolly_podcast/core/components/utils/colors.dart';
import 'package:jolly_podcast/core/components/utils/package_export.dart';
import 'package:jolly_podcast/core/components/widgets/app_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;

  const CustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(height: 35, width: 35, imageUrl),
      title: AppText(
        isBody: true,
        text: title,
        textAlign: TextAlign.start,
        fontSize: 20,
        color: AppColors.titleGrey,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
      ),
      subtitle: subtitle.isEmpty
          ? null
          : AppText(
              isBody: false,
              text: subtitle,
              textAlign: TextAlign.start,
              fontSize: 16,
              color: AppColors.bodyGrey,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
      onTap: onTap, // Handle tap event
    );
  }
}
