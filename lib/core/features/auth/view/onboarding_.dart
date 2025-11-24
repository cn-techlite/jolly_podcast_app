import '../../../components/architecture/mvc.dart';
import '../../../components/utils/colors.dart';
import '../../../components/utils/package_export.dart';
import '../controller/onboarding_controller.dart';

class OnboardingView
    extends StatelessView<OnboardingScreen, OnboardingScreenController> {
  const OnboardingView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.black,
          image: DecorationImage(
            image: AssetImage("assets/images/splash_screen.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
