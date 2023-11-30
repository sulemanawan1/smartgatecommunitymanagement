import 'dart:async';

import 'package:get/get.dart';

import '../../../Routes/set_routes.dart';
import '../../Login/Model/User.dart';

class EmergencyContactController extends GetxController {
  var user = Get.arguments;
  late final User userdata;
  var resident;

  Uri? uri;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userdata = this.user;

    Timer(Duration(seconds: 15), () {
      Get.offAllNamed(homescreen, arguments: userdata);
    });
  }
}
