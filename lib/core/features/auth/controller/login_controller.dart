// ignore_for_file: use_build_context_synchronously

import 'package:jolly_podcast/core/components/utils/error_handling.dart';
import 'package:jolly_podcast/core/components/helpers/globals.dart';
import 'package:jolly_podcast/core/components/state/connectivity_state.dart';
import 'package:jolly_podcast/core/components/utils/constants.dart';
import 'package:jolly_podcast/core/components/widgets/custom_snackbar.dart';

import 'package:jolly_podcast/core/features/home_screen.dart';

import '../services/auth_service.dart';
import '../../../components/utils/helper_functions.dart';
import '../../../components/utils/package_export.dart';

import '../view/logins.dart';

class LoginScreens extends ConsumerStatefulWidget {
  const LoginScreens({super.key});

  @override
  ConsumerState<LoginScreens> createState() => LoginScreensController();
}

class LoginScreensController extends ConsumerState<LoginScreens> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscureText = true;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  String? phoneNumber = "";
  String? password = "";
  bool saveButtonPressed = false;
  int currentIndex = 0;
  bool switchvalue = false;
  bool isLoading = false;
  String isCompleted = "";
  // late Login login;
  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  bool isChecked = false;
  Future<void> urlString(String? url) async {
    final link = Uri.parse(url!);
    if (await canLaunchUrl(link)) {
      await launchUrl(link);
    } else {
      throw 'Could not launch $url';
    }
  }

  void onChanged(bool? value) {
    setState(() {
      isChecked = value!;
    });
  }

  String isPasswordChanged = "";
  String isPhoneNoChanged = "";

  void passwordOnChanged(String value) {
    setState(() {
      isPasswordChanged = value;
    });
    printData("identifier", isPasswordChanged);
  }

  void phoneNoChanged(String value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          isPhoneNoChanged = value;
        });
        printData("identifier", isPhoneNoChanged);
      }
    });
  }

  Future<void> loginUser() async {
    var connectivityStatusProvider = ref.read(connectivityStatusProviders);
    setState(() {
      saveButtonPressed = true;
    });
    printData("identifier", phoneNumberController.text.trim());
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      if (connectivityStatusProvider.value == ConnectivityStatus.isConnected) {
        final res = await AuthService().userLogin(
          phoneNumber: phoneNumberController.text.trim(),
          password: passwordController.text.trim(),
        );
        await globals.init();

        if (res.statusCode == 200 || res.statusCode == 201) {
          setState(() {
            isLoading = false;
          });
          showCustomSnackbar(
            context,
            title: "Login Success",
            content: "User logged in successfully",
            type: SnackbarType.success,
            isTopPosition: false,
          );
          navigateAndReplaceRoute(context, const HomeScreenPage(index: 0));
        } else {
          final errorMessage = getErrorMessageFromResponse(
            res.statusCode,
            res.body,
          );
          setState(() {
            isLoading = false;
          });

          showCustomSnackbar(
            context,
            title: "Login Error",
            content: errorMessage,
            type: SnackbarType.error,
            isTopPosition: false,
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showCustomSnackbar(
          context,
          title: "Network Connection",
          content: "No Internet Connection",
          type: SnackbarType.error,
          isTopPosition: false,
        );
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreensView(this);
  }
}
