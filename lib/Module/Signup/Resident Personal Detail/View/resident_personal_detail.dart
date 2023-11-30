import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Routes/set_routes.dart';

import '../../../../Constants/constants.dart';
import '../../../../Helpers/Validation Helper/validation_helper.dart';
import '../../../../Widgets/My Button/my_button.dart';
import '../../../../Widgets/My Password TextForm Field/my_password_textform_field.dart';
import '../../../../Widgets/My TextForm Field/my_textform_field.dart';
import '../Controller/resident_personal_detail_controller.dart';

class ResidentPersonalDetail extends GetView {
  // final ResidentPersonalDetailController controller =
  //     Get.put(ResidentPersonalDetailController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(loginscreen);
        return true;
      },
      child: GetBuilder<ResidentPersonalDetailController>(
          init: ResidentPersonalDetailController(),
          builder: (controller) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        100.h.ph,
                        Stack(
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundColor: Colors.white,
                                backgroundImage: controller.imageFile == null
                                    ? AssetImage('assets/user.png')
                                        as ImageProvider
                                    : FileImage(
                                        File(controller.imageFile.path
                                            .toString()),
                                      ),
                              ),
                            ),
                            Positioned(
                              left: 70,
                              top: 70,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: 100.0.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 20.h),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                'Choose Profile Photo',
                                                style:
                                                    TextStyle(fontSize: 20.sp),
                                              ),
                                              20.h.ph,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  ElevatedButton.icon(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                primaryColor),
                                                    icon: Icon(
                                                      Icons.camera,
                                                    ),
                                                    onPressed: () {
                                                      controller.getFromCamera(
                                                          ImageSource.camera);
                                                    },
                                                    label: Text('Camera'),
                                                  ),
                                                  ElevatedButton.icon(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                primaryColor),
                                                    icon: Icon(Icons.image),
                                                    onPressed: () {
                                                      controller.getFromGallery(
                                                          ImageSource.gallery);
                                                    },
                                                    label: Text('Gallery'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  color: primaryColor,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                        16.h.ph,
                        MyTextFormField(
                          controller: controller.firstnameController,
                          validator: ValidationHelper().emptyStringValidator,
                          hintText: 'First Name',
                          labelText: 'Enter First Name',
                        ),
                        MyTextFormField(
                          controller: controller.lastnameController,
                          validator: ValidationHelper().emptyStringValidator,
                          hintText: 'Last Name',
                          labelText: 'Enter Last Name',
                        ),
                        // MyTextFormField(
                        //   controller: controller.cnicController,
                        //   validator: emptyStringValidator,
                        //   hintText: 'Cnic',
                        //   labelText: 'Enter Cnic',
                        //   textInputType: TextInputType.number,
                        // ),
                        MyPasswordTextFormField(
                          controller: controller.passwordController,
                          obscureText: controller.isHidden,
                          togglePasswordView: controller.togglePasswordView,
                          validator: ValidationHelper().emptyStringValidator,
                          hintText: 'Password',
                          labelText: 'Password',
                        ),
                        17.h.ph,
                        MyButton(
                          width: 173.w,
                          height: 43.w,
                          border: 16.0.r,
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              // if (controller.imageFile?.path == null) {

                              Get.toNamed(register, arguments: 'SignUp');
                            }
                          },
                          textColor: Colors.white,
                          color: primaryColor,
                          name: 'Next',
                          outlinedBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        25.h.ph,
                        Wrap(
                          children: [
                            Text(
                              "Have an Account ?",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.grey,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            10.w.pw,
                            GestureDetector(
                                onTap: () {
                                  Get.offAllNamed(loginscreen);
                                },
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.ubuntu(
                                      color: primaryColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                )),
                          ],
                        ),
                        25.h.ph,
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
