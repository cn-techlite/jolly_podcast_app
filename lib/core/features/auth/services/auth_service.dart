// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:jolly_podcast/core/components/utils/error_handling.dart';
import 'package:http/http.dart' as http;

import '../../../components/helpers/endpoints.dart';
import '../../../components/helpers/globals.dart';
import '../../../components/utils/constants.dart';
import '../model/login_response_model.dart';

class AuthService {
  Future<http.Response> userLogin({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      Map<String, String> headers2 = {
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*',
        'Authorization': 'Bearer ${globals.token}',
      };
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${Endpoints.baseUrl}${Endpoints.usersLoginUrl}"),
      );
      request.headers.addAll(headers2);
      request.fields['phone_number'] = phoneNumber;
      request.fields['password'] = password;
      var res = await request.send();
      var response = await http.Response.fromStream(res);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        printData('Api body', (data));
        LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
          jsonDecode(response.body),
        );
        setToLocalStorage(
          name: "token",
          data: loginResponseModel.data?.token ?? "",
        );
        setToLocalStorage(name: "userPassword", data: password);
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
        await globals.init();
        return response;
      } else {
        printData('Upload Error', (response.statusCode));
        return response;
      }
    } catch (e) {
      printData('Error', e.toString());
      return Future.error(handleHttpError(e));
    }
  }

  Future<http.Response> userLogin2({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var url = Uri.parse("${Endpoints.baseUrl}${Endpoints.usersLoginUrl}");
      final msg = jsonEncode({
        "phone_number": phoneNumber,
        "password": password,
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
        setToLocalStorage(name: "userPassword", data: password);

        await globals.init();
        return response;
      } else {
        printData("errors", response.body);
        return response;
      }
    } catch (e) {
      printData('Error', e.toString());
      return Future.error(handleHttpError(e));
    }
  }
}
