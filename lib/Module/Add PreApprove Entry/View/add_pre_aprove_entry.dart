import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Module/Add%20PreApprove%20Entry/Model/GateKeeper.dart';
import 'package:userapp/Widgets/My%20Back%20Button/my_back_button.dart';
import 'package:userapp/Widgets/My%20Button/my_button.dart';
import 'package:userapp/Widgets/My%20TextForm%20Field/my_textform_field.dart';

import '../../../Routes/set_routes.dart';
import '../Controller/add_pre_approve_entry_controller.dart';

class AddPreApproveEntry extends GetView {
  @override
  Widget build(BuildContext context) {
    print('build');
    return SafeArea(
      child: GetBuilder<AddPreApproveEntryController>(
        init: AddPreApproveEntryController(),
        builder: (controller) {
          return Scaffold(
            body: GetBuilder<AddPreApproveEntryController>(
                init: AddPreApproveEntryController(),
                builder: (controller) {
                  return WillPopScope(
                    onWillPop: () async {
                      Get.offNamed(preapproveentryscreen, arguments: [
                        controller.userdata,
                        controller.resident
                      ]);
                      return true;
                    },
                    child: Column(
                      children: [
                        MyBackButton(
                          text: 'Add PreApprove Entry',
                          onTap: () {
                            Get.offNamed(preapproveentryscreen, arguments: [
                              controller.userdata,
                              controller.resident
                            ]);
                          },
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  30.h.ph,
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(44.w, 0, 45.w, 0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Visitor Type",
                                        style: GoogleFonts.ubuntu(
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                            color: HexColor('#4D4D4D')),
                                      ),
                                    ),
                                  ),
                                  12.h.ph,
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(24.w, 0, 45.w, 0),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 72,
                                          left: 22,
                                          child: Container(
                                            color: HexColor('#E4E4E4'),
                                            width: 275.w,
                                            height: 2.w,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 300.w,
                                          child: TabBar(
                                              onTap: (visitorType) {
                                                print(visitorType);

                                                if (visitorType == 0) {
                                                  controller.visitorTypeValue =
                                                      'Guest';
                                                } else if (visitorType == 1) {
                                                  controller.visitorTypeValue =
                                                      'Delivery';
                                                } else if (visitorType == 2) {
                                                  controller.visitorTypeValue =
                                                      'Cab';
                                                } else if (visitorType == 3) {
                                                  controller.visitorTypeValue =
                                                      'Visiting Help';
                                                }
                                              },
                                              labelPadding: EdgeInsets.zero,
                                              indicatorSize:
                                                  TabBarIndicatorSize.label,
                                              automaticIndicatorColorAdjustment:
                                                  true,
                                              controller:
                                                  controller.tabController,
                                              indicatorWeight: 1.4,
                                              indicatorColor: primaryColor,
                                              labelColor: HexColor('#717171'),
                                              labelStyle: GoogleFonts.ubuntu(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w300),
                                              tabs: controller.tabs),
                                        ),
                                      ],
                                    ),
                                  ),
                                  31.h.ph,
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(44.w, 0, 45.w, 0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Choose Gate",
                                        style: GoogleFonts.ubuntu(
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                            color: HexColor('#717171')),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(44.w, 0, 45.w, 0),
                                    child: DropdownSearch<GateKeeper>(
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: primaryColor)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: HexColor('#E4E4E4'))),
                                        suffixIconColor: primaryColor,
                                      )),
                                      validator: (value) => value == null
                                          ? 'Select Gatekeeper'
                                          : null,
                                      asyncItems: (String filter) async {
                                        return controller.getGateKeepersApi(
                                            subadminid:
                                                controller.resident.subadminid!,
                                            token: controller
                                                .userdata.bearerToken!);
                                      },
                                      onChanged: (GateKeeper? data) {
                                        controller.SelectedGatekeeper(data!);
                                      },
                                      selectedItem: controller.gateKeepers,
                                      itemAsString: (GateKeeper gatekeeper) {
                                        return gatekeeper.gateNo.toString();
                                      },
                                    ),
                                  ),
                                  MyTextFormField(
                                    controller: controller.mobileNoController,
                                    validator:
                                        ValidationHelper().emptyStringValidator,
                                    labelText: 'Mobile Number *',
                                    hintText: 'Mobile Number',
                                    textInputType: TextInputType.number,
                                    suffixIcon: GestureDetector(
                                        onTap: () async {
                                          final FlutterContactPicker
                                              _contactPicker =
                                              new FlutterContactPicker();

                                          Contact? contact =
                                              await _contactPicker
                                                  .selectContact();
                                          controller.mobileNoController.text =
                                              contact!.phoneNumbers!.first
                                                  .toString();
                                          controller.nameController.text =
                                              contact!.fullName.toString();
                                        },
                                        child: Icon(Icons.contact_page_sharp)),
                                  ),
                                  MyTextFormField(
                                    controller: controller.nameController,
                                    validator:
                                        ValidationHelper().emptyStringValidator,
                                    labelText: 'Name *',
                                    hintText: 'Name',
                                  ),
                                  MyTextFormField(
                                    controller: controller.arrivaldate,
                                    validator:
                                        ValidationHelper().emptyStringValidator,
                                    labelText: 'Expected Arrival Date *',
                                    hintText: 'Expected Arrival Date',
                                    readOnly: true,
                                    onTap: () {
                                      controller.StartDate(context);
                                    },
                                  ),
                                  MyTextFormField(
                                    controller: controller.arrivaltime,
                                    validator:
                                        ValidationHelper().emptyStringValidator,
                                    labelText: 'Expected Arrival Time *',
                                    hintText: 'Expected Arrival Time',
                                    readOnly: true,
                                    onTap: () {
                                      controller.GuestTime(context);
                                    },
                                  ),
                                  if (controller.checkBoxValue) ...[
                                    MyTextFormField(
                                      controller:
                                          controller.descriptionController,
                                      // validator: emptyStringValidator,
                                      width: null, maxLines: 3,
                                      labelText: 'Description',
                                      hintText: 'Description',
                                    ),
                                    MyTextFormField(
                                      controller: controller.cnicController,
                                      labelText: 'Cnic',
                                      hintText: 'Cnic',
                                      textInputType: TextInputType.number,
                                    ),
                                    MyTextFormField(
                                      controller:
                                          controller.vehicleNoController,
                                      labelText: 'Vehicle Number',
                                      hintText: 'Vehicle Number',
                                    ),
                                  ],
                                  20.h.ph,
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(44.w, 0, 45.w, 0),
                                    child: ListTile(
                                      title: Text('Additional Information',
                                          style: GoogleFonts.ubuntu(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.sp,
                                              letterSpacing: 0.05)),
                                      trailing: Checkbox(
                                        value: controller.checkBoxValue,
                                        onChanged: (newValue) {
                                          controller.setCheckBox(newValue);
                                        },
                                      ),
                                    ),
                                  ),
                                  20.h.ph,
                                  Center(
                                    child: MyButton(
                                      loading: controller.isLoading,
                                      name: 'Save',
                                      onPressed: () {
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          if (controller.visitorTypeValue ==
                                              null) {
                                            Get.snackbar(
                                                'Error', 'Select VisitorType');
                                          } else {
                                            if (!controller.isLoading) {
                                              controller.addPreApproveEntryApi(
                                                  token: controller
                                                      .userdata.bearerToken!,
                                                  cnic: controller
                                                      .cnicController.text,
                                                  name: controller
                                                      .nameController.text,
                                                  mobileno: controller
                                                      .mobileNoController.text,
                                                  userid: controller
                                                      .userdata.userId!,
                                                  arrivaldate: controller
                                                      .arrivaldate.text,
                                                  arrivaltime: controller
                                                      .arrivalTime
                                                      .toString(),
                                                  description: controller
                                                      .descriptionController
                                                      .text,
                                                  vechileno: controller
                                                      .vehicleNoController.text,
                                                  visitortype: controller
                                                      .visitorTypeValue!,
                                                  gatekeeperid: controller
                                                      .gateKeepers!
                                                      .gateKeeperId!);
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                  20.h.ph
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
