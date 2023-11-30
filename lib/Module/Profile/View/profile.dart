import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Module/Profile/Controller/profile_controller.dart';
import 'package:userapp/Widgets/My%20Button/my_button.dart';

import '../../../Constants/api_routes.dart';
import '../../../Constants/constants.dart';
import '../../../Helpers/Date Helper/date_helper.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/My Back Button/my_back_button.dart';
import '../../Chat Screens/Neighbour Chat Screen/Controller/neighbour_chat_screen_controller.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              await Get.offNamed(neighbourchatscreen, arguments: [
                controller.userdata,
                //Login User
                controller.resident,
                // Resident Details
                controller.chatNeighbours,
                controller.chatRoomId,
                ChatTypes.NeighbourChat.toString().split('.').last,
                // Chat User
              ]);

              return false;
            },
            child: SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    MyBackButton(
                        text: 'Profile',
                        onTap: () {
                          if (controller.chatType == "NeighbourChat") {
                            Get.offNamed(neighbourchatscreen, arguments: [
                              controller.userdata,
                              //Login User
                              controller.resident,
                              // Resident Details
                              controller.chatNeighbours,
                              controller.chatRoomId,
                              ChatTypes.NeighbourChat.toString()
                                  .split('.')
                                  .last,
                              // Chat User
                            ]);
                          } else if (controller.chatType == "MarketPlaceChat") {
                            Get.offNamed(neighbourchatscreen, arguments: [
                              controller.userdata,
                              //Login User
                              controller.resident,
                              // Resident Details
                              controller.chatNeighbours,
                              // chat room id
                              controller.chatRoomId,
                              ChatTypes.MarketPlaceChat.toString()
                                  .split('.')
                                  .last, // Chat User
                            ]);
                          }
                        }),
                    20.h.ph,
                    CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                            width: 200.w,
                            height: 200.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: primaryColor),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain),
                            )),
                        imageUrl: Api.imageBaseUrl +
                            controller.chatNeighbours.image.toString(),
                        placeholder: (context, url) => Column(
                              children: [
                                CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              ],
                            ),
                        errorWidget: (context, url, error) => Container(
                            width: 200.w,
                            height: 200.w,
                            child: Icon(Icons.error),
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              shape: BoxShape.circle,
                            ))),
                    20.h.ph,
                    Text(
                      "${controller.chatNeighbours.firstname.toString()} ${controller.chatNeighbours.lastname.toString()}",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, top: 10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.verified_user,
                            color: Colors.deepPurple,
                          ),
                          5.w.pw,
                          Text(
                            "Joined At",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          5.w.pw,
                          Text(
                            "${DateHelper.laravelDateToFormattedDate(controller.chatNeighbours.createdAt.toString())}",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, top: 10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.deepPurple,
                          ),
                          5.w.pw,
                          Text(
                            "Username",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          5.w.pw,
                          Text(
                            "${controller.chatNeighbours.username}",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, top: 10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.home_work,
                            color: Colors.deepPurple,
                          ),
                          5.w.pw,
                          Text(
                            "Property Type",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          5.w.pw,
                          Text(
                            "${controller.chatNeighbours.propertytype}",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, top: 10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_history_rounded,
                            color: Colors.deepPurple,
                          ),
                          5.w.pw,
                          Text(
                            "Residental Type",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          5.w.pw,
                          Text(
                            "${controller.chatNeighbours.residenttype}",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.h.ph,
                    if (controller.isLoading == false) ...[
                      if (controller.blockedUser.data == null) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: MyButton(
                            width: double.infinity,
                            color: primaryColor,
                            name: 'Block',
                            loading: controller.isLoading,
                            onPressed: () {
                              if (!controller.isLoading) {
                                controller.blockUserApi(
                                    userId: controller.userdata.userId,
                                    token: controller.userdata.bearerToken!,
                                    chatRoomId: controller.chatRoomId,
                                    blockedUserid:
                                        controller.chatNeighbours.residentid);
                              }
                            },
                          ),
                        ),
                      ] else if (controller.blockedUser.data!.blockeduserid ==
                          controller.userdata.userId) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: MyButton(
                            width: double.infinity,
                            color: Colors.blue,
                            name: 'Block',
                            loading: controller.isLoading,
                            onPressed: () {
                              if (!controller.isLoading) {
                                controller.blockUserApi(
                                    userId: controller.userdata.userId,
                                    token: controller.userdata.bearerToken!,
                                    chatRoomId: controller.chatRoomId,
                                    blockedUserid:
                                        controller.chatNeighbours.residentid);
                              }
                            },
                          ),
                        ),
                      ] else if (controller.blockedUser.data!.userid ==
                          controller.userdata.userId) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: MyButton(
                            width: double.infinity,
                            name: 'Unblock',
                            onPressed: () {
                              controller.unBlockUserApi(
                                  token: controller.userdata.bearerToken!,
                                  chatRoomId: controller.chatRoomId,
                                  blockedUserid: controller
                                      .blockedUser.data!.blockeduserid);
                            },
                          ),
                        )
                      ]
                    ],
                    30.h.ph,
                  ],
                ),
              ),
            ),
          );
        });
  }
}
