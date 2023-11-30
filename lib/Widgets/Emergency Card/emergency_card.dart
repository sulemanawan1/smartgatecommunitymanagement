import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Constants/constants.dart';

import '../../Helpers/Validation Helper/validation_helper.dart';
import '../../Module/Emergency/Controller/emergency_controller.dart';
import '../My TextForm Field/my_textform_field.dart';

class EmergencyCard extends GetView {
  final AddEmergencyController controller;
  final AllEmergencies emergencies;
  final _formKey = new GlobalKey<FormState>();

  EmergencyCard(
      {super.key, required this.controller, required this.emergencies});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (emergencies.emergencyTypes == EmergencyTypes.Other) {
          Get.defaultDialog(
              onWillPop: () async {
                controller.descriptionController.clear();
                Get.back();
                return true;
              },
              title: 'Emergency ( ${emergencies.emergencyTypes!.name} )',
              titleStyle: GoogleFonts.quicksand(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: Colors.black),
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyTextFormField(
                      width: 328.w,
                      height: 78.w,
                      maxLength: 40,
                      padding: EdgeInsets.zero,
                      validator: ValidationHelper().emptyStringValidator,
                      maxLines: 4,
                      fillColor: Colors.white,
                      controller: controller.descriptionController,
                      hintText: 'Describe Problem',
                      labelText: 'Describe Problem',
                    ),
                    Obx(() {
                      return SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (!controller.isLoading.value) {
                                  controller.addEmergencyApi(
                                    residentid: controller.userdata.userId!,
                                    societyid: controller.resident.societyid!,
                                    subadminid: controller.resident.subadminid!,
                                    token: controller.userdata.bearerToken!,
                                    problem: emergencies.emergencyTypes!.name,
                                    description:
                                        controller.descriptionController.text,
                                  );
                                }
                              } else {
                                return null;
                              }
                            },
                            child: controller.isLoading.value
                                ? CircularProgressIndicator(
                                    strokeWidth: 1,
                                  )
                                : Text(
                                    'Submit',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  )),
                      );
                    }),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            Get.back();
                            controller.descriptionController.clear();
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          )),
                    )
                  ],
                ),
              ));
        } else {
          Get.defaultDialog(
              middleText:
                  "Would you like to submit your individual emergency report to the authorities?",
              middleTextStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
              title: 'Emergency ( ${emergencies.emergencyTypes!.name} )',
              titleStyle: GoogleFonts.quicksand(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: Colors.black),
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Would you like to submit your individual emergency report to the authorities?",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          return SizedBox(
                            width: 100.w,
                            child: TextButton(
                                onPressed: () {
                                  if (!controller.isLoading.value) {
                                    controller.addEmergencyApi(
                                      residentid: controller.userdata.userId!,
                                      societyid: controller.resident.societyid!,
                                      subadminid:
                                          controller.resident.subadminid!,
                                      token: controller.userdata.bearerToken!,
                                      problem: emergencies.emergencyTypes!.name,
                                      description:
                                          controller.descriptionController.text,
                                    );
                                  }
                                },
                                child: controller.isLoading.value
                                    ? CircularProgressIndicator(
                                        strokeWidth: 1,
                                      )
                                    : Text(
                                        'Yes',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                        ),
                                      )),
                          );
                        }),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0.1,
              blurRadius: 5,
              offset: Offset(2, 3),
            )
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              20.h.ph,
              Text(
                emergencies.title.toString(),
                style: GoogleFonts.montserrat(
                    fontSize: 16.sp, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              10.h.ph,
              Container(
                width: 54.w,
                height: 54.w,
                decoration: BoxDecoration(
                    color: Colors.orange[50], shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    emergencies.icon,
                    size: 38,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
