// ignore_for_file: deprecated_member_use

import 'package:jolly_podcast/core/components/utils/colors.dart';
import 'package:jolly_podcast/core/components/utils/package_export.dart';

AppBar buildFlexibleAppBar({
  required BuildContext context,
  String backIconAsset = 'assets/svgs/back_button.svg',
  double iconWidth = 25.0,
  VoidCallback? onBack,
  Color backgroundColor = AppColors.white,
  Color surfaceTintColor = AppColors.white,
  Color foregroundColor = AppColors.white,
  bool showBackButton = true,
  Widget? title,
  List<Widget>? actions,
  Widget? bottomWidget, // e.g. Search bar, filter chips
  double bottomHeight = 56.0,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: false,
    backgroundColor: backgroundColor,
    surfaceTintColor: surfaceTintColor,
    foregroundColor: foregroundColor,
    elevation: 0,
    leading: showBackButton
        ? IconButton(
            onPressed: onBack ?? () => Navigator.pop(context),
            icon: SvgPicture.asset(backIconAsset, width: iconWidth),
          )
        : null,
    title: title,
    actions: actions,
    bottom: bottomWidget != null
        ? PreferredSize(
            preferredSize: Size.fromHeight(bottomHeight),
            child: bottomWidget,
          )
        : null,
  );
}
