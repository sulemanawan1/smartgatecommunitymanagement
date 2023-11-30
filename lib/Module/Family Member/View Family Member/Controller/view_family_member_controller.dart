import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/Module/Family%20Member/View%20Family%20Member/Model/Familymember.dart';

import '../../../../Constants/api_routes.dart';
import '../../../HomeScreen/Model/residents.dart';
import '../../../Login/Model/User.dart';

class ViewFamilyMemberController extends GetxController {
  late final User userdata;
  late final Residents resident;
  var data = Get.arguments;
  bool familyMemberCountExceed = false;
  bool isLoading = false;
  int familyMemberCount = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userdata = data[0];
    resident = data[1];
  }

  checkFamilyMemberCount({required count}) {
    if (count >= 3) {
      familyMemberCountExceed = true;
    }
  }

  viewResidentsApi(int subadminId, int residentid, String token) async {
    isLoading = true;
    update();
    final response = await Http.get(
      Uri.parse(Api.viewFamilyMember +
          "/" +
          subadminId.toString() +
          "/" +
          residentid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return Familymember.fromJson(data);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
