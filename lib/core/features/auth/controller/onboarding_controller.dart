import 'dart:async';

import '../../../components/utils/package_export.dart';
import '../view/onboarding_.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.next});
  final Widget next;
  static const String routeName = "/Onboard";
  @override
  State<OnboardingScreen> createState() => OnboardingScreenController();
}

class OnboardingScreenController extends State<OnboardingScreen> {
  @override
  void initState() {
    // Run after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (_, _, _) => widget.next,
            transitionsBuilder: (_, animation, _, child) =>
                FadeTransition(opacity: animation, child: child),
          ),
        );
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingView(this);
  }
}
