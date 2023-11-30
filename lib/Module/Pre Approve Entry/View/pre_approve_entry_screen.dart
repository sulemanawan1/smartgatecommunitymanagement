import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/Dialog%20Box%20Elipse%20Heading/dialog_box_elipse_heading.dart';
import 'package:userapp/Widgets/Empty%20List/empty_list.dart';
import 'package:userapp/Widgets/My%20Floating%20Action%20Button/my_floating_action_button.dart';

import '../../../Constants/constants.dart';
import '../../../Helpers/Date Helper/date_helper.dart';
import '../../../Widgets/My Back Button/my_back_button.dart';
import '../Controller/pre_approve_entry_controller.dart';
import '../Model/PreApproveEntry.dart';

class PreApproveEntryScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreApproveEntryController>(
        init: PreApproveEntryController(),
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                Get.offNamed(homescreen, arguments: controller.userdata);

                return true;
              },
              child: SafeArea(
                  child: Scaffold(
                      backgroundColor: Colors.white,
                      floatingActionButton: MyFloatingActionButton(
                        onPressed: () {
                          Get.offNamed(addpreapproveentryscreen, arguments: [
                            controller.userdata,
                            controller.resident,
                            0
                          ]);
                        },
                      ),
                      body: Column(
                        children: [
                          MyBackButton(
                            text: 'Pre Approve Entry',
                            onTap: () {
                              Get.offNamed(homescreen,
                                  arguments: controller.userdata);
                            },
                          ),
                          19.h.ph,
                          Expanded(
                            child: PagedListView(
                              shrinkWrap: true,
                              primary: false,
                              pagingController: controller.pagingController,
                              addAutomaticKeepAlives: false,
                              builderDelegate: PagedChildBuilderDelegate(
                                noItemsFoundIndicatorBuilder: (context) {
                                  return EmptyList(
                                    name: 'No Entry Yet',
                                  );
                                },
                                itemBuilder: (context, item, index) {
                                  final PreApproveEntry p =
                                      item as PreApproveEntry;
                                  return GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                  content:
                                                      PreApproveEntryDialog(
                                                name: p.name,
                                                description: p.description,
                                                arrivaldate: p.arrivaldate,
                                                arrivaltime: p.arrivaltime,
                                                cnic: p.cnic,
                                                mobileno: p.mobileno,
                                                vechileno: p.vechileno,
                                                visitortype: p.visitortype,
                                              )));
                                    },
                                    child: PreApproveEntryCard(
                                        createdAt: p.createdAt,
                                        updatedAt: p.updatedAt,
                                        name: p.name,
                                        status: p.status,
                                        arrivalDate: p.arrivaldate,
                                        checkInTime: p.checkInTime,
                                        checkOutTime: p.checkOutTime,
                                        statusDescription: p.statusdescription,
                                        visitorType: p.visitortype),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ))));
        });
  }

  Widget MyStatusWidget(
      {required status,
      required color,
      textColor,
      double? width,
      double? height}) {
    return Padding(
      padding: EdgeInsets.only(right: 14.w),
      child: Container(
        width: width ?? 64.w,
        height: height ?? 18.w,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(4.r)),
        child: Center(
          child: Text(
            status,
            style: TextStyle(
              fontSize: 10.sp,
              color: textColor ?? HexColor('#FFFFFF'),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget PreApproveEntryCard(
      {required name,
      required checkInTime,
      required checkOutTime,
      required createdAt,
      required updatedAt,
      required arrivalDate,
      required visitorType,
      required status,
      required statusDescription}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.w, 13.h, 22.2.w, 0),
      child: SizedBox(
        width: 343.w,
        height: 100.w,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0.r),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 13.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 11.h),
                      child: Text(name,
                          style: GoogleFonts.ubuntu(
                            color: HexColor('#606470'),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                    Container(
                        width: 105.w,
                        height: 27.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: HexColor('#E8E8E8')),
                          borderRadius: BorderRadius.circular(
                            4.r,
                          ),
                          color: HexColor('#F6F6F6'),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 15.w,
                              color: HexColor('#A7A7A7'),
                            ),
                            Text(
                              arrivalDate,
                              style: GoogleFonts.ubuntu(
                                  color: HexColor('#A5AAB7'),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  ],
                ),
                6.h.ph,
                PreApproveEntryCardText(
                    heading: 'Visitor Type: ', text: visitorType),
                7.h.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (status == 0) ...[
                      PreApproveEntryCardText(
                          heading: 'Created At : ',
                          text: DateHelper.convertTo12HourFormatFromTimeStamp(
                              createdAt)),
                      MyStatusWidget(
                          status: statusDescription, color: HexColor('#E85C5C'))
                    ] else if (status == 1) ...[
                      PreApproveEntryCardText(
                          heading: 'Approved At : ',
                          text: DateHelper.convertTo12HourFormatFromTimeStamp(
                              updatedAt)),
                      MyStatusWidget(
                        status: statusDescription,
                        color: HexColor('#48CA46'),
                      )
                    ] else if (status == 2) ...[
                      PreApproveEntryCardText(
                          heading: 'Checkin Time : ',
                          text: DateHelper.Hour12formatTime(checkInTime)),
                      MyStatusWidget(
                          status: 'Arrived', color: HexColor('#5DD4B1'))
                    ] else ...[
                      PreApproveEntryCardText(
                          heading: 'Checkout Time : ',
                          text: DateHelper.Hour12formatTime(checkOutTime)),
                      MyStatusWidget(
                        status: 'Departed',
                        color: HexColor('#5A8CED'),
                      )
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PreApproveEntryDialog extends StatelessWidget {
  final String? name;
  final String? description;
  final String? visitortype;
  final String? vechileno;
  final String? mobileno;
  final String? arrivaldate;
  final String? arrivaltime;
  final String? cnic;

  const PreApproveEntryDialog(
      {super.key,
      required this.name,
      required this.description,
      required this.visitortype,
      required this.vechileno,
      required this.mobileno,
      required this.arrivaldate,
      required this.arrivaltime,
      required this.cnic});

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(name ?? "",
                style: GoogleFonts.montserrat(
                  color: HexColor("#4D4D4D"),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                )),
          ),
          Center(
            child: Text(description ?? "",
                style: GoogleFonts.ubuntu(
                  color: HexColor("#4D4D4D"),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                )),
          ),
          23.33.h.ph,
          DialogBoxElipseHeading(text: 'Visitor Type'),
          DialogBoxText(
            text: visitortype ?? "",
          ),
          23.33.h.ph,
          DialogBoxElipseHeading(text: 'Mobile No'),
          DialogBoxText(
            text: mobileno ?? "",
          ),
          23.33.h.ph,
          DialogBoxElipseHeading(text: 'Expected Arrival Time'),
          DialogBoxText(
            text: DateHelper.Hour12formatTime(arrivaltime!) ?? "",
          ),
          23.33.h.ph,
          DialogBoxElipseHeading(text: 'Expected Arrival Date'),
          DialogBoxText(text: arrivaldate ?? ""),
          23.33.h.ph,
          DialogBoxElipseHeading(text: 'CNIC'),
          DialogBoxText(
            text: cnic ?? "",
          ),
          23.33.h.ph,
          DialogBoxElipseHeading(text: 'Vechile No'),
          DialogBoxText(
            text: vechileno ?? "",
          ),
        ],
      ),
    );
  }
}

class DialogBoxText extends StatelessWidget {
  final String? text;

  const DialogBoxText({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w),
      child: Text(
        text ?? "",
        style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.w300,
            fontSize: 16.sp,
            color: HexColor('#1A1A1A')),
      ),
    );
  }
}

class PreApproveEntryCardText extends StatelessWidget {
  final String? heading;
  final String? text;

  const PreApproveEntryCardText(
      {super.key, required this.heading, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: heading,
          style: GoogleFonts.ubuntu(
            color: HexColor('#A5AAB7'),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
        TextSpan(
          text: text,
          style: GoogleFonts.ubuntu(
            color: HexColor('#606470'),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
      ]),
    );
  }
}
