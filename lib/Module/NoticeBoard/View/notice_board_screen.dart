import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Widgets/Empty%20List/empty_list.dart';
import 'package:userapp/Widgets/Loader/loader.dart';
import 'package:userapp/Widgets/My%20Back%20Button/my_back_button.dart';

import '../../../Helpers/Date Helper/date_helper.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/Complain Dialog Border/complan_dialog_border.dart';
import '../../../Widgets/Dialog Box Elipse Heading/dialog_box_elipse_heading.dart';
import '../../../Widgets/My Button/my_button.dart';
import '../Controller/notice_board_controller.dart';

class NoticeBoardScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeBoardController>(
      init: NoticeBoardController(),
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          Get.offNamed(homescreen, arguments: controller.userdata);
          return true;
        },
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  MyBackButton(
                    text: 'NoticeBoard',
                    onTap: () {
                      Get.offNamed(homescreen, arguments: controller.userdata);
                    },
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: controller.viewNoticeBoardApi(
                            controller.resident.subadminid!,
                            controller.userdata.bearerToken!),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.data != null &&
                                snapshot.data!.data.length != 0) {
                              return ListView.builder(
                                  itemBuilder: (context, index) {
                                    controller.snapShot =
                                        snapshot.data!.data[index];
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                    content:
                                                        NoticeBoardDialogCard(
                                                  status: snapshot
                                                      .data!.data[index].status,
                                                  startDate: snapshot.data!
                                                      .data[index].startdate,
                                                  endDate: snapshot.data!
                                                      .data[index].enddate,
                                                  title: snapshot.data!
                                                      .data[index].noticetitle,
                                                  description: snapshot.data!
                                                      .data[index].noticedetail,
                                                  endTime: snapshot.data!
                                                      .data[index].endtime,
                                                  startTime: snapshot.data!
                                                      .data[index].starttime,
                                                )));
                                      },
                                      child: NoticeboardCard(
                                          title:
                                              controller.snapShot.noticetitle,
                                          description:
                                              controller.snapShot.noticedetail,
                                          startDate:
                                              controller.snapShot.startdate),
                                    );
                                  },
                                  itemCount: snapshot.data!.data.length);
                            } else {
                              return EmptyList(
                                name: 'No Notices',
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
              )),
        ),
      ),
    );
  }
}

class NoticeBoardDialogCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final int? status;

  const NoticeBoardDialogCard(
      {super.key,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 347.w,
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (status == 0) ...[
          Center(
            child: Text('Notice Board',
                style: GoogleFonts.montserrat(
                    color: HexColor('#4D4D4D'),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700)),
          ),
          14.h.ph,
          Text(
            'Title',
            style: GoogleFonts.ubuntu(
                color: HexColor('#4D4D4D'),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400),
          ),
          4.h.ph,
          Text(
            title ?? "",
            style: GoogleFonts.ubuntu(
              color: HexColor('#4D4D4D'),
              fontSize: 12.sp,
            ),
          ),
          14.h.ph,
          Text(
            'Description',
            style: GoogleFonts.ubuntu(
                color: HexColor('#4D4D4D'),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400),
          ),
          4.h.ph,
          Text(
            description ?? "",
            style: GoogleFonts.ubuntu(
              color: HexColor('#4D4D4D'),
              fontSize: 12.sp,
            ),
          ),
          31.34.h.ph,
          DialogBoxElipseHeading(text: 'Date'),
          20.h.ph,
          Padding(
            padding: EdgeInsets.only(left: 26.6.w),
            child: Row(
              children: [
                Text(
                  "From",
                  style: GoogleFonts.ubuntu(
                    color: HexColor('#4D4D4D'),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
                110.w.pw,
                Text(
                  "To",
                  style: GoogleFonts.ubuntu(
                    color: HexColor('#4D4D4D'),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          10.h.ph,
          Padding(
            padding: EdgeInsets.only(left: 26.6.w),
            child: Row(
              children: [
                ComplainDialogBorderWidget(
                    text: DateHelper.convertDateFormatToDayMonthYearDateFormat(
                        startDate!)),
                15.w.pw,
                SvgPicture.asset(
                  'assets/complaint_history_arrow_icon.svg',
                  width: 15.w,
                  height: 15.w,
                ),
                15.w.pw,
                ComplainDialogBorderWidget(
                    text: DateHelper.convertDateFormatToDayMonthYearDateFormat(
                        endDate!)),
              ],
            ),
          ),
          10.h.ph,
          DialogBoxElipseHeading(text: 'Time'),
          20.h.ph,
          Padding(
            padding: EdgeInsets.only(left: 26.6.w),
            child: Row(
              children: [
                Text(
                  "From",
                  style: GoogleFonts.ubuntu(
                    color: HexColor('#4D4D4D'),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
                110.w.pw,
                Text(
                  "To",
                  style: GoogleFonts.ubuntu(
                    color: HexColor('#4D4D4D'),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          10.h.ph,
          Padding(
            padding: EdgeInsets.only(left: 26.6.w),
            child: Row(
              children: [
                ComplainDialogBorderWidget(
                    text: DateHelper.Hour12formatTime(startTime!)),
                15.w.pw,
                SvgPicture.asset(
                  'assets/complaint_history_arrow_icon.svg',
                  width: 15.w,
                  height: 15.w,
                ),
                15.w.pw,
                ComplainDialogBorderWidget(
                    text: DateHelper.Hour12formatTime(endTime!)),
              ],
            ),
          ),
          37.h.ph,
          Center(
            child: MyButton(
              name: 'Ok',
              width: 96.w,
              height: 31.w,
              border: 7.r,
              onPressed: () {
                Get.back();
              },
            ),
          )
        ] else ...[
          Center(
            child: Text('Notice Board',
                style: GoogleFonts.montserrat(
                    color: HexColor('#4D4D4D'),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700)),
          ),
          14.h.ph,
          Text(
            'Title',
            style: GoogleFonts.ubuntu(
                color: HexColor('#4D4D4D'),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400),
          ),
          4.h.ph,
          Text(
            title ?? "",
            style: GoogleFonts.ubuntu(
              color: HexColor('#4D4D4D'),
              fontSize: 12.sp,
            ),
          ),
          14.h.ph,
          Text(
            'Description',
            style: GoogleFonts.ubuntu(
                color: HexColor('#4D4D4D'),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400),
          ),
          4.h.ph,
          Text(
            description ?? "",
            style: GoogleFonts.ubuntu(
              color: HexColor('#4D4D4D'),
              fontSize: 12.sp,
            ),
          ),
          37.h.ph,
          Center(
            child: MyButton(
              name: 'Ok',
              width: 96.w,
              height: 31.w,
              border: 7.r,
              onPressed: () {
                Get.back();
              },
            ),
          )
        ]
      ])),
    );
  }
}

class NoticeboardCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? startDate;

  const NoticeboardCard(
      {super.key,
      required this.title,
      required this.description,
      required this.startDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 14.51.h, 16.w, 0),
      child: SizedBox(
        width: 343.w,
        height: 72.w,
        child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 13.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 220.w,
                          child: Text(
                            title ?? '',
                            style: GoogleFonts.ubuntu(
                                color: HexColor('#606470'),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      6.h.ph,
                      Expanded(
                        child: SizedBox(
                          width: 220.w,
                          child: Text(
                            description ?? '',
                            style: GoogleFonts.ubuntu(
                              color: HexColor('#4D4D4D'),
                              fontSize: 12.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 93.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(4.r)),
                  child: Row(
                    children: [
                      6.w.pw,
                      SvgPicture.asset(
                        'assets/event_date_icon.svg',
                        width: 12.w,
                        height: 12.w,
                        color: HexColor('#FFFFFF'),
                      ),
                      8.w.pw,
                      Text(
                          DateHelper.convertDateFormatToDayMonthYearDateFormat(
                                  startDate!) ??
                              "",
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w300,
                              fontSize: 10.sp,
                              color: HexColor('#FFFFFF')))
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
