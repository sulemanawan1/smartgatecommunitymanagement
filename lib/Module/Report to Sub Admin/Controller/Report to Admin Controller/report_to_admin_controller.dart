import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Routes/set_routes.dart';

import '../../../../Constants/api_routes.dart';
import '../../../HomeScreen/Model/residents.dart';
import '../../../Login/Model/User.dart';

class AddReportToAdminController extends GetxController {
  var user = Get.arguments;
  late DateTime dateTime;
  late final User userdata;
  Residents? resident;
  var isLoading = false;

  List<Map<String, dynamic>> visitorTypes = [
    {"id": 1, "name": "Cab", "status": false, "icon": "assets/cab_icon.svg"},
    {
      "id": 2,
      "name": "Delivery",
      "status": false,
      "icon": "assets/delivery_icon.svg"
    },
    {
      "id": 3,
      "name": "Guest",
      "status": false,
      "icon": "assets/guest_icon.svg"
    },
    {
      "id": 4,
      "name": "Visiting Help",
      "status": false,
      "icon": "assets/visiting_help_icon.svg"
    }
  ];

  setVistortype(bool status) {
    status != true;
    print(visitorTypes);
    update();
    return status;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    this.userdata = user[0];
    this.resident = user[1];
    print(userdata.userId);
    print(userdata.bearerToken);
    print(userdata.subadminid);
  }

  final formKey = new GlobalKey<FormState>();

  TextEditingController reportTitleController = TextEditingController();
  TextEditingController reportDescriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Future reportToAdminApi({
    required int userid,
    required String token,
    required String title,
    required String description,
    required int subadminid,
  }) async {
    isLoading = true;
    update();
    final response = await Http.post(
      Uri.parse(Api.reportToAdmin),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "userid": userid,
        "subadminid": subadminid,
        "title": title,
        "description": description,
        "status": "0",
        "statusdescription": "pending",
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      isLoading = false;
      update();
      Get.offAndToNamed(adminreports, arguments: user);

      myToast(msg: 'Report Submitted  Successfully');
    } else {
      isLoading = false;
      update();
      myToast(msg: 'Failed to Submit Report');
    }
  }
}
