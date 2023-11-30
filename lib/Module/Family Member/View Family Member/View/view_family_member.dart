import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Module/Family%20Member/View%20Family%20Member/Controller/view_family_member_controller.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/Empty%20List/empty_list.dart';
import 'package:userapp/Widgets/Loader/loader.dart';

import '../../../../Constants/api_routes.dart';
import '../../../../Helpers/Date Helper/date_helper.dart';
import '../../../../Widgets/Dialog Box Elipse Heading/dialog_box_elipse_heading.dart';
import '../../../../Widgets/My Back Button/my_back_button.dart';
import '../../../../Widgets/My Button/my_button.dart';
import '../../../../Widgets/My Password TextForm Field/my_password_textform_field.dart';
import '../../../Pre Approve Entry/View/pre_approve_entry_screen.dart';
import '../Controller/reset_password_controller.dart';

class ViewFamilyMember extends GetView {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewFamilyMemberController>(
        init: ViewFamilyMemberController(),
        builder: (controller) => SafeArea(
              child: WillPopScope(
                onWillPop: () async {
                  await Get.offNamed(homescreen,
                      arguments: controller.userdata);

                  return false;
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      MyBackButton(
                        text: 'Family Members',
                        onTap: () {
                          Get.offNamed(homescreen,
                              arguments: controller.userdata);
                        },
                      ),
                      34.h.ph,
                      Expanded(
                        child: FutureBuilder(
                            future: controller.viewResidentsApi(
                                controller.resident.subadminid!,
                                controller.userdata.userId!,
                                controller.userdata.bearerToken!),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.data != null &&
                                    snapshot.data.data!.length != 0) {
                                  controller.familyMemberCount =
                                      snapshot.data.data!.length;

                                  controller.checkFamilyMemberCount(
                                      count: controller.familyMemberCount);

                                  return Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 14.h),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors
                                                          .white, // Your desired background color
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            blurRadius: 15),
                                                      ]),
                                                  child: ListTile(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                                content:
                                                                    SizedBox(
                                                                  height: 400.w,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              Api.imageBaseUrl + snapshot.data!.data[index].image.toString(),
                                                                          width:
                                                                              100.w,
                                                                          height:
                                                                              100.w,
                                                                          placeholder: (context, url) =>
                                                                              Center(
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              color: primaryColor,
                                                                            ),
                                                                          ),
                                                                          errorWidget: (context, url, error) =>
                                                                              Icon(Icons.error),
                                                                        ),
                                                                      ),
                                                                      23.33
                                                                          .h
                                                                          .ph,
                                                                      Center(
                                                                        child: Text(
                                                                            "${snapshot.data!.data[index].firstname.toString()} ${snapshot.data!.data[index].lastname.toString()}",
                                                                            style:
                                                                                GoogleFonts.montserrat(
                                                                              color: HexColor("#4D4D4D"),
                                                                              fontSize: 18.sp,
                                                                              fontWeight: FontWeight.w700,
                                                                            )),
                                                                      ),
                                                                      23.33
                                                                          .h
                                                                          .ph,
                                                                      DialogBoxElipseHeading(
                                                                          text:
                                                                              'MobileNo'),
                                                                      DialogBoxText(
                                                                        text: snapshot.data!.data[index].mobileno.toString() ??
                                                                            "",
                                                                      ),
                                                                      23.33
                                                                          .h
                                                                          .ph,
                                                                      DialogBoxElipseHeading(
                                                                          text:
                                                                              'Role'),
                                                                      DialogBoxText(
                                                                        text: snapshot.data!.data[index].rolename.toString() ??
                                                                            "",
                                                                      ),
                                                                      23.33
                                                                          .h
                                                                          .ph,
                                                                      DialogBoxElipseHeading(
                                                                          text:
                                                                              'Join at'),
                                                                      DialogBoxText(
                                                                        text: DateHelper.laravelDateToFormattedDate(snapshot.data!.data[index].createdAt.toString()) ??
                                                                            "",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                    },
                                                    style: ListTileStyle.drawer,
                                                    trailing: PopupMenuButton(
                                                        onSelected: (val) {
                                                      if (val == 'reset') {
                                                        Get.defaultDialog(
                                                            title:
                                                                'Reset Password',
                                                            content: GetBuilder<
                                                                    ResetPasswordController>(
                                                                init:
                                                                    ResetPasswordController(),
                                                                builder:
                                                                    (resetPasswordController) {
                                                                  return Form(
                                                                    key:
                                                                        _formKey,
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          SvgPicture
                                                                              .asset(
                                                                            'assets/reset_password_icon.svg',
                                                                            width:
                                                                                100.w,
                                                                          ),
                                                                          20.h.ph,
                                                                          MyPasswordTextFormField(
                                                                              validator: ValidationHelper().emptyStringValidator,
                                                                              labelText: 'New Password',
                                                                              hintText: 'New Password',
                                                                              togglePasswordView: resetPasswordController.togglePasswordView,
                                                                              controller: resetPasswordController.passwordController,
                                                                              obscureText: resetPasswordController.isHidden),
                                                                          20.h.ph,
                                                                          MyButton(
                                                                            loading:
                                                                                resetPasswordController.isLoading,
                                                                            name:
                                                                                'Reset Password',
                                                                            onPressed:
                                                                                () {
                                                                              if (_formKey.currentState!.validate()) {
                                                                                if (!resetPasswordController.isLoading) {
                                                                                  resetPasswordController.resetPasswordApi(familymemberid: snapshot.data.data[index].familymemberid, bearerToken: controller.userdata.bearerToken!, password: resetPasswordController.passwordController.text);
                                                                                }
                                                                              }
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                }));
                                                      }
                                                    }, itemBuilder: (context) {
                                                      return [
                                                        PopupMenuItem(
                                                            value: 'reset',
                                                            child: Text(
                                                                'Reset Password')),
                                                      ];
                                                    }),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r)),
                                                    subtitle: Text(
                                                        "${snapshot.data!.data[index].mobileno.toString()}"),
                                                    leading: Container(
                                                      padding:
                                                          EdgeInsets.all(3),
                                                      width: 70.w,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  primaryColor,
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r)),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            Api.imageBaseUrl +
                                                                snapshot
                                                                    .data!
                                                                    .data[index]
                                                                    .image
                                                                    .toString(),
                                                        placeholder:
                                                            (context, url) =>
                                                                Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: primaryColor,
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                    ),
                                                    title: Text(
                                                        "${snapshot.data!.data[index].firstname.toString()} ${snapshot.data!.data[index].lastname.toString()}"),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount:
                                                snapshot.data.data.length),
                                      ),
                                      MyButton(
                                        width: 340.w,
                                        name: 'Add',
                                        onPressed: () {
                                          if (controller
                                              .familyMemberCountExceed) {
                                            myToast(
                                                msg:
                                                    "You have successfully added three family members previously, and the system restricts adding more than three at this time.");
                                          } else {
                                            Get.offNamed(addfamilymember,
                                                arguments: [
                                                  controller.userdata,
                                                  controller.resident
                                                ]);
                                          }
                                        },
                                      ),
                                      20.h.ph
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      EmptyList(
                                        name: 'No Family Member',
                                      ),
                                      Spacer(),
                                      MyButton(
                                        width: 340.w,
                                        name: 'Add',
                                        onPressed: () {
                                          if (controller
                                              .familyMemberCountExceed) {
                                            myToast(
                                                msg:
                                                    "You have successfully added three family members previously, and the system restricts adding more than three at this time.");
                                          } else {
                                            Get.offNamed(addfamilymember,
                                                arguments: [
                                                  controller.userdata,
                                                  controller.resident
                                                ]);
                                          }
                                        },
                                      ),
                                      10.h.ph
                                    ],
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return Icon(Icons.error_outline);
                              } else {
                                return Loader();
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ));
    ;
  }
}
