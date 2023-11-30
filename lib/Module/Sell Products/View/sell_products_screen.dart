import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Routes/set_routes.dart';

import '../../../Widgets/My Back Button/my_back_button.dart';
import '../../../Widgets/My Button/my_button.dart';
import '../Controller/sell_products_controller.dart';

class SellProductsScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SellProductsController>(
        init: SellProductsController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offNamed(marketPlaceScreen,
                  arguments: [controller.userdata, controller.resident]);
              return true;
            },
            child: Scaffold(
                backgroundColor: HexColor('#FFFFFF'),
                body: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      MyBackButton(
                        text: 'Product Detail',
                        onTap: () {
                          Get.offNamed(marketPlaceScreen, arguments: [
                            controller.userdata,
                            controller.resident
                          ]);
                        },
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              40.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  height: 100.0,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        'Choose Photo',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          ElevatedButton.icon(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary:
                                                                        primaryColor),
                                                            icon: Icon(
                                                              Icons.camera,
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .getFromCamera(
                                                                      ImageSource
                                                                          .camera);
                                                            },
                                                            label:
                                                                Text('Camera'),
                                                          ),
                                                          ElevatedButton.icon(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary:
                                                                        primaryColor),
                                                            icon: Icon(
                                                                Icons.image),
                                                            onPressed: () {
                                                              controller
                                                                  .getFromGallery(
                                                                      ImageSource
                                                                          .gallery);
                                                            },
                                                            label:
                                                                Text('Gallery'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Container(
                                            child: Column(
                                              children: [
                                                17.h.ph,
                                                Image.asset(
                                                  "assets/add-photo 1.png",
                                                  width: 35.063777923583984.w,
                                                  height: 33.w,
                                                ),
                                                8.h.ph,
                                                Text("Add Images",
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: HexColor(
                                                                '#0D0B0C')))
                                              ],
                                            ),
                                            width: 319.w,
                                            height: 91.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: HexColor('#E1E3E6')),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        6.r))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              20.h.ph,
                              controller.imageFile == null
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 28.w),
                                      child: Container(
                                          child: Image.file(
                                            File(controller.imageFile!.path),
                                          ),
                                          width: 319.w,
                                          height: 319.w,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: HexColor('#E1E3E6')),
                                              borderRadius:
                                                  BorderRadius.circular(6.r))),
                                    ),
                              20.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: MarketplaceTextFormField(
                                    hintText: 'Product Name',
                                    validator:
                                        ValidationHelper().emptyStringValidator,
                                    controller:
                                        controller.productNameController),
                              ),
                              20.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: MarketplaceTextFormField(
                                    hintText: 'Description',
                                    validator:
                                        ValidationHelper().emptyStringValidator,
                                    controller:
                                        controller.descriptionController),
                              ),
                              20.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: MarketplaceTextFormField(
                                    hintText: 'Price',
                                    keyboardType: TextInputType.number,
                                    validator:
                                        ValidationHelper().emptyStringValidator,
                                    controller:
                                        controller.productPriceController),
                              ),
                              20.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: MarketplaceTextFormField(
                                    keyboardType: TextInputType.phone,
                                    hintText: 'Contact',
                                    validator:
                                        ValidationHelper().validateMobileNumber,
                                    controller: controller.contactController),
                              ),
                              20.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: Text(
                                  "Condition",
                                  style: GoogleFonts.quicksand(
                                    color: HexColor('#0D0B0C'),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: DropdownButton(
                                  isExpanded: true,
                                  style: GoogleFonts.ubuntu(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14.sp,
                                      color: HexColor('#4D4D4D')),
                                  value: controller.conditionTypeDropDownValue,
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: primaryColor,
                                    size: 24.w,
                                  ),
                                  items: controller.conditionTypeList
                                      .map((String? items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items!),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    controller.setConditionTypeDropDownValue(
                                        newValue);
                                  },
                                ),
                              ),
                              20.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: Text(
                                  "Category",
                                  style: GoogleFonts.quicksand(
                                    color: HexColor('#0D0B0C'),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: DropdownButton(
                                  isExpanded: true,
                                  style: GoogleFonts.ubuntu(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14.sp,
                                      color: HexColor('#4D4D4D')),
                                  value: controller.categoryTypeDropDownValue,
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: primaryColor,
                                    size: 24.w,
                                  ),
                                  items: controller.categoryTypeList
                                      .map((String? items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items!),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    controller
                                        .setCategoryTypeDropDownValue(newValue);
                                  },
                                ),
                              ),
                              43.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: MyButton(
                                    loading: controller.isLoading,
                                    width: 319.w,
                                    height: 45.w,
                                    name: 'Save',
                                    onPressed: () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        if (controller.imageFile == null) {
                                          myToast(
                                              msg: 'Please Select Image',
                                              isNegative: true,
                                              gravity: ToastGravity.CENTER);
                                        } else {
                                          if (!controller.isLoading) {
                                            controller.addProductDetailApi(
                                                societyid: controller
                                                    .resident.societyid!,
                                                subadminid: controller
                                                    .resident.subadminid!,
                                                token: controller
                                                    .userdata.bearerToken!,
                                                residentid: controller
                                                    .resident.residentid!,
                                                productname: controller
                                                    .productNameController.text,
                                                description: controller
                                                    .descriptionController.text,
                                                productprice: controller
                                                    .productPriceController
                                                    .text,
                                                file: controller.imageFile!,
                                                condition: controller
                                                        .conditionTypeDropDownValue ??
                                                    "N/A",
                                                category: controller
                                                        .categoryTypeDropDownValue ??
                                                    "N/A",
                                                contact: controller
                                                    .contactController.text);
                                          }
                                        }
                                      }
                                    }),
                              ),
                              34.h.ph
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}

class MarketplaceTextFormField extends StatelessWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  MarketplaceTextFormField(
      {super.key,
      required this.hintText,
      this.keyboardType,
      this.validator,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(width: 0.5, color: HexColor('#E1E3E6'))),
          hintText: hintText ?? "",
          hintStyle: GoogleFonts.quicksand(
            color: HexColor('#0D0B0C'),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          )),
    );
  }
}
