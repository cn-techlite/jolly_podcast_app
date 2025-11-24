import 'package:jolly_podcast/core/components/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/features/auth/controller/onboarding_controller.dart';
import '../../features/auth/controller/login_controller.dart';
import '../../features/home_screen.dart';
import '../helpers/globals.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RootRoutes.login:
      return MaterialPageRoute(
        builder: (context) => OnboardingScreen(next: LoginScreens()),
      );

    case RootRoutes.tab:
      return MaterialPageRoute(
        builder: (context) =>
            OnboardingScreen(next: const HomeScreenPage(index: 0)),
      );

    default:
      {
        return _errorRoute();
      }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (context) {
      return Scaffold(
        appBar: AppBar(title: const Text('ERROR'), centerTitle: true),
        body: const Center(child: Text('Page not found!')),
      );
    },
  );
}

Future<String> initialRoute() async {
  return globals.token!.isEmpty ? RootRoutes.login : RootRoutes.tab;
}
