import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/Constants/constants.dart';

import '../../../../Constants/api_routes.dart';

class ResetPasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  var isHidden = false;
  var isLoading = false;

  Future resetPasswordApi({
    required int familymemberid,
    required String bearerToken,
    required String password,
  }) async {
    isLoading = true;
    update();
    Map<String, String> headers = {"Authorization": "Bearer $bearerToken"};

    var request = Http.MultipartRequest('POST', Uri.parse(Api.resetPassword));
    request.headers.addAll(headers);

    request.fields['password'] = password;
    request.fields['id'] = familymemberid.toString();
    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      isLoading = false;
      passwordController.clear();
      update();

      myToast(msg: data['message'].toString());
      Get.back();
    } else if (response.statusCode == 403) {
      isLoading = false;
      update();
      myToast(msg: response.body.toString(), isNegative: true);
    } else {
      isLoading = false;
      update();
      myToast(msg: 'Something Wents Wrong', isNegative: true);
    }
  }

  void togglePasswordView() {
    isHidden = !isHidden;
    update();
  }
}
