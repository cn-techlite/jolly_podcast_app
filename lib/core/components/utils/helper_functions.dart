// ignore_for_file: deprecated_member_use

import 'package:jolly_podcast/core/components/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:jolly_podcast/main.dart';

import '../routes/routers.dart';
import 'colors.dart';

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void popSheet(BuildContext context) {
  Navigator.of(context).pop();
}

void navigateBack(BuildContext context) {
  Navigator.pop(context);
}

void navigateToRoute(BuildContext context, dynamic routeClass) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => routeClass));
}

void navigateToTabRoute(BuildContext context, dynamic routeClass) {
  navigatorKey.currentState!.push(
    CupertinoPageRoute(builder: (context) => routeClass),
  );
}

void navigateAndReplaceRoute(BuildContext context, dynamic routeClass) {
  Navigator.pushReplacement(
    context,
    CupertinoPageRoute(builder: (context) => routeClass),
  );
}

void navigateTabAndReplaceRoute(BuildContext context, dynamic routeClass) {
  navigatorKey.currentState!.pushReplacement(
    CupertinoPageRoute(builder: (context) => routeClass),
  );
}

void navigateAndRemoveUntilRoute(BuildContext context, dynamic routeClass) {
  Navigator.pushAndRemoveUntil(
    context,
    CupertinoPageRoute(builder: (context) => routeClass),
    (route) => false,
  );
}

void navigateTabAndRemoveUntilRoute(BuildContext context, dynamic routeClass) {
  navigatorKey.currentState!.pushAndRemoveUntil(
    CupertinoPageRoute(builder: (context) => routeClass),
    (route) => false,
  );
}

void navPush(BuildContext context, String route) {
  Navigator.push(context, generateRoute(RouteSettings(name: route)));
}

void navTabPush(BuildContext context, String route) {
  navigatorKey.currentState!.push(generateRoute(RouteSettings(name: route)));
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

Container buildCachedNetworkImage({
  required String image,
  required double height,
  required double width,
}) {
  return Container(
    width: SizeConfig.height(width),
    height: SizeConfig.height(height),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(3.heightAdjusted),
      color: AppColors.grey,
      border: Border.all(color: AppColors.grey),
      image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
    ),
  );
}

class KeyboardUtils {
  static bool isKeyboardShowing() {
    // ignore: unnecessary_null_comparison
    return WidgetsBinding.instance.window.viewInsets.bottom > 0;
  }

  static void closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
