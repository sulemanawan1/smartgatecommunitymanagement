import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/Widgets/Loader/loader.dart';

import '../../../Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/Empty List/empty_list.dart';
import '../../../Widgets/My Back Button/my_back_button.dart';
import '../../../Widgets/My Button/my_button.dart';
import '../Controller/discussion_form_controller.dart';

class DiscussionForm extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscussionFormController>(
        init: DiscussionFormController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              await Get.offAllNamed(homescreen, arguments: controller.user);
              return true;
            },
            child: SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    MyBackButton(
                      widget: Padding(
                        padding: EdgeInsets.only(left: 89.w),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                        content: SizedBox(
                                      width: 347.w,
                                      child: SingleChildScrollView(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                            SvgPicture.asset(
                                              'assets/discussion_forum_vector.svg',
                                              width: 200.w,
                                            ),
                                            30.h.ph,
                                            Text(
                                              'Discussion Forum is a vibrant space for community members to engage in meaningful conversations about pressing societal issues and explore avenues for positive change. Within this module, you can connect with like-minded individuals who share your passion for making the world a better place.' ??
                                                  "",
                                              style: GoogleFonts.ubuntu(
                                                color: HexColor('#4D4D4D'),
                                                fontSize: 12.sp,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            30.h.ph,
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
                                          ])),
                                    )));
                          },
                          icon: Icon(
                            Icons.announcement,
                            color: Colors.white,
                            size: 18.w,
                          ),
                        ),
                      ),
                      text: 'Discussion Forum',
                      onTap: () {
                        Get.offAllNamed(homescreen, arguments: controller.user);
                      },
                    ),
                    Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('discussionchats')
                              .where('discussionroomid',
                                  isEqualTo: controller
                                      .discussionRoomModel.data?.first.id)
                              .orderBy('timestamp', descending: true)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              var data = snapshot.data!.docs;

                              if (data.length == 0) {
                                return EmptyList(
                                    name:
                                        "Join the discussion Forum 😊 \n and share your thoughts with the community.");
                              }
                              return ListView.builder(
                                reverse: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  bool isSameDate = false;
                                  String newDate = '';

                                  if (index == 0 && data.length == 1) {
                                    newDate =
                                        DateHelper.groupMessageDateAndTime(
                                                data![index]['timestamp']
                                                    .toString())
                                            .toString();
                                  } else if (index == data.length - 1) {
                                    newDate =
                                        DateHelper.groupMessageDateAndTime(
                                                data![index]['timestamp']
                                                    .toString())
                                            .toString();
                                  } else {
                                    final DateTime date =
                                        DateHelper.returnDateAndTimeFormat(
                                            data![index + 1]['timestamp']
                                                .toString());

                                    final DateTime prevDate =
                                        DateHelper.returnDateAndTimeFormat(
                                            data![index]['timestamp']
                                                .toString());

                                    isSameDate =
                                        date.isAtSameMomentAs(prevDate);

                                    if (kDebugMode) {
                                      print("$date $prevDate $isSameDate");
                                    }

                                    newDate = isSameDate
                                        ? ''
                                        : DateHelper.groupMessageDateAndTime(
                                                data[index]['timestamp']
                                                    .toString())
                                            .toString();
                                  }
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Column(
                                      crossAxisAlignment: data[index]
                                                  ['residentid']! ==
                                              controller.user.userId
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        if (newDate.isNotEmpty)
                                          Center(
                                              child: Column(
                                            children: [
                                              10.h.ph,
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[100],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(newDate),
                                                  )),
                                            ],
                                          )),
                                        Container(
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 10.w,
                                                right: 10.w,
                                              ),
                                              child: Column(
                                                children: [
                                                  10.h.ph,
                                                  data[index]['residentid']! ==
                                                          controller.user.userId
                                                      ? SizedBox()
                                                      : Text(
                                                          data![index]['user']
                                                                  ['username']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: Colors
                                                                  .indigo),
                                                        ),
                                                  Text(
                                                    data![index]['message']
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      letterSpacing: 0.4,
                                                      color: data[index][
                                                                  'residentid']! ==
                                                              controller
                                                                  .user.userId
                                                          ? Colors.black
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  4.h.ph,
                                                  Text(
                                                    DateHelper.messageTime(
                                                        data![index]
                                                                ['timestamp']
                                                            .toString()),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 10.sp,
                                                        color: Colors.black),
                                                  ),
                                                  4.h.ph,
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                              )),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              color: data[index]
                                                          ['residentid']! ==
                                                      controller.user.userId
                                                  ? Colors.orange[100]
                                                  : Colors.blue[100]),
                                          margin: EdgeInsets.all(4),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.active) {
                              return Loader();
                            } else {
                              return Loader();
                            }
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: Row(
                        children: [
                          7.w.pw,
                          // SvgPicture.asset(
                          //   'assets/chat_plus.svg',
                          //   width: 24.w,
                          //   height: 24.w,
                          // ),
                          SizedBox(
                            width: 24.w,
                            height: 24.w,
                          ),
                          7.w.pw,
                          SizedBox(
                            width: 292.w,
                            height: 52.w,
                            child: TextFormField(
                              maxLines: null,
                              controller: controller.msg,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: 16.13.w,
                                  ),
                                  // suffixIconConstraints:
                                  //     BoxConstraints(maxHeight: 14),
                                  // suffixIcon: SvgPicture.asset(
                                  //   'assets/chat_smile.svg',
                                  //   width: 24.w,
                                  //   fit: BoxFit.contain,
                                  // ),
                                  hintText: "Type your message",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('#D0D0D0')),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor('#B8B8B8')),
                                      borderRadius: BorderRadius.circular(8.r)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor('#B8B8B8')),
                                      borderRadius:
                                          BorderRadius.circular(8.r))),
                            ),
                          ),
                          7.w.pw,
                          GestureDetector(
                            onTap: () {
                              if (controller.msg.text.isNotEmpty) {
                                try {
                                  // Get a reference to the Firestore collection
                                  CollectionReference chats = FirebaseFirestore
                                      .instance
                                      .collection('discussionchats');

                                  var user = {
                                    'firstname': controller.user.firstName,
                                    'lastname': controller.user.lastName,
                                    'username': controller.resident.username,
                                    'address': controller.user.address,
                                    'rolename': controller.user.roleName,
                                    'roleid': controller.user.roleId,
                                  };
                                  // Add a new document with a generated ID
                                  chats.add({
                                    'residentid':
                                        controller.resident.residentid!,
                                    'message': controller.msg.text,
                                    'discussionroomid': controller
                                        .discussionRoomModel?.data?.first.id,
                                    'timestamp':
                                        DateTime.now().microsecondsSinceEpoch,
                                    'user': user,
                                    'type': 'message',
                                  });

                                  controller.msg.clear();
                                  print('Data added successfully');
                                } catch (error) {
                                  print('Error adding data: $error');
                                }
                              }
                            },
                            child: SvgPicture.asset("assets/chat_send.svg",
                                width: 24.w, height: 24.w),
                          ),
                          5.22.w.pw
                        ],
                      ),
                    ),
                    10.h.ph,
                    Center(
                      child: Container(
                          width: 134.w,
                          height: 5.w,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(100.r))),
                    ),
                    8.h.ph,
                  ],
                ),
              ),
            ),
          );
        });
  }
}
