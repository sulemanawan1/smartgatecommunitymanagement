import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../Constants/constants.dart';
import '../../../../Routes/set_routes.dart';
import '../../../Signup/Resident Personal Detail/Model/Resident.dart';

class RegisterController extends GetxController {
  var type = Get.arguments;

  final phoneNumberController = TextEditingController();
  RxString countryFlag = "".obs;
  RxString countryCode = "".obs;
  RxString phoneNumber = "".obs;
  Country country = Country(
      phoneCode: "92",
      countryCode: "PK",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Pakistan',
      example: 'Pakistan',
      displayName: 'Pakistan',
      displayNameNoCountryCode: 'PK',
      e164Key: "");

  RxString verificationId = "".obs;
  Resident? resident;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    countryCode.value = country.phoneCode;
    countryFlag.value = country.flagEmoji;
  }

  verifyUserPhoneNumber() async {
    isLoading.value = true;
    print("object");
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber.toString().trim(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("object 2");

        await FirebaseAuth.instance.signInWithCredential(credential);
        isLoading.value = false;
      },
      verificationFailed: (FirebaseAuthException e) {
        isLoading.value = false;

        myToast(msg: e.code.toString(), isNegative: true);
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId.value = verificationId;
        isLoading.value = false;
        Get.toNamed(verificationCode);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        isLoading.value = false;
      },
    );
  }
}
