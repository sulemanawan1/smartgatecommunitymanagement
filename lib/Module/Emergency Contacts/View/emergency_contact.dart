import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Module/Emergency%20Contacts/Controller/emergency_contact_controller.dart';

import '../../../Routes/set_routes.dart';

class EmergencyContact extends GetView {
  const EmergencyContact({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmergencyContactController>(
        init: EmergencyContactController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              await Get.offNamed(homescreen, arguments: controller.userdata);
              return true;
            },
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                      child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          40.h.ph,
                          Container(
                            width: 150.w,
                            height: 150.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor.withOpacity(0.4)),
                            child: Center(
                                child: Icon(
                              size: 60.w,
                              Icons.security,
                              color: primaryColor,
                            )),
                          ),
                          20.h.ph,
                          Text(
                            'Who do you want to Contact?',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 20.sp),
                          ),
                          40.h.ph,
                          GestureDetector(
                            onTap: () async {
                              controller.uri = Uri.parse("tel://115");

                              try {
                                await launchUrl(controller.uri!);
                                controller.uri = null;
                              } catch (e) {
                                myToast(msg: e.toString(), isNegative: true);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Row(
                                children: [
                                  Icon(Icons.call),
                                  20.w.pw,
                                  Text(
                                    'Ambulance',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          ),
                          40.h.ph,
                          GestureDetector(
                            onTap: () async {
                              controller.uri = Uri.parse("tel://112");

                              try {
                                await launchUrl(controller.uri!);
                                controller.uri = null;
                              } catch (e) {
                                myToast(msg: e.toString(), isNegative: true);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Row(
                                children: [
                                  Icon(Icons.call),
                                  20.w.pw,
                                  Text(
                                    'Police',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offAllNamed(homescreen,
                                  arguments: controller.userdata);
                            },
                            child: Text(
                              'Dismiss',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500, fontSize: 14.sp),
                            ),
                          )
                        ]),
                  ))),
            ),
          );
        });
    ;
  }
}
