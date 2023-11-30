import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Widgets/My%20Back%20Button/my_back_button.dart';

import '../../../Helpers/Date Helper/date_helper.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/Empty List/empty_list.dart';
import '../../Report to Sub Admin/Model/Reports.dart';
import '../../Report to Sub Admin/View/Admin Reports/admin_reports.dart';
import '../Controller/admin_reports_history_controller.dart';

class ReportsHistoryScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportHistoryController>(
        init: ReportHistoryController(),
        builder: (controller) => SafeArea(
              child: WillPopScope(
                onWillPop: () async {
                  Get.offNamed(homescreen, arguments: controller.user);
                  return true;
                },
                child: Scaffold(
                    backgroundColor: HexColor('#FCFCFC'),
                    body: Column(children: [
                      MyBackButton(
                        text: 'Report History',
                        onTap: () {
                          Get.offNamed(homescreen, arguments: controller.user);
                        },
                      ),
                      32.h.ph,
                      Expanded(
                        child: PagedListView(
                          shrinkWrap: true,
                          primary: false,
                          pagingController: controller.pagingController,
                          addAutomaticKeepAlives: false,
                          builderDelegate: PagedChildBuilderDelegate(
                            noItemsFoundIndicatorBuilder: (context) {
                              return EmptyList(
                                name: 'No History',
                              );
                            },
                            itemBuilder: (context, item, index) {
                              final Reports reports = item as Reports;

                              return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                                content: ComplaintHistoryDialog(
                                              title: reports.title,
                                              description: reports.description,
                                              createdAt: reports.createdAt,
                                              status: reports.status,
                                              statusDescription:
                                                  reports.statusdescription,
                                              updatedAat: reports.updatedAt,
                                            )));
                                  },
                                  child: ReportHistoryCard(
                                    controller: controller,
                                    id: reports.id,
                                    title: reports.title,
                                    description: reports.description,
                                    userId: reports.userid,
                                    subAdminId: reports.subadminid,
                                    createdAt: reports.createdAt,
                                    status: reports.status,
                                    statusDescription:
                                        reports.statusdescription,
                                    updatedAat: reports.updatedAt,
                                  ));
                            },
                          ),
                        ),
                      ),
                    ])),
              ),
            ));
  }

  Widget MyStatusWidget({required status, required color, Color? textColor}) {
    return Container(
      width: 64,
      height: 18,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4.r)),
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
    );
  }
}

class ComplaintHistoryDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final int? status;
  final String? statusDescription;
  final String? updatedAat;
  final String? createdAt;

  const ComplaintHistoryDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.status,
      required this.statusDescription,
      required this.updatedAat,
      required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 307.w,
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            "Complain History",
            style: GoogleFonts.montserrat(
              color: HexColor('#4D4D4D'),
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
        ),
        16.h.ph,
        Text(
          'Title',
          style: GoogleFonts.ubuntu(
              color: HexColor('#4D4D4D'),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
        ),
        4.h.ph,
        Text(
          title ?? "",
          style: GoogleFonts.ubuntu(
              color: HexColor('#4D4D4D'),
              fontSize: 14.sp,
              fontWeight: FontWeight.w300),
        ),
        8.h.ph,
        Text(
          'Description',
          style: GoogleFonts.ubuntu(
              color: HexColor('#4D4D4D'),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
        ),
        4.h.ph,
        Text(
          description ?? "",
          style: GoogleFonts.ubuntu(
            color: HexColor('#8D8D8D'),
            fontSize: 12.sp,
          ),
        ),
        8.h.ph,
        Text(
          'Submitted At',
          style: GoogleFonts.ubuntu(
              color: HexColor('#4D4D4D'),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
        ),
        14.h.ph,
        Row(
          children: [
            SvgPicture.asset(
              'assets/complaint_date.svg',
              width: 17.w,
              height: 17.w,
              color: HexColor('#1E2772'),
            ),
            11.w.pw,
            Text(
              DateHelper.formatDate(createdAt!) ?? "",
              style: GoogleFonts.ubuntu(
                  color: HexColor(
                    '#4D4D4D',
                  ),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300),
            ),
            11.w.pw,
            SvgPicture.asset(
              'assets/clock.svg',
              width: 17.w,
              height: 17.w,
              color: Colors.green,
            ),
            11.w.pw,
            Text(
              DateHelper.convertTo12HourFormatFromTimeStamp(createdAt!) ?? "",
              style: GoogleFonts.ubuntu(
                  color: HexColor(
                    '#4D4D4D',
                  ),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
        14.h.ph,
        Text(
          'Accepted At',
          style: GoogleFonts.ubuntu(
              color: HexColor('#4D4D4D'),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
        ),
        14.h.ph,
        Row(
          children: [
            SvgPicture.asset(
              'assets/complaint_date.svg',
              width: 17.w,
              height: 17.w,
              color: HexColor('#1E2772'),
            ),
            11.w.pw,
            Text(
              DateHelper.formatDate(updatedAat!) ?? "",
              style: GoogleFonts.ubuntu(
                  color: HexColor(
                    '#4D4D4D',
                  ),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300),
            ),
            11.w.pw,
            SvgPicture.asset(
              'assets/clock.svg',
              width: 17.w,
              height: 17.w,
              color: Colors.green,
            ),
            11.w.pw,
            Text(
              DateHelper.convertTo12HourFormatFromTimeStamp(updatedAat!) ?? "",
              style: GoogleFonts.ubuntu(
                  color: HexColor(
                    '#4D4D4D',
                  ),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
        14.h.ph,
        Row(
          children: [
            Text(
              'Status',
              style: GoogleFonts.ubuntu(
                  color: HexColor('#4D4D4D'),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
            ),
            11.w.pw,
            if (status == 3) ...[
              ComplainStatusCard(
                statusDescription: 'Rejected',
                color: HexColor('#F53932'),
              )
            ] else if (status == 4) ...[
              ComplainStatusCard(
                statusDescription: statusDescription,
                color: HexColor('#3BB651'),
              )
            ],
          ],
        ),
        14.h.ph,
        if (status == 3) ...[
          Text(
            'Reason of Rejection',
            style: GoogleFonts.ubuntu(
                color: HexColor('#4D4D4D'),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
          4.h.ph,
          Text(
            statusDescription ?? "",
            style: GoogleFonts.ubuntu(
              color: HexColor('#8D8D8D'),
              fontSize: 12.sp,
            ),
          ),
        ]
      ])),
    );
  }
}

class ComplainDialogBorderWidget extends StatelessWidget {
  final String? text;

  const ComplainDialogBorderWidget({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82.w,
      height: 25.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.r),
          border: Border.all(color: primaryColor)),
      child: Center(
        child: Text(
          text ?? "",
          style: GoogleFonts.ubuntu(
            color: HexColor('#535353'),
            fontSize: 10.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

class ReportHistoryCard extends StatelessWidget {
  final int? id;
  final int? userId;
  final int? subAdminId;
  final String? title;
  final String? description;
  final int? status;
  final String? statusDescription;
  final String? updatedAat;
  final String? createdAt;
  final ReportHistoryController controller;
  ReportHistoryCard(
      {super.key,
      required this.id,
      required this.userId,
      required this.subAdminId,
      required this.title,
      required this.description,
      required this.status,
      required this.statusDescription,
      required this.updatedAat,
      required this.createdAt,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: SizedBox(
        width: 343.w,
        height: 72.w,
        child: Card(
          color: HexColor('#FFFFFF'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
          elevation: 0.7,
          child: Column(
            children: [
              10.h.ph,
              Padding(
                padding: EdgeInsets.only(left: 13.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title ?? "",
                        style: GoogleFonts.ubuntu(
                            color: HexColor('#606470'),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 19.w),
                      child: Text(
                        DateHelper
                                .convertLaravelDateFormatToDayMonthYearDateFormat(
                                    createdAt!) ??
                            "",
                        style: GoogleFonts.inter(
                            color: HexColor('#333333'),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              6.h.ph,
              Padding(
                padding: EdgeInsets.only(left: 13.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "• $description",
                        style: GoogleFonts.ubuntu(
                          color: HexColor('#333333'),
                          fontSize: 11.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (status == 3) ...[
                      Padding(
                        padding: EdgeInsets.only(right: 19.w),
                        child: ReportHistoryCardStatus(
                          color: HexColor('#F53932'),
                          text: 'Rejected',
                        ),
                      )
                    ] else if (status == 4) ...[
                      Padding(
                        padding: EdgeInsets.only(right: 19.w),
                        child: ReportHistoryCardStatus(
                          color: HexColor('#00A61E'),
                          text: 'Completed',
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportHistoryCardStatus extends StatelessWidget {
  final String? text;
  final Color? color;

  const ReportHistoryCardStatus(
      {super.key, required this.text, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          text ?? "",
          style: GoogleFonts.ubuntu(
            color: HexColor('#FFFFFF'),
            fontSize: 10.sp,
          ),
        ),
      ),
      width: 64.w,
      height: 18.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.r), color: color!),
    );
  }
}
