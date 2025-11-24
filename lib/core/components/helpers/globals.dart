import 'dart:convert';

import 'package:jolly_podcast/core/components/utils/error_handling.dart';

import '../../features/auth/model/login_response_model.dart';
import '../utils/constants.dart';
import '../utils/package_export.dart';
import 'endpoints.dart';
import 'package:http/http.dart' as http;

final GetIt getIt = GetIt.instance;

class AppGlobals {
  factory AppGlobals() => instance;

  AppGlobals._();

  static final AppGlobals instance = AppGlobals._();

  String? isLoggedIn;
  int? isViewed;
  String? userEmail = "";
  String? userPassword = "";
  String? token = "";
  int? userId = 0;
  String? userName = "";
  String? userPhone = "";

  Future<void> init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = await getIntFromLocalStorage(name: "userId") ?? 0;
    token = await getFromLocalStorage(name: "token") ?? "";
    userEmail = await getFromLocalStorage(name: "userEmail") ?? "";
    userPassword = await getFromLocalStorage(name: "userPassword") ?? "";
    userName = await getFromLocalStorage(name: "userName") ?? "";
    userPhone = await getFromLocalStorage(name: "userPhone") ?? "";

    isViewed = preferences.getInt('onBoard');
    isLoggedIn = preferences.getString('isLoggedIn') ?? "";

    isViewed = preferences.getInt('onBoard');
    isLoggedIn = preferences.getString('isLoggedIn') ?? "";
    printData("userId", userId);
    printData("UserEmail", userEmail);
    printData("Token", token);
  }

  Future<void> login() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userPassword = await getFromLocalStorage(name: "userPassword") ?? "";
    try {
      Map<String, String> headers2 = {
        //  'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${globals.token}',
      };
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${Endpoints.baseUrl}${Endpoints.usersLoginUrl}"),
      );
      request.headers.addAll(headers2);
      request.fields['phone_number'] = userPhone!;
      request.fields['password'] = userPassword;
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      printData("dataResponse", response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
          jsonDecode(response.body),
        );
        setToLocalStorage(
          name: "token",
          data: loginResponseModel.data?.token ?? "",
        );
        setToLocalStorage(
          name: "userEmail",
          data: loginResponseModel.data?.user?.email ?? "",
        );
        setIntToLocalStorage(
          name: "userId",
          data: loginResponseModel.data?.user?.id ?? 0,
        );

        setToLocalStorage(
          name: "userName",
          data:
              "${loginResponseModel.data?.user?.firstName ?? ""} ${loginResponseModel.data?.user?.lastName ?? ""}",
        );
        setToLocalStorage(
          name: "userPhone",
          data: loginResponseModel.data?.user?.phoneNumber ?? "",
        );
        printData("verify", loginResponseModel);

        await init();
      } else if (response.statusCode == 401) {
        printData("Error", response.body);
        preferences.remove("token");
        preferences.remove("userEmail");
        preferences.remove("userId");
        preferences.remove("userPassword");
        await init();
      } else {
        printData("errors", response.body);
        printData("Error", response.body);
        preferences.remove("token");
        preferences.remove("userEmail");
        preferences.remove("userId");
        preferences.remove("userPassword");
        await init();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login2() async {
    try {
      String userPassword =
          await getFromLocalStorage(name: "userPassword") ?? "";
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var url = Uri.parse("${Endpoints.baseUrl}${Endpoints.usersLoginUrl}");
      final msg = jsonEncode({
        "phone_number": userPhone,
        "password": userPassword,
      });
      http.Response response = await http.post(
        url,
        body: msg,
        headers: headers,
      );
      printData("Status code", response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
          jsonDecode(response.body),
        );
        setToLocalStorage(
          name: "token",
          data: loginResponseModel.data?.token ?? "",
        );
        setToLocalStorage(
          name: "userEmail",
          data: loginResponseModel.data?.user?.email ?? "",
        );
        setIntToLocalStorage(
          name: "userId",
          data: loginResponseModel.data?.user?.id ?? 0,
        );

        setToLocalStorage(
          name: "userName",
          data:
              "${loginResponseModel.data?.user?.firstName ?? ""} ${loginResponseModel.data?.user?.lastName ?? ""}",
        );

        await globals.init();
      } else {
        printData("errors", response.body);
      }
    } catch (e) {
      printData('Error', e.toString());
      return Future.error(handleHttpError(e));
    }
  }

  void dispose() {}
}

AppGlobals globals = getIt.get<AppGlobals>();
Future<void> setupLocator() async {
  // Register dependencies
}
