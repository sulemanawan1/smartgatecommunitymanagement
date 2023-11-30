import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Constants/api_routes.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/Loader/loader.dart';
import 'package:userapp/Widgets/My%20Back%20Button/my_back_button.dart';

import '../../../Constants/constants.dart';
import '../../../Helpers/Date Helper/date_helper.dart';
import '../../../Widgets/Dialog Box Elipse Heading/dialog_box_elipse_heading.dart';
import '../../../Widgets/Empty List/empty_list.dart';
import '../../Chat Screens/Neighbour Chat Screen/Controller/neighbour_chat_screen_controller.dart';
import '../../Pre Approve Entry/View/pre_approve_entry_screen.dart';
import '../Controller/chat_availibility_controller.dart';

class ChatAvailbilityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatAvailbilityController>(
        init: ChatAvailbilityController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offNamed(homescreen, arguments: controller.userdata);
              return true;
            },
            child: Center(
              child: SafeArea(
                child: Scaffold(
                  body: Column(
                    children: [
                      MyBackButton(
                        text: 'Community Members',
                        widget: Padding(
                          padding: EdgeInsets.only(left: 78.w),
                          child: PopupMenuButton<String>(
                            color: Colors.white,
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  onTap: () {
                                    Get.defaultDialog(
                                        title: 'Chat Visibility',
                                        titleStyle: GoogleFonts.montserrat(),
                                        content: SizedBox(
                                          width: 300.w,
                                          child: Column(
                                            children: [
                                              Obx(() {
                                                return CheckboxListTile(
                                                    activeColor: primaryColor,
                                                    title: Text(
                                                      "Anonymous",
                                                      style: GoogleFonts
                                                          .montserrat(),
                                                    ),
                                                    value: controller
                                                        .chatAvailibilityStatus
                                                        .value,
                                                    onChanged: (val) {
                                                      controller
                                                          .chatAvailibilityStatus
                                                          .value = val!;

                                                      if (controller
                                                              .chatAvailibilityStatus ==
                                                          false) {
                                                        controller.visibility =
                                                            "none";
                                                      } else {
                                                        controller.visibility =
                                                            "anonymous";
                                                      }

                                                      controller
                                                          .updateChatVisibilityApi(
                                                              residentId:
                                                                  controller
                                                                      .userdata
                                                                      .userId,
                                                              token: controller
                                                                  .userdata
                                                                  .bearerToken!,
                                                              visibility:
                                                                  controller
                                                                      .visibility);
                                                    });
                                              }),
                                            ],
                                          ),
                                        ));
                                  },
                                  value: 'Visibility',
                                  child: Text('Visibility'),
                                ),
                              ];
                            },
                          ),
                        ),
                        onTap: () {
                          Get.offNamed(homescreen,
                              arguments: controller.userdata);
                        },
                      ),
                      20.h.ph,
                      Expanded(
                        child: FutureBuilder(
                            future: controller.futureChatNeighboursData,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.data.length > 1) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return (snapshot.data.data[index]
                                                  .residentid ==
                                              controller.userdata.userId)
                                          ? Container()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                                content:
                                                                    SizedBox(
                                                                  height: 400.w,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageBuilder: (context, imageProvider) =>
                                                                              Container(
                                                                            width:
                                                                                100.w,
                                                                            height:
                                                                                100.w,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                                                                            ),
                                                                          ),
                                                                          imageUrl:
                                                                              Api.imageBaseUrl + snapshot.data.data[index].image.toString(),
                                                                          placeholder: (context, url) =>
                                                                              CircularProgressIndicator(
                                                                            color:
                                                                                primaryColor,
                                                                          ),
                                                                          errorWidget: (context, url, error) =>
                                                                              Container(
                                                                            width:
                                                                                80.w,
                                                                            height:
                                                                                80.w,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: primaryColor,
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      23.33
                                                                          .h
                                                                          .ph,
                                                                      Center(
                                                                        child: Text(
                                                                            "${snapshot.data!.data[index].firstname.toString()} ${snapshot.data!.data[index].lastname.toString()}",
                                                                            style:
                                                                                GoogleFonts.montserrat(
                                                                              color: HexColor("#4D4D4D"),
                                                                              fontSize: 18.sp,
                                                                              fontWeight: FontWeight.w700,
                                                                            )),
                                                                      ),
                                                                      23.33
                                                                          .h
                                                                          .ph,
                                                                      DialogBoxElipseHeading(
                                                                          text:
                                                                              'Property Type'),
                                                                      DialogBoxText(
                                                                        text: snapshot.data!.data[index].propertytype.toString() ??
                                                                            "",
                                                                      ),
                                                                      23.33
                                                                          .h
                                                                          .ph,
                                                                      DialogBoxElipseHeading(
                                                                          text:
                                                                              'Role'),
                                                                      DialogBoxText(
                                                                        text: snapshot.data!.data[index].rolename.toString() ??
                                                                            "",
                                                                      ),
                                                                      23.33
                                                                          .h
                                                                          .ph,
                                                                      DialogBoxElipseHeading(
                                                                          text:
                                                                              'Join at'),
                                                                      DialogBoxText(
                                                                        text: DateHelper.laravelDateToFormattedDate(snapshot.data!.data[index].createdAt.toString()) ??
                                                                            "",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                },
                                                leading: CachedNetworkImage(
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    width: 80.w,
                                                    height: 80.w,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.contain),
                                                    ),
                                                  ),
                                                  imageUrl: Api.imageBaseUrl +
                                                      snapshot.data.data[index]
                                                          .image
                                                          .toString(),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(
                                                    color: primaryColor,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
                                                    width: 80.w,
                                                    height: 80.w,
                                                    decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                title: Text(
                                                    snapshot.data.data[index]
                                                            .firstname +
                                                        ' ' +
                                                        snapshot
                                                            .data
                                                            .data[index]
                                                            .lastname,
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            color: HexColor(
                                                                '#0D0B0C'),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                trailing: IconButton(
                                                  color: (snapshot
                                                              .data
                                                              .data[index]
                                                              .visibility ==
                                                          'anonymous')
                                                      ? Colors.grey
                                                      : primaryColor,
                                                  onPressed: () async {
                                                    if (snapshot
                                                            .data
                                                            .data[index]
                                                            .visibility ==
                                                        'anonymous') {
                                                      myToast(
                                                          msg:
                                                              "You can't chat with this user because their chat privacy is set to private");
                                                    } else {
                                                      final chatRoomModel = await controller
                                                          .createChatRoomApi(
                                                              token: controller
                                                                  .userdata
                                                                  .bearerToken!,
                                                              userid: controller
                                                                  .userdata
                                                                  .userId!,
                                                              chatUserId: snapshot
                                                                  .data
                                                                  .data[index]
                                                                  .residentid);

                                                      Get.offNamed(
                                                          neighbourchatscreen,
                                                          arguments: [
                                                            controller.userdata,
                                                            //Login User
                                                            controller.resident,
                                                            // Resident Details
                                                            snapshot.data
                                                                .data[index],

                                                            // chat room id
                                                            chatRoomModel
                                                                .data!.first.id,
                                                            ChatTypes.NeighbourChat
                                                                    .toString()
                                                                .split('.')
                                                                .last,
                                                            // Chat User
                                                          ]);
                                                    }
                                                  },
                                                  icon: Icon(Icons
                                                      .chat_bubble_outlined),
                                                ),
                                              ));
                                    },
                                  );
                                } else {
                                  return EmptyList(
                                    name: 'No Neighbour Exists.',
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
                  ),
                ),
              ),
            ),
          );
        });
  }
}
