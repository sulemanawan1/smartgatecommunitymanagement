import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Module/NoticeBoard/Model/NoticeBoardModel.dart';

import '../../../Constants/api_routes.dart';
import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';

class NoticeBoardController extends GetxController {
  var data = Get.arguments;

  late final User userdata;
  late final Residents resident;
  var snapShot;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userdata = data[0];
    resident = data[1];
  }

  viewNoticeBoardApi(int subadminid, String token) async {
    try {
      final response = await Http.get(
        Uri.parse(Api.viewAllNotices + "/" + subadminid.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );
      var data = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return NoticeBoardModel.fromJson(data);
      } else {
        throw Exception('Failed to Load Data.');
      }
    } catch (e) {
      myToast(msg: 'Something Went Wrong');
    }
  }
}
