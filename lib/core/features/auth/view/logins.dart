import 'package:flutter/gestures.dart';
import 'package:jolly_podcast/core/components/utils/package_export.dart';
import 'package:jolly_podcast/core/components/utils/size_config.dart';
import '../../../components/architecture/mvc.dart';
import '../../../components/utils/app_buttons.dart';
import '../../../components/utils/colors.dart';
import '../../../components/widgets/app_text.dart';
import '../../../components/widgets/input.dart';

import '../controller/login_controller.dart';

class LoginScreensView
    extends StatelessView<LoginScreens, LoginScreensController> {
  const LoginScreensView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        height: 100.heightAdjusted,
        decoration: BoxDecoration(
          color: AppColors.black,
          image: DecorationImage(
            image: AssetImage("assets/images/login_image.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.widthAdjusted),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  addVerticalSpacing(35),
                  Center(
                    child: Image.asset(
                      "assets/images/logo_path.png",
                      height: 12.heightAdjusted,
                      width: 50.widthAdjusted,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const AppText(
                    isBody: false,
                    text: "PODCASTS FOR AFRICA, BY AFRICANS",
                    textAlign: TextAlign.center,
                    fontSize: 20,
                    color: AppColors.bodyWhite,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                  ),

                  addVerticalSpacing(2),

                  GlobalPhoneTextField(
                    fieldName: 'Enter your phone number',
                    textController: controller.phoneNumberController,
                    onChanged: (value) {
                      controller.phoneNoChanged(value!.completeNumber);
                    },
                  ),

                  GlobalTextField(
                    fieldName: 'Password',
                    obscureText: true,
                    isEyeVisible: true,
                    isNotePad: false,
                    keyBoardType: TextInputType.name,
                    textController: controller.passwordController,
                    onChanged: (String? value) {
                      controller.passwordOnChanged(value!);
                    },
                  ),
                  addVerticalSpacing(2),

                  controller.isPhoneNoChanged.isEmpty ||
                          controller.isPasswordChanged.isEmpty
                      ? AppButton(
                          text: "Continue",
                          onPressed: () {},
                          widthPercent: 100,
                          heightPercent: 7,
                          btnColor: AppColors.primary,
                          isLoading: false,
                        )
                      : AppButton(
                          text: "Continue",
                          onPressed: () {
                            controller.loginUser();
                          },
                          widthPercent: 100,
                          heightPercent: 7,
                          isLoading: controller.isLoading,
                        ),
                  addVerticalSpacing(2),

                  Center(
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: AppColors.bodyWhite,
                          fontSize: 12.textSize,
                        ),
                        text: "By proceeding, you agree and accept our ",
                        children: <TextSpan>[
                          TextSpan(
                            text: "T&C",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              color: AppColors.bodyWhite,
                              fontSize: 15.textSize,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.white,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {},
                    child: const AppText(
                      isBody: false,
                      text: "BECOME A PODCAST CREATOR",
                      textAlign: TextAlign.center,
                      fontSize: 18,
                      color: AppColors.bodyWhite,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  addVerticalSpacing(2),

                  addVerticalSpacing(2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
