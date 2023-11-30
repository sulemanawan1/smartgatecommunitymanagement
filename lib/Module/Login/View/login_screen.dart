import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Routes/set_routes.dart';

import '../../../Constants/constants.dart';
import '../../../Widgets/My Button/my_button.dart';
import '../../../Widgets/My Password TextForm Field/my_password_textform_field.dart';
import '../../../Widgets/My TextForm Field/my_textform_field.dart';
import '../Controller/login_controller.dart';

class Login extends GetView {
  final _formKey = new GlobalKey<FormState>();

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        38.h.ph,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 58.w),
                          child: Image.asset(
                            'assets/login_vector.png',
                            width: 302.w,
                            height: 201.w,
                          ),
                        ),
                        33.91.h.ph,
                        Center(
                          child: Text(
                            "Welcome to",
                            style: GoogleFonts.ubuntu(
                              color: HexColor('#4D4D4D'),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 36.sp,
                            ),
                          ),
                        ),
                        10.h.ph,
                        Center(
                          child: Text(
                            "RESIDENTS APP ",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ubuntu(
                                color: HexColor('#717171'),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                                letterSpacing: 6.2.w),
                          ),
                        ),
                        30.h.ph,
                        Center(
                          child: Text(
                            "Log In",
                            style: GoogleFonts.ubuntu(
                              color: HexColor('#FF9900'),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        30.h.ph,
                        MyTextFormField(
                          validator: ValidationHelper().validatePhoneNumber,
                          controller: controller.phoneNumberController,
                          textInputType: TextInputType.number,
                          hintText: 'Phone Number',
                          labelText: 'Phone Number',
                          prefixIcon: GestureDetector(
                              onTap: () {
                                showCountryPicker(
                                    context: context,
                                    countryListTheme: CountryListThemeData(
                                      flagSize: 30,
                                      backgroundColor: Colors.white,
                                      textStyle: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                      bottomSheetHeight: 500,
                                      // Optional. Country list modal height
                                      //Optional. Sets the border radius for the bottomsheet.
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0),
                                      ),
                                      //Optional. Styles the search field.
                                      inputDecoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: primaryColor,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: primaryColor,
                                          ),
                                        ),
                                        labelStyle: GoogleFonts.montserrat(
                                          color: HexColor('#B6B6B6'),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        labelText: 'Search',
                                        hintText: 'Start typing to search',
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: primaryColor,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onSelect: (Country country) {
                                      controller.countryFlag.value =
                                          country.flagEmoji;
                                      controller.countryCode.value =
                                          country.phoneCode;
                                    });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 16, 8, 0),
                                child: Obx(() {
                                  return Text(
                                    "${controller.countryFlag} + ${controller.countryCode}",
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  );
                                }),
                              )),
                          onTap: () {},
                        ),
                        Obx(() {
                          return MyPasswordTextFormField(
                              controller: controller.userPasswordController,
                              validator:
                                  ValidationHelper().emptyStringValidator,
                              labelText: 'Password',
                              hintText: 'Password',
                              togglePasswordView: controller.togglePasswordView,
                              obscureText: controller.isHidden.value);
                        }),
                        33.h.ph,
                        Obx(() {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(99.w, 0, 103.w, 0),
                            child: MyButton(
                              loading: controller.isLoading.value,
                              width: 173.w,
                              height: 43.w,
                              border: 16.0.r,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.phoneNumber.value =
                                      "+${controller.countryCode}${controller.phoneNumberController.text}";

                                  if (!controller.isLoading.value) {
                                    controller.loginApi(
                                        controller.phoneNumber.value,
                                        controller.userPasswordController.text);
                                  }
                                }
                              },
                              name: 'LOG IN',
                            ),
                          );
                        }),
                        25.h.ph,
                        Center(
                          child: GestureDetector(
                              onTap: () {
                                Get.toNamed(register,
                                    arguments: 'ForgetPassword');
                              },
                              child: Text(
                                "Forget Password?",
                                style: GoogleFonts.ubuntu(
                                    color: primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                        25.h.ph,
                        Center(
                          child: Wrap(
                            children: [
                              Text(
                                "Don't have an Account ?",
                                style: GoogleFonts.ubuntu(
                                    color: Colors.grey,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              10.w.pw,
                              GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed(residentpersonaldetail);
                                  },
                                  child: Text(
                                    "Signup",
                                    style: GoogleFonts.ubuntu(
                                        color: primaryColor,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ],
                          ),
                        ),
                        57.h.ph,
                      ]),
                ))));
  }
}
