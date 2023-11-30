import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Widgets/Empty%20List/empty_list.dart';
import 'package:userapp/Widgets/Loader/loader.dart';
import 'package:userapp/Widgets/My%20Back%20Button/my_back_button.dart';
import 'package:userapp/Widgets/My%20Button/my_button.dart';

import '../../../Constants/constants.dart';
import '../../../Helpers/Date Helper/date_helper.dart';
import '../../../Routes/set_routes.dart';
import '../Controller/event_screen_controller.dart';
import '../Model/Event.dart';

class EventsScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventScreenController>(
        init: EventScreenController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offNamed(homescreen, arguments: controller.userdata);
              return true;
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: HexColor('#FCFCFC'),
                body: Column(
                  children: [
                    MyBackButton(
                      text: 'Society Events',
                      onTap: () {
                        Get.offNamed(homescreen,
                            arguments: controller.userdata);
                      },
                    ),
                    Expanded(
                      child: FutureBuilder<Event>(
                          future: controller.viewEventsApi(
                              userid: controller.resident.subadminid!,
                              token: controller.userdata.bearerToken!),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data != null &&
                                  snapshot.data!.data!.length != 0) {
                                return ListView.builder(
                                    itemBuilder: (context, index) {
                                      controller.snapShot =
                                          snapshot.data!.data![index];

                                      return GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    AlertDialog(
                                                      content: EventDialog(
                                                          startTime: snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .starttime ??
                                                              "",
                                                          endTime: snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .endtime ??
                                                              "",
                                                          title: snapshot
                                                              .data!
                                                              .data![index]
                                                              .title,
                                                          startDate: snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .startdate ??
                                                              "",
                                                          endDate: snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .enddate ??
                                                              "",
                                                          description: snapshot
                                                              .data!
                                                              .data![index]
                                                              .description),
                                                    ));
                                          },
                                          child: EventCard(
                                            title: controller.snapShot.title,
                                            description:
                                                controller.snapShot.description,
                                            startDate:
                                                controller.snapShot.startdate,
                                            index: index,
                                          ));
                                    },
                                    itemCount: snapshot.data!.data!.length);
                              } else {
                                return EmptyList(name: 'No Events');
                              }
                            } else if (snapshot.hasError) {
                              return Icon(Icons.error_outline);
                            } else {
                              return Loader();
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class EventDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;

  const EventDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text("Event",
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: HexColor('#606470'))),
          ),
          14.h.ph,
          Text(
            'Title',
            style: GoogleFonts.ubuntu(
                color: HexColor('#4D4D4D'),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
          4.h.ph,
          Text(title ?? "",
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: HexColor('#606470'))),
          14.h.ph,
          Text(
            'Description',
            style: GoogleFonts.ubuntu(
                color: HexColor('#4D4D4D'),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
          4.h.ph,
          Text(description ?? "",
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: HexColor('#606470'))),
          20.h.ph,
          Row(
            children: [
              Text(
                'From',
                style: GoogleFonts.ubuntu(
                    color: HexColor(
                      '#4D4D4D',
                    ),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ),
              82.w.pw,
              Text(
                'To',
                style: GoogleFonts.ubuntu(
                    color: HexColor(
                      '#4D4D4D',
                    ),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          10.h.ph,
          Row(
            children: [
              SvgPicture.asset(
                'assets/complaint_date.svg',
                width: 17.w,
                height: 17.w,
                color: primaryColor,
              ),
              11.w.pw,
              Text(
                DateHelper.convertDateFormatToDayMonthYearDateFormat(
                        startDate!) ??
                    "",
                style: GoogleFonts.ubuntu(
                    color: HexColor(
                      '#4D4D4D',
                    ),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300),
              ),
              11.w.pw,
              SvgPicture.asset(
                'assets/complaint_date.svg',
                width: 17.w,
                height: 17.w,
                color: primaryColor,
              ),
              11.w.pw,
              Text(
                DateHelper.convertDateFormatToDayMonthYearDateFormat(
                        endDate!) ??
                    "",
                style: GoogleFonts.ubuntu(
                    color: HexColor(
                      '#4D4D4D',
                    ),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          20.h.ph,
          Row(
            children: [
              Text(
                'From',
                style: GoogleFonts.ubuntu(
                    color: HexColor(
                      '#4D4D4D',
                    ),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ),
              82.w.pw,
              Text(
                'To',
                style: GoogleFonts.ubuntu(
                    color: HexColor(
                      '#4D4D4D',
                    ),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          10.h.ph,
          Row(
            children: [
              SvgPicture.asset(
                'assets/clock.svg',
                width: 17.w,
                height: 17.w,
                color: primaryColor,
              ),
              11.w.pw,
              Text(
                DateHelper.formatTimeToAMPM(startTime!) ?? "",
                style: GoogleFonts.ubuntu(
                    color: HexColor(
                      '#4D4D4D',
                    ),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300),
              ),
              36.w.pw,
              SvgPicture.asset(
                'assets/clock.svg',
                width: 17.w,
                height: 17.w,
                color: primaryColor,
              ),
              11.w.pw,
              Text(
                DateHelper.formatTimeToAMPM(endTime!) ?? "",
                style: GoogleFonts.ubuntu(
                    color: HexColor(
                      '#4D4D4D',
                    ),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          40.h.ph,
          Center(
            child: MyButton(
              width: 300.w,
              name: 'OK',
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EventDateCard extends StatelessWidget {
  final String? dateString;

  const EventDateCard({super.key, required this.dateString});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 93.w,
      height: 18.w,
      decoration: BoxDecoration(
          color: HexColor('#E1E1E1'), borderRadius: BorderRadius.circular(4.r)),
      child: Row(
        children: [
          6.w.pw,
          SvgPicture.asset(
            'assets/event_date_icon.svg',
            width: 12.w,
            height: 12.w,
          ),
          8.w.pw,
          Text(
              DateHelper.convertDateFormatToDayMonthYearDateFormat(dateString!),
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w300,
                  fontSize: 10.sp,
                  color: HexColor('#4D4D4D')))
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? startDate;
  final int? index;

  const EventCard(
      {super.key,
      required this.title,
      required this.description,
      required this.startDate,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(14.w, 13.h, 18.w, 0),
        child: SizedBox(
            height: 96.w,
            width: 343.w,
            child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 13.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.h.ph,
                          SizedBox(
                            width: 200.w,
                            height: 20.w,
                            child: Text(
                              title ?? "",
                              style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: HexColor('#606470')),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          6.h.ph,
                          SizedBox(
                            width: 200.w,
                            child: Text(
                              description ?? "",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 11.sp, color: HexColor('#333333')),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          10.h.ph,
                          Row(
                            children: [
                              Container(
                                width: 93.w,
                                height: 18.w,
                                decoration: BoxDecoration(
                                    color: HexColor('#F6F6F6'),
                                    borderRadius: BorderRadius.circular(4.r)),
                                child: Row(
                                  children: [
                                    6.w.pw,
                                    SvgPicture.asset(
                                      'assets/event_date_icon.svg',
                                      width: 12.w,
                                      height: 12.w,
                                    ),
                                    8.w.pw,
                                    Text(
                                        DateHelper
                                            .convertDateFormatToDayMonthYearDateFormat(
                                                startDate!),
                                        style: GoogleFonts.ubuntu(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 10.sp,
                                            color: HexColor('#4D4D4D')))
                                  ],
                                ),
                              ),
                              12.w.pw,
                              // GestureDetector(
                              //   onTap: () {},
                              //   child: Container(
                              //     width: 63.w,
                              //     height: 18.w,
                              //     child: Center(
                              //       child: Text(
                              //         'View Image',
                              //         style: GoogleFonts.ubuntu(
                              //             fontSize: 8.sp,
                              //             color: HexColor('#FFFFFF')),
                              //       ),
                              //     ),
                              //     decoration: BoxDecoration(
                              //         color: primaryColor,
                              //         borderRadius: BorderRadius.circular(4.r)),
                              //   ),
                              // )
                            ],
                          ),
                          10.h.ph,
                        ],
                      ),
                    ),
                    if (index! % 2 == 0) ...[
                      Expanded(
                        child: SvgPicture.asset(
                          'assets/event_vector_2.svg',
                          width: 84.w,
                          height: 75.w,
                        ),
                      ),
                    ],
                    if (!(index! % 2 == 0)) ...[
                      Expanded(
                        child: SvgPicture.asset(
                          'assets/event_vector_1.svg',
                          width: 84.w,
                          height: 75.w,
                        ),
                      ),
                    ]
                  ],
                ))));
  }
}
