import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Controller/resident_address_controller.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Model/block.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Model/measurement.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Model/phase.dart';
import 'package:userapp/Module/Signup/Resident%20Address%20Detail/Model/street.dart';

import '../../../../Constants/constants.dart';
import '../../../../Helpers/Validation Helper/validation_helper.dart';
import '../../../../Routes/set_routes.dart';
import '../../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../../../../Widgets/My Button/my_button.dart';
import '../../../../Widgets/My TextForm Field/my_textform_field.dart';
import '../Model/apartment.dart';
import '../Model/building.dart';
import '../Model/floor.dart';
import '../Model/house.dart';
import '../Model/society.dart';

class ResidentAddressDetail extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<ResidentAddressDetailController>(
            init: ResidentAddressDetailController(),
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                                onPressed: () {
                                  MySharedPreferences.deleteUserData();
                                  Get.offAllNamed(loginscreen);
                                },
                                icon: Icon(Icons.logout)),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.022,
                                  right: MediaQuery.of(context).size.width *
                                      0.022),
                              child: Text(
                                'Address Details',
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: CSCPicker(
                          defaultCountry: CscCountry.Pakistan,
                          showStates: true,
                          showCities: true,
                          flagState: CountryFlag.ENABLE,
                          dropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1)),
                          disabledDropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.grey.shade300,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1)),
                          stateSearchPlaceholder: "State",
                          citySearchPlaceholder: "City",
                          stateDropdownLabel: "*State",
                          cityDropdownLabel: "*City",
                          selectedItemStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          dropdownHeadingStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                          dropdownItemStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          dropdownDialogRadius: 10.0,
                          searchBarRadius: 10.0,
                          onCountryChanged: (val) {
                            controller.country = val.toString();
                          },
                          onStateChanged: (value) {
                            controller.state = value.toString();
                          },
                          onCityChanged: (value) {
                            controller.city = value.toString();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ResidentAddressDetailHeading(text: 'Select Type'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                style: GoogleFonts.ubuntu(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: HexColor('#4D4D4D')),
                                value: controller.societyorbuildingval,
                                icon: Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: primaryColor,
                                ),
                                validator: (value) => value == null
                                    ? 'Please Select Society'
                                    : null,
                                items: controller.societyorbuildinglist
                                    .map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items.capitalizeFirst.toString(),
                                      style: GoogleFonts.ubuntu(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: HexColor('#4D4D4D')),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.SocietyOrBuilding(newValue);
                                },
                              ),
                            ),
                            (controller.societyorbuildingval == 'society')
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ResidentAddressDetailHeading(
                                          text: 'Select Society'),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownSearch<Society>(
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                          asyncItems: (String filter) async {
                                            print(filter);
                                            return controller
                                                .viewAllSocietiesApi(
                                                    controller
                                                        .societyorbuildingval,
                                                    controller.token);
                                          },
                                          onChanged: (Society? data) {
                                            controller.SelectedSociety(data!);
                                          },
                                          selectedItem: controller.societies,
                                          itemAsString: (Society society) {
                                            return society.name.toString();
                                          },
                                        ),
                                      ),

                                      /// For Type 1 => Society,Street, House
                                      if (controller.societies?.structureType ==
                                          1) ...[
                                        ResidentAddressDetailHeading(
                                            text: 'Select Property Type'),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButtonFormField(
                                            isExpanded: true,
                                            style: GoogleFonts.ubuntu(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp,
                                                color: HexColor('#4D4D4D')),
                                            value: controller.propertytype,
                                            icon: Icon(
                                              Icons.arrow_drop_down_sharp,
                                              color: primaryColor,
                                            ),
                                            validator: (value) => value == null
                                                ? 'Please Select Property Type'
                                                : null,
                                            items: controller.propertytypelist
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items.capitalizeFirst
                                                      .toString(),
                                                  style: GoogleFonts.ubuntu(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp,
                                                      color:
                                                          HexColor('#4D4D4D')),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              controller.SelectedProperty(
                                                  newValue);
                                            },
                                          ),
                                        ),

                                        /// Check Property Type House or Apartment

                                        if (controller.propertytype ==
                                            'house') ...[
                                          ResidentAddressDetailHeading(
                                              text: 'Select Street'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Street>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllStreetsApi(
                                                        dynamicId: controller
                                                            .societies?.id,
                                                        type: 'society');
                                              },
                                              onChanged: (Street? data) {
                                                controller.SelectedStreet(data);
                                              },
                                              selectedItem: controller.streets,
                                              itemAsString: (Street p) {
                                                return p.address.toString();
                                              },
                                            ),
                                          ),

                                          ResidentAddressDetailHeading(
                                              text: 'Select House'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<House>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllHousesApi(
                                                        dynamicId: controller
                                                            .streets?.id,
                                                        type: 'street');
                                              },
                                              onChanged: (House? house) {
                                                controller.SelectedHouse(house);

                                                controller
                                                        .houseaddressdetailController
                                                        .text =
                                                    "${controller.societies!.name}${' '}${controller.streets!.address}${' '}${house!.address.toString()}";

                                                controller
                                                    .isPropertyHouseApartment();
                                              },
                                              selectedItem: controller.houses,
                                              itemAsString: (House p) {
                                                return p.address.toString();
                                              },
                                            ),
                                          ),

                                          /// House Measurement

                                          (controller.streets?.subadminid ==
                                                  null)
                                              ? Container()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ResidentAddressDetailHeading(
                                                        text: 'Select Area *'),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: DropdownSearch<
                                                          Measurement>(
                                                        validator: (value) =>
                                                            value == null
                                                                ? 'field required'
                                                                : null,
                                                        asyncItems: (String
                                                            filter) async {
                                                          print(filter);
                                                          return controller.housesApartmentsModelApi(
                                                              subadminid:
                                                                  controller
                                                                      .streets!
                                                                      .subadminid!,
                                                              token: controller
                                                                  .user!
                                                                  .bearerToken!,
                                                              type: 'house');
                                                        },
                                                        onChanged: (Measurement?
                                                            data) {
                                                          controller
                                                              .SelectedHousesApartments(
                                                                  data);
                                                        },
                                                        selectedItem: controller
                                                            .housesApartmentsModel,
                                                        itemAsString:
                                                            (Measurement p) {
                                                          return p.area
                                                                  .toString() +
                                                              ' ' +
                                                              p.unit.toString();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )
                                        ] else ...[
                                          ResidentAddressDetailHeading(
                                              text: 'Select Building'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Building>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllBuildingApi(
                                                  bearerToken: controller
                                                      .user!.bearerToken!,
                                                  subAdminId: controller
                                                      .societies!.subAdminId,
                                                );
                                              },
                                              onChanged: (Building? data) {
                                                controller.SelectedBuilding(
                                                    data);
                                              },
                                              selectedItem: controller.building,
                                              itemAsString: (Building p) {
                                                return p.societybuildingname
                                                    .toString();
                                              },
                                            ),
                                          ),
                                          ResidentAddressDetailHeading(
                                              text: 'Select Floor'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Floor>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllFloorApi(
                                                        bearerToken: controller
                                                            .user!.bearerToken!,
                                                        buildingid: controller
                                                            .building?.id);
                                              },
                                              onChanged: (Floor? data) {
                                                controller.SelectedFloor(data);
                                              },
                                              selectedItem: controller.floor,
                                              itemAsString: (Floor p) {
                                                return p.name.toString();
                                              },
                                            ),
                                          ),
                                          ResidentAddressDetailHeading(
                                              text: 'Select Apartment'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Apartment>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllApartmentApi(
                                                        bearerToken: controller
                                                            .user!.bearerToken!,
                                                        floorid: controller
                                                            .floor?.id);
                                              },
                                              onChanged:
                                                  (Apartment? apartment) {
                                                controller.SelectedApartment(
                                                    apartment);
                                                controller
                                                        .houseaddressdetailController
                                                        .text =
                                                    "${controller.societies!.name}${' '}${controller.building!.societybuildingname.toString()}${' '} ${controller.floor!.name.toString()}${' '}${apartment!.name.toString()}";
                                              },
                                              selectedItem:
                                                  controller.apartment,
                                              itemAsString: (Apartment p) {
                                                return p.name.toString();
                                              },
                                            ),
                                          ),
                                          ResidentAddressDetailHeading(
                                              text: 'Select Area *'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Measurement>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .housesApartmentsModelApi(
                                                        subadminid: controller
                                                            .societies!
                                                            .subAdminId!,
                                                        token: controller
                                                            .user!.bearerToken!,
                                                        type: 'apartment');
                                              },
                                              onChanged: (Measurement? data) {
                                                controller
                                                    .SelectedHousesApartments(
                                                        data);
                                              },
                                              selectedItem: controller
                                                  .housesApartmentsModel,
                                              itemAsString: (Measurement p) {
                                                return p.area.toString() +
                                                    ' ' +
                                                    p.unit.toString();
                                              },
                                            ),
                                          )
                                        ]
                                      ]

                                      /// For Type 2=> Society,Block,Street, House
                                      else if (controller
                                              .societies?.structureType ==
                                          2) ...[
                                        ResidentAddressDetailHeading(
                                            text: 'Select Property Type'),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButtonFormField(
                                            isExpanded: true,
                                            style: GoogleFonts.ubuntu(
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14,
                                                color: HexColor('#4D4D4D')),
                                            value: controller.propertytype,
                                            icon: Icon(
                                              Icons.arrow_drop_down_sharp,
                                              color: primaryColor,
                                            ),
                                            validator: (value) => value == null
                                                ? 'Please Select Property Type'
                                                : null,
                                            items: controller.propertytypelist
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items.capitalizeFirst
                                                      .toString(),
                                                  style: GoogleFonts.ubuntu(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp,
                                                      color:
                                                          HexColor('#4D4D4D')),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              controller.SelectedProperty(
                                                  newValue);
                                            },
                                          ),
                                        ),

                                        /// Check Property Type House or Apartment

                                        if (controller.propertytype ==
                                            'house') ...[
                                          ///Block

                                          ResidentAddressDetailHeading(
                                              text: 'Select Block'),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Block>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllBlocksApi(
                                                        dynamicId: controller
                                                            .societies?.id,
                                                        type: 'society');
                                              },
                                              onChanged: (Block? data) {
                                                controller.SelectedBlock(data);
                                              },
                                              selectedItem: controller.blocks,
                                              itemAsString: (Block p) {
                                                return p.address.toString();
                                              },
                                            ),
                                          ),

                                          ///Street
                                          ResidentAddressDetailHeading(
                                              text: 'Select Street'),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Street>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllStreetsApi(
                                                        dynamicId: controller
                                                            .blocks?.id,
                                                        type: 'blocks');
                                              },
                                              onChanged: (Street? data) {
                                                controller.SelectedStreet(data);
                                              },
                                              selectedItem: controller.streets,
                                              itemAsString: (Street p) {
                                                return p.address.toString();
                                              },
                                            ),
                                          ),

                                          ///House

                                          ResidentAddressDetailHeading(
                                              text: 'Select House'),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<House>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllHousesApi(
                                                        dynamicId: controller
                                                            .streets?.id,
                                                        type: 'street');
                                              },
                                              onChanged: (House? house) {
                                                controller.SelectedHouse(house);

                                                controller
                                                        .houseaddressdetailController
                                                        .text =
                                                    "${controller.societies!.name}${' '}${controller.blocks!.address}${' '}${controller.streets!.address.toString()}${' '}${house!.address.toString()}";

                                                controller
                                                    .isPropertyHouseApartment();
                                              },
                                              selectedItem: controller.houses,
                                              itemAsString: (House p) {
                                                return p.address.toString();
                                              },
                                            ),
                                          ),

                                          /// House Measurement
                                          (controller.streets?.subadminid ==
                                                  null)
                                              ? Container()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ResidentAddressDetailHeading(
                                                        text: 'Select Area *'),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: DropdownSearch<
                                                          Measurement>(
                                                        validator: (value) =>
                                                            value == null
                                                                ? 'field required'
                                                                : null,
                                                        asyncItems: (String
                                                            filter) async {
                                                          print(filter);
                                                          return controller.housesApartmentsModelApi(
                                                              subadminid:
                                                                  controller
                                                                      .streets!
                                                                      .subadminid!,
                                                              token: controller
                                                                  .user!
                                                                  .bearerToken!,
                                                              type: 'house');
                                                        },
                                                        onChanged: (Measurement?
                                                            data) {
                                                          controller
                                                              .SelectedHousesApartments(
                                                                  data);
                                                        },
                                                        selectedItem: controller
                                                            .housesApartmentsModel,
                                                        itemAsString:
                                                            (Measurement p) {
                                                          return p.area
                                                                  .toString() +
                                                              ' ' +
                                                              p.unit.toString();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )
                                        ] else ...[
                                          ResidentAddressDetailHeading(
                                              text: 'Select Building'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Building>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllBuildingApi(
                                                  bearerToken: controller
                                                      .user!.bearerToken!,
                                                  subAdminId: controller
                                                      .societies!.subAdminId,
                                                );
                                              },
                                              onChanged: (Building? data) {
                                                controller.SelectedBuilding(
                                                    data);
                                              },
                                              selectedItem: controller.building,
                                              itemAsString: (Building p) {
                                                return p.societybuildingname
                                                    .toString();
                                              },
                                            ),
                                          ),
                                          ResidentAddressDetailHeading(
                                              text: 'Select Floor'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Floor>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllFloorApi(
                                                        bearerToken: controller
                                                            .user!.bearerToken!,
                                                        buildingid: controller
                                                            .building?.id);
                                              },
                                              onChanged: (Floor? data) {
                                                controller.SelectedFloor(data);
                                              },
                                              selectedItem: controller.floor,
                                              itemAsString: (Floor p) {
                                                return p.name.toString();
                                              },
                                            ),
                                          ),
                                          ResidentAddressDetailHeading(
                                              text: 'Select Apartment'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Apartment>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllApartmentApi(
                                                        bearerToken: controller
                                                            .user!.bearerToken!,
                                                        floorid: controller
                                                            .floor?.id);
                                              },
                                              onChanged:
                                                  (Apartment? apartment) {
                                                controller.SelectedApartment(
                                                    apartment);

                                                controller
                                                        .houseaddressdetailController
                                                        .text =
                                                    "${controller.societies!.name}${' '}${controller.building!.societybuildingname.toString()}${' '} ${controller.floor!.name.toString()}${' '}${apartment!.name.toString()}";
                                              },
                                              selectedItem:
                                                  controller.apartment,
                                              itemAsString: (Apartment p) {
                                                return p.name.toString();
                                              },
                                            ),
                                          ),
                                          ResidentAddressDetailHeading(
                                              text: 'Select Area *'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Measurement>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .housesApartmentsModelApi(
                                                        subadminid: controller
                                                            .societies!
                                                            .subAdminId!,
                                                        token: controller
                                                            .user!.bearerToken!,
                                                        type: 'apartment');
                                              },
                                              onChanged: (Measurement? data) {
                                                controller
                                                    .SelectedHousesApartments(
                                                        data);
                                              },
                                              selectedItem: controller
                                                  .housesApartmentsModel,
                                              itemAsString: (Measurement p) {
                                                return p.area.toString() +
                                                    ' ' +
                                                    p.unit.toString();
                                              },
                                            ),
                                          )
                                        ]
                                      ]

                                      /// For Type 3=> Society,Phase,Block,Street, House
                                      else if (controller
                                              .societies?.structureType ==
                                          3) ...[
                                        ResidentAddressDetailHeading(
                                            text: 'Select Property Type'),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButtonFormField(
                                            isExpanded: true,
                                            style: GoogleFonts.ubuntu(
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14,
                                                color: HexColor('#4D4D4D')),
                                            value: controller.propertytype,
                                            icon: Icon(
                                              Icons.arrow_drop_down_sharp,
                                              color: primaryColor,
                                            ),
                                            validator: (value) => value == null
                                                ? 'Please Select Property Type'
                                                : null,
                                            items: controller.propertytypelist
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items.capitalizeFirst
                                                      .toString(),
                                                  style: GoogleFonts.ubuntu(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp,
                                                      color:
                                                          HexColor('#4D4D4D')),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              controller.SelectedProperty(
                                                  newValue);
                                            },
                                          ),
                                        ),

                                        /// Check Property Type House or Apartment

                                        if (controller.propertytype ==
                                            'house') ...[
                                          /// Phase

                                          ResidentAddressDetailHeading(
                                              text: 'Select Phase'),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Phase>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllPhasesApi(
                                                        dynamicId: controller
                                                            .societies?.id);
                                              },
                                              onChanged: (Phase? data) {
                                                controller.SelectedPhase(data);
                                              },
                                              selectedItem: controller.phases,
                                              itemAsString: (Phase p) {
                                                return p.address.toString();
                                              },
                                            ),
                                          ),

                                          /// Block

                                          ResidentAddressDetailHeading(
                                              text: 'Select Block'),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Block>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllBlocksApi(
                                                        dynamicId: controller
                                                            .phases?.id,
                                                        type: 'phase');
                                              },
                                              onChanged: (Block? data) {
                                                controller.SelectedBlock(data);
                                              },
                                              selectedItem: controller.blocks,
                                              itemAsString: (Block p) {
                                                return p.address.toString();
                                              },
                                            ),
                                          ),

                                          /// Street

                                          ResidentAddressDetailHeading(
                                              text: 'Select Street'),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Street>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllStreetsApi(
                                                        dynamicId: controller
                                                            .blocks?.id,
                                                        type: 'blocks');
                                              },
                                              onChanged: (Street? data) {
                                                controller.SelectedStreet(data);
                                              },
                                              selectedItem: controller.streets,
                                              itemAsString: (Street p) {
                                                return p.address.toString();
                                              },
                                            ),
                                          ),

                                          ///House
                                          ResidentAddressDetailHeading(
                                              text: 'Select House'),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<House>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllHousesApi(
                                                        dynamicId: controller
                                                            .streets?.id,
                                                        type: 'street');
                                              },
                                              onChanged: (House? house) {
                                                controller.SelectedHouse(house);

                                                controller
                                                        .houseaddressdetailController
                                                        .text =
                                                    "${controller.societies!.name}${' '}${controller.phases!.address.toString()}${' '}${controller.blocks!.address.toString()}${' '}${controller.streets!.address.toString()}${' '}${house!.address.toString()}";
                                                ;

                                                controller
                                                    .isPropertyHouseApartment();
                                              },
                                              selectedItem: controller.houses,
                                              itemAsString: (House p) {
                                                return p.address.toString();
                                              },
                                            ),
                                          ),

                                          /// House Measurement
                                          (controller.streets?.subadminid ==
                                                  null)
                                              ? Container()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ResidentAddressDetailHeading(
                                                        text: 'Select Area *'),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: DropdownSearch<
                                                          Measurement>(
                                                        validator: (value) =>
                                                            value == null
                                                                ? 'field required'
                                                                : null,
                                                        asyncItems: (String
                                                            filter) async {
                                                          print(filter);
                                                          return controller.housesApartmentsModelApi(
                                                              subadminid:
                                                                  controller
                                                                      .streets!
                                                                      .subadminid!,
                                                              token: controller
                                                                  .user!
                                                                  .bearerToken!,
                                                              type: 'house');
                                                        },
                                                        onChanged: (Measurement?
                                                            data) {
                                                          controller
                                                              .SelectedHousesApartments(
                                                                  data);
                                                        },
                                                        selectedItem: controller
                                                            .housesApartmentsModel,
                                                        itemAsString:
                                                            (Measurement p) {
                                                          return p.area
                                                                  .toString() +
                                                              ' ' +
                                                              p.unit.toString();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )
                                        ] else ...[
                                          ResidentAddressDetailHeading(
                                              text: 'Select Building'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Building>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllBuildingApi(
                                                  bearerToken: controller
                                                      .user!.bearerToken!,
                                                  subAdminId: controller
                                                      .societies!.subAdminId,
                                                );
                                              },
                                              onChanged: (Building? data) {
                                                controller.SelectedBuilding(
                                                    data);
                                              },
                                              selectedItem: controller.building,
                                              itemAsString: (Building p) {
                                                return p.societybuildingname
                                                    .toString();
                                              },
                                            ),
                                          ),
                                          ResidentAddressDetailHeading(
                                              text: 'Select Floor'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Floor>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllFloorApi(
                                                        bearerToken: controller
                                                            .user!.bearerToken!,
                                                        buildingid: controller
                                                            .building?.id);
                                              },
                                              onChanged: (Floor? data) {
                                                controller.SelectedFloor(data);
                                              },
                                              selectedItem: controller.floor,
                                              itemAsString: (Floor p) {
                                                return p.name.toString();
                                              },
                                            ),
                                          ),
                                          ResidentAddressDetailHeading(
                                              text: 'Select Apartment'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Apartment>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllApartmentApi(
                                                        bearerToken: controller
                                                            .user!.bearerToken!,
                                                        floorid: controller
                                                            .floor?.id);
                                              },
                                              onChanged:
                                                  (Apartment? apartment) {
                                                controller.SelectedApartment(
                                                    apartment);
                                                controller
                                                        .houseaddressdetailController
                                                        .text =
                                                    "${controller.societies!.name}${' '}${controller.building!.societybuildingname.toString()}${' '} ${controller.floor!.name.toString()}${' '}${apartment!.name.toString()}";
                                              },
                                              selectedItem:
                                                  controller.apartment,
                                              itemAsString: (Apartment p) {
                                                return p.name.toString();
                                              },
                                            ),
                                          ),
                                          ResidentAddressDetailHeading(
                                              text: 'Select Area *'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Measurement>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .housesApartmentsModelApi(
                                                        subadminid: controller
                                                            .societies!
                                                            .subAdminId!,
                                                        token: controller
                                                            .user!.bearerToken!,
                                                        type: 'apartment');
                                              },
                                              onChanged: (Measurement? data) {
                                                controller
                                                    .SelectedHousesApartments(
                                                        data);
                                              },
                                              selectedItem: controller
                                                  .housesApartmentsModel,
                                              itemAsString: (Measurement p) {
                                                return p.area.toString() +
                                                    ' ' +
                                                    p.unit.toString();
                                              },
                                            ),
                                          )
                                        ]
                                      ]

                                      /// For Type 1 => Local Building
                                      else if (controller
                                              .societies?.structureType ==
                                          5) ...[
                                        ResidentAddressDetailHeading(
                                            text: 'Select Property Type'),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButtonFormField(
                                            isExpanded: true,
                                            style: GoogleFonts.ubuntu(
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14,
                                                color: HexColor('#4D4D4D')),
                                            value: controller.propertytype,
                                            icon: Icon(
                                              Icons.arrow_drop_down_sharp,
                                              color: primaryColor,
                                            ),
                                            validator: (value) => value == null
                                                ? 'Please Select Property Type'
                                                : null,
                                            items: controller.propertytypelist
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items.capitalizeFirst
                                                      .toString(),
                                                  style: GoogleFonts.ubuntu(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp,
                                                      color:
                                                          HexColor('#4D4D4D')),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              controller.SelectedProperty(
                                                  newValue);
                                            },
                                          ),
                                        ),

                                        /// Check Property Type House or Apartment

                                        if (controller.propertytype ==
                                            'house') ...[
                                          ResidentAddressDetailHeading(
                                              text: 'Select House'),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<House>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllHousesApi(
                                                        dynamicId: controller
                                                            .societies?.id,
                                                        type: 'society');
                                              },
                                              onChanged: (House? house) {
                                                controller.SelectedHouse(house);

                                                controller
                                                        .houseaddressdetailController
                                                        .text =
                                                    "${controller.societies!.name}${' '} ${house!.address.toString()}";
                                                controller
                                                    .isPropertyHouseApartment();
                                              },
                                              selectedItem: controller.houses,
                                              itemAsString: (House p) {
                                                return p.address.toString();
                                              },
                                            ),
                                          ),

                                          /// House Measurement
                                          ResidentAddressDetailHeading(
                                              text: 'Select Area'),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Measurement>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .housesApartmentsModelApi(
                                                        subadminid: controller
                                                            .societies!
                                                            .subAdminId!,
                                                        token: controller
                                                            .user!.bearerToken!,
                                                        type: 'house');
                                              },
                                              onChanged: (Measurement? data) {
                                                controller
                                                    .SelectedHousesApartments(
                                                        data);
                                              },
                                              selectedItem: controller
                                                  .housesApartmentsModel,
                                              itemAsString: (Measurement p) {
                                                return p.area.toString() +
                                                    ' ' +
                                                    p.unit.toString();
                                              },
                                            ),
                                          )
                                        ] else ...[
                                          ResidentAddressDetailHeading(
                                              text: 'Select Building'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Building>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllBuildingApi(
                                                  bearerToken: controller
                                                      .user!.bearerToken!,
                                                  subAdminId: controller
                                                      .societies!.subAdminId,
                                                );
                                              },
                                              onChanged: (Building? data) {
                                                controller.SelectedBuilding(
                                                    data);
                                              },
                                              selectedItem: controller.building,
                                              itemAsString: (Building p) {
                                                return p.societybuildingname
                                                    .toString();
                                              },
                                            ),
                                          ),
                                          ResidentAddressDetailHeading(
                                              text: 'Select Floor'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Floor>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllFloorApi(
                                                        bearerToken: controller
                                                            .user!.bearerToken!,
                                                        buildingid: controller
                                                            .building?.id);
                                              },
                                              onChanged: (Floor? data) {
                                                controller.SelectedFloor(data);
                                              },
                                              selectedItem: controller.floor,
                                              itemAsString: (Floor p) {
                                                return p.name.toString();
                                              },
                                            ),
                                          ),
                                          ResidentAddressDetailHeading(
                                              text: 'Select Apartment'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Apartment>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .viewAllApartmentApi(
                                                        bearerToken: controller
                                                            .user!.bearerToken!,
                                                        floorid: controller
                                                            .floor?.id);
                                              },
                                              onChanged:
                                                  (Apartment? apartment) {
                                                controller.SelectedApartment(
                                                    apartment);
                                                controller
                                                        .houseaddressdetailController
                                                        .text =
                                                    "${controller.societies!.name}${' '}${controller.building!.societybuildingname.toString()}${' '} ${controller.floor!.name.toString()}${' '}${apartment!.name.toString()}";
                                              },
                                              selectedItem:
                                                  controller.apartment,
                                              itemAsString: (Apartment p) {
                                                return p.name.toString();
                                              },
                                            ),
                                          ),
                                          ResidentAddressDetailHeading(
                                              text: 'Select Area *'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownSearch<Measurement>(
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
                                              asyncItems:
                                                  (String filter) async {
                                                print(filter);
                                                return controller
                                                    .housesApartmentsModelApi(
                                                        subadminid: controller
                                                            .societies!
                                                            .subAdminId!,
                                                        token: controller
                                                            .user!.bearerToken!,
                                                        type: 'apartment');
                                              },
                                              onChanged: (Measurement? data) {
                                                controller
                                                    .SelectedHousesApartments(
                                                        data);
                                              },
                                              selectedItem: controller
                                                  .housesApartmentsModel,
                                              itemAsString: (Measurement p) {
                                                return p.area.toString() +
                                                    ' ' +
                                                    p.unit.toString();
                                              },
                                            ),
                                          )
                                        ]
                                      ]
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ResidentAddressDetailHeading(
                                          text: 'Select Building'),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownSearch<Society>(
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                          asyncItems: (String filter) async {
                                            return controller
                                                .viewAllSocietiesApi(
                                                    controller
                                                        .societyorbuildingval,
                                                    controller.token);
                                          },
                                          onChanged: (Society? data) {
                                            controller.SelectedSociety(data!);
                                          },
                                          selectedItem: controller.societies,
                                          itemAsString: (Society society) {
                                            return society.name.toString();
                                          },
                                        ),
                                      ),
                                      ResidentAddressDetailHeading(
                                          text: 'Select Floor'),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownSearch<Floor>(
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                          asyncItems: (String filter) async {
                                            print(filter);
                                            return controller
                                                .viewAllLocalBuildingFloorApi(
                                                    bearerToken: controller
                                                        .user!.bearerToken!,
                                                    buildingid: controller
                                                        .societies?.id);
                                          },
                                          onChanged: (Floor? data) {
                                            controller.SelectedFloor(data);
                                          },
                                          selectedItem: controller.floor,
                                          itemAsString: (Floor p) {
                                            return p.name.toString();
                                          },
                                        ),
                                      ),
                                      ResidentAddressDetailHeading(
                                          text: 'Select Apartment'),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownSearch<Apartment>(
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                          asyncItems: (String filter) async {
                                            print(filter);
                                            return controller
                                                .viewAllLocalBuildingApartmentApi(
                                                    bearerToken: controller
                                                        .user!.bearerToken!,
                                                    floorid:
                                                        controller.floor?.id);
                                          },
                                          onChanged: (Apartment? apartment) {
                                            controller.SelectedApartment(
                                                apartment);
                                            controller
                                                    .houseaddressdetailController
                                                    .text =
                                                "${controller.societies!.name}${' '} ${controller.floor!.name.toString()}${' '}${apartment!.name.toString()}";
                                          },
                                          selectedItem: controller.apartment,
                                          itemAsString: (Apartment p) {
                                            return p.name.toString();
                                          },
                                        ),
                                      ),
                                      ResidentAddressDetailHeading(
                                          text: 'Select Area *'),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownSearch<Measurement>(
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                          asyncItems: (String filter) async {
                                            print(filter);
                                            return controller
                                                .housesApartmentsModelApi(
                                                    subadminid: controller
                                                        .societies!.subAdminId!,
                                                    token: controller
                                                        .user!.bearerToken!,
                                                    type: 'apartment');
                                          },
                                          onChanged: (Measurement? data) {
                                            controller.SelectedHousesApartments(
                                                data);
                                          },
                                          selectedItem:
                                              controller.housesApartmentsModel,
                                          itemAsString: (Measurement p) {
                                            return p.area.toString() +
                                                ' ' +
                                                p.unit.toString();
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      MyTextFormField(
                        fontWeight: FontWeight.w500,
                        readOnly: true,
                        validator: ValidationHelper().emptyStringValidator,
                        maxLines: null,
                        controller: controller.houseaddressdetailController,
                        hintText: 'House / Apartment Address ',
                        labelText: 'House / Apartment Address ',
                      ),
                      MyTextFormField(
                        controller: controller.vehiclenoController,
                        hintText: 'Vehicle No',
                        labelText: 'Vehicle No (optional)',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ResidentAddressDetailHeading(
                                  text: 'Select Resident Type'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  isExpanded: true,
                                  style: GoogleFonts.ubuntu(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: HexColor('#4D4D4D')),
                                  value: controller.rentalorowner,
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: primaryColor,
                                  ),
                                  items: controller.rentalorownerlist
                                      .map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    controller.SelectedRentalOrOwner(newValue);
                                  },
                                ),
                              ),
                            ]),
                      ),
                      controller.rentalorowner == 'Rental'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    'Owner Details',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                MyTextFormField(
                                  controller: controller.ownernameController,
                                  validator:
                                      ValidationHelper().emptyStringValidator,
                                  hintText: 'Owner Name',
                                  labelText: 'Owner Name',
                                ),
                                MyTextFormField(
                                  textInputType: TextInputType.number,
                                  controller:
                                      controller.ownerphonenumController,
                                  validator:
                                      ValidationHelper().emptyStringValidator,
                                  hintText: 'Owner Phone No',
                                  labelText: 'Owner Phone No',
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      MyButton(
                        onPressed: controller.isLoading
                            ? null
                            : () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  if (controller.societyorbuildingval ==
                                      'society') {
                                    controller.addResidentApi(
                                      subadminid:
                                          controller.societies!.subAdminId!,
                                      residentid: controller.user!.userId!,
                                      country: controller.country ?? "N/A",
                                      state: controller.state ?? "N/A",
                                      city: controller.city ?? "N/A",
                                      societyid: controller.societies?.id,
                                      phaseid: controller.phases?.id ?? 0,
                                      blockid: controller.blocks?.id ?? 0,
                                      streetid: controller.streets?.id ?? 0,
                                      propertyid: controller.houses?.id,
                                      houseaddress: controller
                                          .houseaddressdetailController.text,
                                      residentalType: controller.rentalorowner,
                                      propertyType: controller.propertytype,
                                      vechileno:
                                          controller.vehiclenoController.text,
                                      bearerToken:
                                          controller.user!.bearerToken!,
                                      ownerName:
                                          controller.ownernameController.text,
                                      ownerPhoneNo: controller
                                          .ownerphonenumController.text,
                                      measurementid:
                                          controller.housesApartmentsModel?.id,
                                      apartmentid: controller.apartment?.id,
                                      buildingid: controller.building?.id,
                                      floorid: controller.floor?.id,
                                    );
                                  } else {
                                    print('local building');
                                    controller.addResidentApi(
                                      subadminid:
                                          controller.societies!.subAdminId!,
                                      residentid: controller.user!.userId!,
                                      country: controller.country ?? "N/A",
                                      state: controller.state ?? "N/A",
                                      city: controller.city ?? "N/A",
                                      societyid: controller.societies?.id,
                                      houseaddress: controller
                                          .houseaddressdetailController.text,
                                      residentalType: controller.rentalorowner,
                                      propertyType: 'localbuildingapartment',
                                      vechileno:
                                          controller.vehiclenoController.text,
                                      bearerToken:
                                          controller.user!.bearerToken!,
                                      ownerName:
                                          controller.ownernameController.text,
                                      ownerPhoneNo: controller
                                          .ownerphonenumController.text,
                                      measurementid:
                                          controller.housesApartmentsModel?.id,
                                      apartmentid: controller.apartment?.id,
                                      floorid: controller.floor?.id,
                                    );
                                  }
                                }
                              },
                        textColor: Colors.white,
                        color: primaryColor,
                        name: 'Save',
                        outlinedBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class ResidentAddressDetailHeading extends StatelessWidget {
  final String? text;

  const ResidentAddressDetailHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Text(
        text!,
        style: GoogleFonts.ubuntu(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: HexColor('#4D4D4D')),
      ),
    );
  }
}
