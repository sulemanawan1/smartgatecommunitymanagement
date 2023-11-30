import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/Constants/constants.dart';

import '../../../Constants/api_routes.dart';
import '../../../Routes/set_routes.dart';
import '../../Login/Model/User.dart';

class AddEmergencyController extends GetxController {
  var user = Get.arguments;
  late final User userdata;
  var resident;
  var isLoading = false.obs;

  EmergencyTypes emergencyGroup = EmergencyTypes.Fire;

  RxList<AllEmergencies> emergencies = <AllEmergencies>[
    AllEmergencies(
      title: 'Fire',
      emergencyTypes: EmergencyTypes.Fire,
      icon: Icons.local_fire_department,
    ),
    AllEmergencies(
      title: 'Short Circuit',
      emergencyTypes: EmergencyTypes.ShortCircuit,
      icon: Icons.warning,
    ),
    AllEmergencies(
      title: 'Medical Issue',
      emergencyTypes: EmergencyTypes.MedicalIssue,
      icon: Icons.medical_services_outlined,
    ),
    AllEmergencies(
      title: 'Theft / Robbery',
      emergencyTypes: EmergencyTypes.Theft,
      icon: Icons.sports_kabaddi,
    ),
    AllEmergencies(
      title: 'Others',
      emergencyTypes: EmergencyTypes.Other,
      icon: Icons.more_horiz_sharp,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();

    userdata = this.user[0];
    resident = this.user[1];
  }

  TextEditingController descriptionController = TextEditingController();

  Future addEmergencyApi({
    required int residentid,
    required int societyid,
    required int subadminid,
    required String token,
    required String problem,
    required String description,
  }) async {
    isLoading.value = true;

    try {
      final response = await Http.post(
        Uri.parse(Api.addEmergency),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
        body: jsonEncode(<String, dynamic>{
          "residentid": residentid,
          "societyid": societyid,
          "subadminid": subadminid,
          "problem": problem,
          "description": description,
          "status": "0",
        }),
      );

      if (response.statusCode == 200) {
        Get.offAndToNamed(emergencyContact, arguments: userdata);
        isLoading.value = false;

        myToast(msg: 'Emergency Problem Reported');
      } else if (response.statusCode == 403) {
        myToast(msg: 'UnAuthorized');
        isLoading.value = false;
      } else {
        throw Exception('Failed to Submit Emergency.');
      }
    } catch (e) {
      myToast(msg: e.toString());
      isLoading.value = false;
    }
  }
}

enum EmergencyTypes { Fire, ShortCircuit, Theft, MedicalIssue, Other }

class AllEmergencies {
  EmergencyTypes? emergencyTypes;
  String? title;
  IconData? icon;

  AllEmergencies({this.title, this.emergencyTypes, this.icon});
}
