import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/Module/Family%20Member/Add%20Family%20Member/Controller/add_family_member_controller.dart';
import 'package:userapp/Module/Login/Controller/login_controller.dart';
import 'package:userapp/Module/Signup/Resident%20Personal%20Detail/Controller/resident_personal_detail_controller.dart';

import '../../../../Constants/api_routes.dart';
import '../../../../Constants/constants.dart';
import '../../../../Routes/set_routes.dart';
import '../../../Login/Model/User.dart' as userModel;
import '../../../Signup/Resident Personal Detail/Model/Resident.dart';
import '../../Register/Controller/register_controller.dart';

class VerificationCodeController extends GetxController {
  final LoginController loginController = Get.put(LoginController());

  RxString otpCode = "".obs;
  RxString fcmToken = "".obs;
  RxString verificatioCode = "".obs;
  final otpCodeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RegisterController controller = Get.find();
  RxBool isLoading = false.obs;
  Resident? resident;

  verifyUserOtp() async {
    String smsCode = otpCodeController.text.toString();
    isLoading.value = true;

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificatioCode.value, smsCode: smsCode);

    UserCredential? userCredential = await _auth
        .signInWithCredential(credential)
        .catchError((error, stackTrace) {
      myToast(msg: error.toString(), isNegative: true);
      isLoading.value = false;
    });

    if (userCredential != null) {
      userCredential.user!.phoneNumber.toString().trim();
      log(userCredential.user!.phoneNumber.toString().trim());

      if (controller.type == 'SignUp') {
        final ResidentPersonalDetailController residentPersonalDetail =
            Get.find();

        await residentPersonalDetail.signUpApi(
          file: residentPersonalDetail.imageFile,
          lastName: residentPersonalDetail.lastnameController.text,
          cnic: residentPersonalDetail.cnicController.text,
          firstName: residentPersonalDetail.firstnameController.text,
          address: residentPersonalDetail.addressController.text,
          mobileno: userCredential.user!.phoneNumber.toString().trim(),
          password: residentPersonalDetail.passwordController.text,
        );
        isLoading.value = false;
      } else if (controller.type == 'AddFamilyMember') {
        final AddFamilyMemberController addFamilyMemberController = Get.find();

        await addFamilyMemberController.addFamilyMemberApi(
            bearerToken: addFamilyMemberController.userdata.bearerToken!,
            firstName: addFamilyMemberController.firstnameController.text,
            lastName: addFamilyMemberController.lastnameController.text,
            cnic: addFamilyMemberController.cnicController.text,
            address: addFamilyMemberController.resident.houseaddress!,
            mobileno: userCredential.user!.phoneNumber.toString().trim(),
            password: addFamilyMemberController.passwordController.text,
            file: addFamilyMemberController.imageFile,
            subadminid: addFamilyMemberController.resident.subadminid!,
            residentid: addFamilyMemberController.userdata.userId!);
        isLoading.value = false;
      } else if (controller.type == 'ForgetPassword') {
        print(userCredential.user!.phoneNumber.toString().trim());

        await forgetPasswordApi(
            mobileno: userCredential.user!.phoneNumber.toString().trim());

        isLoading.value = false;
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    verificatioCode.value = controller.verificationId.value;
    log(verificatioCode.value.toString());
  }

  Future forgetPasswordApi({
    required String mobileno,
  }) async {
    final response = await Http.post(
      Uri.parse(Api.forgetPassword),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "mobileno": mobileno,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      final userModel.User user = userModel.User(
          userId: data['data']['id'],
          subadminid: data['data']['subadminid'] ?? 0,
          residentid: data['data']['residentid'] ?? 0,
          firstName: data['data']['firstname'],
          lastName: data['data']['lastname'],
          cnic: data['data']['cnic'],
          roleId: data['data']['roleid'],
          roleName: data['data']['rolename'],
          address: data['data']['address'],
          bearerToken: data['Bearer']);

      Get.toNamed(forgetPassword, arguments: user);
    } else if (response.statusCode == 403) {
      print(response.body);
      myToast(msg: 'No User Found', isNegative: true);
    } else {
      myToast(msg: 'Operation Failed,Something went Wrong.', isNegative: true);
    }
  }
}
