import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Widgets/My%20Back%20Button/my_back_button.dart';
import 'package:userapp/Widgets/My%20Button/my_button.dart';
import 'package:userapp/Widgets/My%20TextForm%20Field/my_textform_field.dart';

import '../../../../Routes/set_routes.dart';
import '../../Controller/Report to Admin Controller/report_to_admin_controller.dart';

class ReportToAdmin extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AddReportToAdminController>(
            init: AddReportToAdminController(),
            builder: (controller) {
              return WillPopScope(
                onWillPop: () async {
                  Get.offNamed(adminreports,
                      arguments: [controller.userdata, controller.resident]);
                  return true;
                },
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MyBackButton(
                          text: 'Complaint to Admin ',
                          onTap: () {
                            Get.offNamed(adminreports, arguments: [
                              controller.userdata,
                              controller.resident
                            ]);
                          },
                        ),

                        20.h.ph,
                        SvgPicture.asset(
                          "assets/report_to_admin_vector.svg",
                          width: 302.w,
                          height: 201.w,
                        ),
                        74.h.ph,
                        MyTextFormField(
                          controller: controller.reportTitleController,
                          validator: ValidationHelper().emptyStringValidator,
                          hintText: 'Complaint Title',
                          labelText: 'Complaint Title',
                        ),

                        MyTextFormField(
                          width: null,
                          maxLines: 5,
                          controller: controller.reportDescriptionController,
                          validator: ValidationHelper().emptyStringValidator,
                          hintText: 'Complaint Description',
                          labelText: 'Complaint Description',
                        ),

                        76.h.ph,

                        MyButton(
                          loading: controller.isLoading,
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              if (!controller.isLoading) {
                                controller.reportToAdminApi(
                                    token: controller.userdata.bearerToken!,
                                    subadminid:
                                        controller.resident!.subadminid!,
                                    userid: controller.userdata.userId!,
                                    title:
                                        controller.reportTitleController.text,
                                    description: controller
                                        .reportDescriptionController.text);
                              }
                            }
                          },
                          name: 'Submit',
                        ),
                        20.h.ph,

                        // sixth Element
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
