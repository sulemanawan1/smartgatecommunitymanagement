import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../Constants/constants.dart';
import '../../../../Helpers/Validation Helper/validation_helper.dart';
import '../../../../Widgets/My Button/my_button.dart';
import '../../../../Widgets/My TextForm Field/my_textform_field.dart';
import '../Controller/register_controller.dart';

class Register extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());

  final _key = GlobalKey<FormState>();

  Register({super.key});

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
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Smart Gate",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Add your Phone number. We'll send you a \n verification code",
                  style: GoogleFonts.montserrat(
                    color: HexColor('#B6B6B6'),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                MyTextFormField(
                  validator: ValidationHelper().validatePhoneNumber,
                  controller: registerController.phoneNumberController,
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
                              registerController.countryFlag.value =
                                  country.flagEmoji;
                              registerController.countryCode.value =
                                  country.phoneCode;
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 16, 8, 0),
                        child: Obx(() {
                          return Text(
                            "${registerController.countryFlag} + ${registerController.countryCode}",
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
                20.ph,
                Obx(() {
                  return MyButton(
                    name: 'Next',
                    loading: registerController.isLoading.value,
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        registerController.phoneNumber.value =
                            "+${registerController.countryCode}${registerController.phoneNumberController.text}";

                        if (!registerController.isLoading.value) {
                          registerController.verifyUserPhoneNumber();
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
    );
  }
}
