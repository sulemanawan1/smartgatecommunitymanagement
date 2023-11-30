import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Module/Report%20to%20Sub%20Admin/Controller/Admin%20Reports%20Controller/admin_reports_controller.dart';
import 'package:userapp/Module/Report%20to%20Sub%20Admin/Model/Reports.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/Empty%20List/empty_list.dart';
import 'package:userapp/Widgets/My%20Back%20Button/my_back_button.dart';
import 'package:userapp/Widgets/My%20Button/my_button.dart';
import 'package:userapp/Widgets/My%20Floating%20Action%20Button/my_floating_action_button.dart';

import '../../../../Helpers/Date Helper/date_helper.dart';

class AdminReports extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminReportsController>(
      init: AdminReportsController(),
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          Get.offNamed(homescreen, arguments: controller.user);

          return true;
        },
        child: SafeArea(
          child: Scaffold(
              body: Column(
                children: [
                  MyBackButton(
                    text: 'Complaint',
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
                            name: 'No Complains',
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
                                          content: ComplaintDialog(
                                            userId: reports.userid,
                                            statusDescription:
                                                reports.statusdescription,
                                            status: reports.status,
                                            index: index,
                                            id: reports.id,
                                            controller: controller,
                                            title: reports.title,
                                            description: reports.description,
                                            updatedAt: reports.updatedAt,
                                            createdAt: reports.createdAt,
                                            dialogTitle: 'Complaint',
                                          ),
                                        ));
                              },
                              child: ComplainCard(
                                index: index,
                                controller: controller,
                                id: reports.id,
                                title: reports.title,
                                description: reports.description,
                                userId: reports.userid,
                                subAdminId: reports.subadminid,
                                createdAt: reports.createdAt,
                                status: reports.status,
                                statusDescription: reports.statusdescription,
                                updatedAat: reports.updatedAt,
                              ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: MyFloatingActionButton(
                onPressed: () {
                  Get.offNamed(reporttoadmin,
                      arguments: [controller.user, controller.resident]);
                },
              )),
        ),
      ),
    );
  }
}

class ComplaintDialog extends StatelessWidget {
  final String? dialogTitle;
  final String? title;
  final String? description;
  final String? updatedAt;
  final String? createdAt;
  final int? index;
  final int? id;
  final int? userId;
  final int? status;
  final String? statusDescription;
  final AdminReportsController controller;

  ComplaintDialog(
      {super.key,
      required this.status,
      required this.statusDescription,
      required this.title,
      required this.userId,
      required this.description,
      required this.updatedAt,
      required this.createdAt,
      required this.controller,
      required this.index,
      required this.id,
      this.dialogTitle});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              dialogTitle ?? "",
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
                DateHelper.formatDate(updatedAt!) ?? "",
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
                DateHelper.convertTo12HourFormatFromTimeStamp(updatedAt!) ?? "",
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
              if (status == 0) ...[
                ComplainStatusCard(
                  statusDescription: statusDescription,
                  color: HexColor('#ED0909'),
                )
              ] else if (status == 2) ...[
                ComplainStatusCard(
                  statusDescription: statusDescription,
                  color: HexColor('#4EC018'),
                )
              ],
            ],
          ),
          80.h.ph,
          if (status == 2) ...[
            Center(
              child: MyButton(
                width: 300.w,
                color: Colors.green.shade700,
                name: 'Problem Solved',
                onPressed: () {
                  Get.defaultDialog(
                    title: '',
                    titlePadding: EdgeInsets.zero,
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          if (!controller.isLoading) {
                            controller.ProblemSolvedButtonApi(
                                id: id!,
                                token: controller.user.bearerToken!,
                                userId: userId!,
                                index: index!);
                          } else {
                            Get.back();
                          }
                        },
                        child: Container(
                          width: 80.w,
                          height: 25.w,
                          child: controller.isSolved
                              ? CircularProgressIndicator()
                              : Center(
                                  child: Text(
                                    'Yes',
                                    style: GoogleFonts.ubuntu(
                                      color: HexColor(
                                        '#FFFFFF',
                                      ),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                          decoration: BoxDecoration(
                              color: HexColor('#5AE244'),
                              borderRadius: BorderRadius.circular(4.r)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 80.w,
                          height: 25.w,
                          child: Center(
                            child: Text(
                              'No',
                              style: GoogleFonts.ubuntu(
                                color: HexColor(
                                  '#FFFFFF',
                                ),
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: HexColor('#FF3232'),
                              borderRadius: BorderRadius.circular(4.r)),
                        ),
                      ),
                    ],
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        16.h.ph,
                        SvgPicture.asset(
                            'assets/complaint_problem _solved_icon.svg'),
                        11.h.ph,
                        Text(
                          'Complaint',
                          style: GoogleFonts.montserrat(
                              color: HexColor(
                                '#4D4D4D',
                              ),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        16.h.ph,
                        Text(
                          'Has your Problem been Resolved ?',
                          style: GoogleFonts.ubuntu(
                            color: HexColor(
                              '#4D4D4D',
                            ),
                            fontSize: 14.sp,
                          ),
                        ),
                        20.h.ph
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ],
      ),
    );
  }
}

class ComplainCard extends StatelessWidget {
  final int? id;
  final int? index;
  final int? userId;
  final int? subAdminId;
  final String? title;
  final String? description;
  final int? status;
  final String? statusDescription;
  final String? updatedAat;
  final String? createdAt;
  final AdminReportsController controller;

  const ComplainCard(
      {super.key,
      required this.id,
      required this.index,
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
      child: SizedBox(
        width: 343.w,
        height: 102.w,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Text(
                        title ?? "",
                        style: GoogleFonts.ubuntu(
                            color: HexColor('#A5AAB7'),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: SvgPicture.asset('assets/complaint_cardbg.svg'),
                  ),
                ],
              ),
              6.h.ph,
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.w),
                        child: Text(
                          description ?? "",
                          style: GoogleFonts.ubuntu(
                              color: HexColor('#606470'),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    if (status == 0) ...[
                      ComplainStatusCard(
                        statusDescription: statusDescription,
                        color: HexColor('#ED0909'),
                      )
                    ] else if (status == 2) ...[
                      ComplainStatusCard(
                        statusDescription: statusDescription,
                        color: HexColor('#4EC018'),
                      )
                    ]
                  ],
                ),
              ),
              18.h.ph,
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: SvgPicture.asset('assets/complaint_date.svg'),
                        ),
                        6.w.pw,
                        Text(
                          DateHelper.formatDate(updatedAat!) +
                                  "  " +
                                  DateHelper.convertTo12HourFormatFromTimeStamp(
                                      updatedAat!) ??
                              "03 April,2022",
                          style: GoogleFonts.ubuntu(
                              color: HexColor(
                                '#A5AAB7',
                              ),
                              fontSize: 10.sp),
                        )
                      ],
                    ),
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

class ComplainStatusCard extends StatelessWidget {
  final String? statusDescription;
  final Color? color;

  const ComplainStatusCard(
      {super.key, required this.statusDescription, required this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 22.w),
      child: Container(
        child: Center(
            child: Text(
          statusDescription!,
          style:
              GoogleFonts.ubuntu(color: HexColor('#FFFFFF'), fontSize: 10.sp),
        )),
        width: 63.w,
        height: 22.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r), color: color),
      ),
    );
  }
}
