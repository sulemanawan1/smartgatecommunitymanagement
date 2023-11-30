import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../../Constants/constants.dart';
import '../../../../Helpers/Validation Helper/validation_helper.dart';
import '../../../../Widgets/My Button/my_button.dart';
import '../../Register/Controller/register_controller.dart';
import '../Controller/verification_code_controller.dart';

class VerificationCode extends StatelessWidget {
  final verificationCodeController = Get.put(VerificationCodeController());

  final registerController = Get.put(RegisterController());
  VerificationCode({super.key});

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: primaryColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outlined,
                    size: 80,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    "Verification Code",
                    style: GoogleFonts.ubuntu(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    "Enter your 6 digits verification code.",
                    style: GoogleFonts.ubuntu(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  6.h.ph,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Pinput(
                      validator: ValidationHelper().otpValidator,
                      controller: verificationCodeController.otpCodeController,
                      length: 6,
                      onCompleted: (val) {
                        verificationCodeController.otpCode.value = val;
                      },
                    ),
                  ),
                  6.h.ph,
                  Obx(() {
                    return MyButton(
                      loading: verificationCodeController.isLoading.value,
                      name: 'Next',
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          if (!verificationCodeController.isLoading.value) {
                            verificationCodeController.verifyUserOtp();
                          }
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
