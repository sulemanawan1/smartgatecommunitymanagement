import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/Widgets/Empty%20List/empty_list.dart';

import '../../../Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/My Back Button/my_back_button.dart';
import '../../Pre Approve Entry/Model/PreApproveEntry.dart';
import '../../Pre Approve Entry/View/pre_approve_entry_screen.dart';
import '../Controller/guest_history_controller.dart';

class GuestsHistoryScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuestHistoryController>(
        init: GuestHistoryController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offNamed(homescreen, arguments: controller.userdata);
              return true;
            },
            child: SafeArea(
              child: Scaffold(
                  body: Column(children: [
                MyBackButton(
                  text: 'Guest History',
                  onTap: () {
                    Get.offNamed(homescreen, arguments: controller.userdata);
                  },
                ),
                23.h.ph,
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
                        }, itemBuilder: (context, item, index) {
                          final PreApproveEntry p = item as PreApproveEntry;
                          return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          content: PreApproveEntryDialog(
                                            name: p.name,
                                            description: p.description,
                                            arrivaldate: p.arrivaldate,
                                            arrivaltime: p.arrivaltime,
                                            cnic: p.cnic,
                                            mobileno: p.mobileno,
                                            vechileno: p.vechileno,
                                            visitortype: p.visitortype,
                                          ),
                                        ));
                              },
                              child: PreApproveEntryHistoryCard(
                                  id: p.id!,
                                  updatedAt: p.updatedAt!,
                                  checkInTime: p.checkInTime!,
                                  name: p.name!,
                                  checkOutTime: p.checkOutTime!,
                                  controller: controller));
                        })))
              ])),
            ),
          );
        });
  }

  Widget PreApproveEntryHistoryCard(
      {required String name,
      required int id,
      required String checkOutTime,
      required String updatedAt,
      required String checkInTime,
      required GuestHistoryController controller}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 13.h, 16.w, 0),
      child: SizedBox(
          width: 343.w,
          height: 67.w,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            elevation: 1,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/noticeboard_icon.png',
                    ),
                    width: 62.w,
                    height: 67.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        gradient: LinearGradient(
                            colors: (id % 2 == 0)
                                ? controller.bluecard
                                : controller.greencard)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        6.h.ph,
                        Text(
                          name,
                          style: GoogleFonts.ubuntu(
                              color: HexColor('#606470'),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        PreApproveEntryCardText(
                            heading: 'Checkin Time    :  ',
                            text: DateHelper.Hour12formatTime(checkInTime)),
                        4.h.ph,
                        PreApproveEntryCardText(
                            heading: 'Checkout Time :  ',
                            text: DateHelper.Hour12formatTime(checkOutTime)),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 89.w,
                    height: 23.w,
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
                            DateHelper
                                .convertLaravelDateFormatToDayMonthYearDateFormat(
                                    updatedAt!),
                            style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w300,
                                fontSize: 10.sp,
                                color: HexColor('#FFFFFF')))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
