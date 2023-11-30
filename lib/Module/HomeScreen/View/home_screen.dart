import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconly/iconly.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Module/HomeScreen/Controller/home_screen_controller.dart';

import '../../../Routes/set_routes.dart';
import '../../../Widgets/My Button/my_button.dart';
import '../../../Widgets/My TextForm Field/my_textform_field.dart';
import '../Home Widgets/first_card.dart';
import '../Home Widgets/home_bottom_app_bar_icon.dart';
import '../Home Widgets/home_screen_text_heading.dart';
import '../Home Widgets/services_cards.dart';
import '../Home Widgets/small_card.dart';
import '../Model/DiscussionRoomModel.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();
final _key = GlobalKey<FormState>();

class HomeScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (homeScreenController) {
          return SafeArea(
              child: Scaffold(
            key: _scaffoldKey,
            endDrawer: MyDrawer(),
            body: FutureBuilder(
                future: homeScreenController.future,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    homeScreenController.snapShot = snapshot.data;
                    print(homeScreenController.snapShot.username);

                    if (homeScreenController.snapShot.username == null) {
                      return Form(
                        key: _key,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              10.h.ph,
                              Text('Your Identity on Smart Gate',
                                  style: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 32,
                                      color: HexColor('#4D4D4D'))),
                              20.h.ph,
                              Text('Create Your Unique Username',
                                  style: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 28,
                                      color: HexColor('#717171'))),
                              MyTextFormField(
                                hintText: 'User Name',
                                labelText: 'User Name',
                                controller:
                                    homeScreenController.userNameController,
                                validator:
                                    ValidationHelper().emptyStringValidator,
                              ),
                              20.h.ph,
                              MyButton(
                                loading: homeScreenController.isLoading,
                                name: 'Create',
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    if (!homeScreenController.isLoading) {
                                      homeScreenController.updateUserNameApi();
                                    }
                                  }
                                },
                              ),
                              20.h.ph,
                            ],
                          ),
                        ),
                      );
                    } else if (homeScreenController.snapShot.username != null &&
                        homeScreenController.snapShot.status == 0) {
                      return HomeVerificationCard();
                    } else if (homeScreenController.snapShot.username != null &&
                        homeScreenController.snapShot.status == 1) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            8.h.ph,
                            Padding(
                              padding: EdgeInsets.fromLTRB(24.w, 0, 26.w, 0),
                              child: SizedBox(
                                width: 375.w,
                                height: 72.w,
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            "Welcome Home, ${homeScreenController?.user.firstName} ${homeScreenController?.user.lastName} ",
                                            maxLines: 2,
                                            style: GoogleFonts.ubuntu(
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff130F26))),
                                      ),
                                      20.w.pw,
                                      GestureDetector(
                                        onTap: () {
                                          _scaffoldKey.currentState!
                                              .openEndDrawer();
                                        },
                                        child: Stack(children: [
                                          Container(
                                            width: 54.w,
                                            height: 54.w,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                  'assets/user.png',
                                                ))),
                                          ),
                                          Positioned(
                                            left: 40.w,
                                            top: 2.h,
                                            child: Container(
                                              height: 12.w,
                                              width: 12.w,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            16.h.ph,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: homeScreenController.pageController,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FirstCard(),
                                    8.w.pw,
                                    FirstCard(),
                                    8.w.pw,
                                    FirstCard(),
                                  ],
                                ),
                              ),
                            ),
                            16.h.ph,
                            Center(
                              child: SmoothPageIndicator(
                                controller: homeScreenController.pageController,
                                count: 3,
                                effect: ExpandingDotsEffect(
                                    dotWidth: 7.w,
                                    dotHeight: 7.w,
                                    dotColor:
                                        Color(0xffFF9900).withOpacity(0.3),
                                    activeDotColor: Color(0xffFF9900)),
                              ),
                            ),
                            16.h.ph,
                            Column(
                              children: [
                                SingleChildScrollView(
                                  padding:
                                      EdgeInsets.only(left: 30.w, bottom: 22.h),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    for (int i = 0;
                                        i <
                                            homeScreenController
                                                .quickActions.length;
                                        i++) ...[
                                      SmallCard(
                                        onTap: () {
                                          switch (homeScreenController
                                              .quickActions[i].text) {
                                            case 'Guest':
                                              Get.offNamed(
                                                  addpreapproveentryscreen,
                                                  arguments: [
                                                    homeScreenController.user,
                                                    homeScreenController
                                                        .snapShot,
                                                    0
                                                  ]);

                                              break;

                                            case 'Delivery':
                                              Get.offNamed(
                                                  addpreapproveentryscreen,
                                                  arguments: [
                                                    homeScreenController.user,
                                                    homeScreenController
                                                        .snapShot,
                                                    1
                                                  ]);
                                              break;
                                            case 'Cab':
                                              Get.offNamed(
                                                  addpreapproveentryscreen,
                                                  arguments: [
                                                    homeScreenController.user,
                                                    homeScreenController
                                                        .snapShot,
                                                    2
                                                  ]);
                                              break;

                                            case 'Visiting Help':
                                              Get.offNamed(
                                                  addpreapproveentryscreen,
                                                  arguments: [
                                                    homeScreenController.user,
                                                    homeScreenController
                                                        .snapShot,
                                                    3
                                                  ]);
                                              break;
                                          }
                                        },
                                        text: homeScreenController
                                            .quickActions[i].text,
                                        iconPath: homeScreenController
                                            .quickActions[i].iconPath,
                                        iconWidth: homeScreenController
                                            .quickActions[i].width,
                                      ),
                                      13.w.pw
                                    ]
                                  ]),
                                ),
                              ],
                            ),
                            HomeHeading(text: 'Services'),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(28.w, 0, 0, 0),
                                child: Row(children: [
                                  for (int i = 0;
                                      i <
                                          homeScreenController
                                              .servicesLi.length;
                                      i++) ...[
                                    ServiceCards(
                                        description: homeScreenController
                                            .servicesLi[i].description,
                                        heading: homeScreenController
                                            .servicesLi[i].heading,
                                        iconPath: homeScreenController
                                            .servicesLi[i].iconPath,
                                        onTap: () {
                                          if (homeScreenController
                                                  .servicesLi[i].type! ==
                                              "Complaints") {
                                            Get.offNamed(adminreports,
                                                arguments: [
                                                  homeScreenController.user,
                                                  homeScreenController.snapShot
                                                ]);
                                          } else if (homeScreenController
                                                  .servicesLi[i].type! ==
                                              "PreApproveEntry") {
                                            Get.offNamed(preapproveentryscreen,
                                                arguments: [
                                                  homeScreenController.user,
                                                  homeScreenController.snapShot
                                                ]);
                                          }
                                        }),
                                    28.w.pw
                                  ]
                                ]),
                              ),
                            ),
                            HomeHeading(text: 'Events'),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(28.w, 0, 0, 0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i <
                                              homeScreenController
                                                  .eventsLi.length;
                                          i++) ...[
                                        ServiceCards(
                                            description: homeScreenController
                                                .eventsLi[i].description,
                                            heading: homeScreenController
                                                .eventsLi[i].heading,
                                            iconPath: homeScreenController
                                                .eventsLi[i].iconPath,
                                            onTap: () {
                                              if (homeScreenController
                                                      .eventsLi[i].type ==
                                                  'Events') {
                                                Get.offNamed(eventsscreen,
                                                    arguments: [
                                                      homeScreenController.user,
                                                      homeScreenController
                                                          .snapShot
                                                    ]);
                                              } else if (homeScreenController
                                                      .eventsLi[i].type ==
                                                  'NoticeBoard') {
                                                Get.offNamed(noticeboardscreen,
                                                    arguments: [
                                                      homeScreenController.user,
                                                      homeScreenController
                                                          .snapShot
                                                    ]);
                                              }
                                            }),
                                        28.w.pw
                                      ],
                                    ]),
                              ),
                            ),
                            HomeHeading(text: 'Conversations'),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(28.w, 0, 0, 0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i <
                                              homeScreenController
                                                  .conversationLi.length;
                                          i++) ...[
                                        ServiceCards(
                                            description: homeScreenController
                                                .conversationLi[i].description,
                                            heading: homeScreenController
                                                .conversationLi[i].heading,
                                            iconPath: homeScreenController
                                                .conversationLi[i].iconPath,
                                            onTap: () async {
                                              if (homeScreenController
                                                      .conversationLi[i].type ==
                                                  'NeighboursChats') {
                                                Get.offNamed(
                                                    chatavailbilityscreen,
                                                    arguments: [
                                                      homeScreenController.user,
                                                      homeScreenController
                                                          .snapShot
                                                    ]);
                                              } else if (homeScreenController
                                                      .conversationLi[i].type ==
                                                  'DiscussionForum') {
                                                DiscussionRoomModel
                                                    discussionRoomModel =
                                                    await homeScreenController
                                                        .createChatRoomApi(
                                                            token:
                                                                homeScreenController
                                                                    .user
                                                                    .bearerToken!,
                                                            subadminid:
                                                                homeScreenController
                                                                    .snapShot
                                                                    .subadminid);
                                                Get.offNamed(discussion_form,
                                                    arguments: [
                                                      homeScreenController.user,
                                                      homeScreenController
                                                          .snapShot,
                                                      discussionRoomModel
                                                    ]);
                                              }
                                            }),
                                        28.w.pw
                                      ],
                                    ]),
                              ),
                            ),
                            HomeHeading(text: 'Life Style Solutions'),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(28.w, 0, 0, 0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i <
                                              homeScreenController
                                                  .lifeStyleSolutionsLi.length;
                                          i++) ...[
                                        ServiceCards(
                                            description: homeScreenController
                                                .lifeStyleSolutionsLi[i]
                                                .description,
                                            heading: homeScreenController
                                                .lifeStyleSolutionsLi[i]
                                                .heading,
                                            iconPath: homeScreenController
                                                .lifeStyleSolutionsLi[i]
                                                .iconPath,
                                            onTap: () {
                                              if (homeScreenController
                                                      .lifeStyleSolutionsLi[i]
                                                      .type ==
                                                  'FamilyMembers') {
                                                if (homeScreenController
                                                        .user.roleId ==
                                                    5) {
                                                  myToast(
                                                      msg:
                                                          'You have registered yourself as a family member, so you cannot add a new family member');
                                                } else {
                                                  Get.offNamed(viewfamilymember,
                                                      arguments: [
                                                        homeScreenController
                                                            .user,
                                                        homeScreenController
                                                            .snapShot
                                                      ]);
                                                }
                                              } else if (homeScreenController
                                                      .lifeStyleSolutionsLi[i]
                                                      .type ==
                                                  'MarketPlace') {
                                                Get.offNamed(marketPlaceScreen,
                                                    arguments: [
                                                      homeScreenController.user,
                                                      homeScreenController
                                                          .snapShot
                                                    ]);
                                              }
                                            }),
                                        28.w.pw
                                      ],
                                    ]),
                              ),
                            ),
                            HomeHeading(text: 'Safety Assistance'),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(28.w, 0, 0, 0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i <
                                              homeScreenController
                                                  .safetyAssistanceLi.length;
                                          i++) ...[
                                        ServiceCards(
                                            description: homeScreenController
                                                .safetyAssistanceLi[i]
                                                .description,
                                            heading: homeScreenController
                                                .safetyAssistanceLi[i].heading,
                                            iconPath: homeScreenController
                                                .safetyAssistanceLi[i].iconPath,
                                            onTap: () {
                                              if (homeScreenController
                                                      .safetyAssistanceLi[i]
                                                      .type ==
                                                  'SafetyAssistance') {
                                                Get.offNamed(addEmergencyScreen,
                                                    arguments: [
                                                      homeScreenController.user,
                                                      homeScreenController
                                                          .snapShot
                                                    ]);
                                              }
                                            }),
                                        28.w.pw
                                      ],
                                    ]),
                              ),
                            ),
                            HomeHeading(text: 'Histories'),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(28.w, 0, 0, 0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i <
                                              homeScreenController
                                                  .historyLi.length;
                                          i++) ...[
                                        ServiceCards(
                                            description: homeScreenController
                                                .historyLi[i].description,
                                            heading: homeScreenController
                                                .historyLi[i].heading,
                                            iconPath: homeScreenController
                                                .historyLi[i].iconPath,
                                            onTap: () {
                                              if (homeScreenController
                                                      .historyLi[i].type ==
                                                  'ComplaintHistory') {
                                                Get.offNamed(
                                                    reportshistoryscreen,
                                                    arguments: [
                                                      homeScreenController.user,
                                                      homeScreenController
                                                          .snapShot
                                                    ]);
                                              } else if (homeScreenController
                                                      .historyLi[i].type ==
                                                  'GuestHistory') {
                                                Get.offNamed(
                                                    guestshistoryscreen,
                                                    arguments:
                                                        homeScreenController
                                                            .user);
                                              }
                                            }),
                                        28.w.pw
                                      ],
                                    ]),
                              ),
                            ),
                            HomeHeading(text: 'Bills'),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(28.w, 0, 0, 0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i <
                                              homeScreenController
                                                  .billsLi.length;
                                          i++) ...[
                                        ServiceCards(
                                            description: homeScreenController
                                                .billsLi[i].description,
                                            heading: homeScreenController
                                                .billsLi[i].heading,
                                            iconPath: homeScreenController
                                                .billsLi[i].iconPath,
                                            onTap: () {
                                              if (homeScreenController
                                                      .billsLi[i].type ==
                                                  'MonthlyBills') {
                                                Get.offNamed(monthly_bill,
                                                    arguments: [
                                                      homeScreenController.user,
                                                      homeScreenController
                                                          .snapShot,
                                                    ]);
                                              }
                                            })
                                      ],
                                      28.w.pw
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return HomeScreenShimmer();
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return HomeScreenShimmer();
                  } else if (snapshot.hasError) {
                    return HomeScreenShimmer();
                  } else {
                    return HomeScreenShimmer();
                  }
                }),
            floatingActionButton: SizedBox(
              width: 53.w,
              height: 53.w,
              child: FloatingActionButton(
                backgroundColor: Color(0xffFF9900),
                onPressed: () {
                  if (homeScreenController.snapShot == null) {
                    // myToast(
                    //     msg:
                    //         "Something went wrong ,We're having issues loading this page.");
                  } else if (homeScreenController.snapShot.status == 0) {
                    myToast(
                        msg:
                            'Try Again later !. You are under verification Process.');
                  } else {
                    Get.offNamed(reporttoadmin, arguments: [
                      homeScreenController.user,
                      homeScreenController.snapShot
                    ]);
                  }
                },
                child: SvgPicture.asset(
                  'assets/Plus_ic.svg',
                  width: 24.w,
                  height: 24.w,
                  color: Colors.white,
                ),
              ),
            ),
            bottomNavigationBar: SizedBox(
              width: 375.w,
              height: 90.w,
              child: BottomAppBar(
                shape: CircularNotchedRectangle(),
                notchMargin: 12.0,
                child: Row(
                  children: [
                    20.w.pw,
                    HomeBottomAppBarIcon(
                      text: 'Home',
                      icon: IconlyBold.home,
                      color: homeScreenController.selectedIndex == 0
                          ? primaryColor
                          : Colors.grey,
                      onPressed: () {
                        homeScreenController.onItemTapped(0);

                        if (homeScreenController.snapShot == null) {
                          // myToast(
                          //     msg:
                          //         "Something went wrong ,We're having issues loading this page.");
                        } else if (homeScreenController.snapShot.status == 0) {
                          myToast(
                              msg:
                                  'Try Again later !. You are under verification Process.');
                        } else if (homeScreenController.snapShot.status ==
                            null) {
                          myToast(
                              msg:
                                  "Something went wrong ,We're having issues loading this page.");
                        }
                      },
                    ),
                    30.5.w.pw,
                    HomeBottomAppBarIcon(
                      text: 'Complaints',
                      icon: IconlyBold.time_square,
                      onPressed: () {
                        homeScreenController.onItemTapped(1);
                        if (homeScreenController.snapShot == null) {
                          // myToast(
                          //     msg:
                          //         "Something went wrong ,We're having issues loading this page.");
                        } else if (homeScreenController.snapShot.status == 0) {
                          myToast(
                              msg:
                                  'Try Again later !. You are under verification Process.');
                        } else if (homeScreenController.snapShot.status ==
                            null) {
                          myToast(
                              msg:
                                  "Something went wrong ,We're having issues loading this page.");
                        } else {
                          Get.offNamed(adminreports, arguments: [
                            homeScreenController.user,
                            homeScreenController.snapShot
                          ]);
                        }
                      },
                      color: homeScreenController.selectedIndex == 1
                          ? primaryColor
                          : Colors.grey,
                    ),
                    Spacer(),
                    HomeBottomAppBarIcon(
                      text: 'Noticeboard',
                      icon: IconlyBold.document,
                      onPressed: () async {
                        homeScreenController.onItemTapped(2);
                        if (homeScreenController.snapShot == null) {
                          // myToast(
                          //     msg:
                          //         "Something went wrong ,We're having issues loading this page.");
                        } else if (homeScreenController.snapShot.status == 0) {
                          myToast(
                              msg:
                                  'Try Again later !. You are under verification Process.');
                        } else if (homeScreenController.snapShot.status ==
                            null) {
                          myToast(
                              msg:
                                  "Something went wrong ,We're having issues loading this page.");
                        } else {
                          Get.offNamed(noticeboardscreen, arguments: [
                            homeScreenController.user,
                            homeScreenController.snapShot
                          ]);
                        }
                      },
                      color: homeScreenController.selectedIndex == 2
                          ? primaryColor
                          : Colors.grey,
                    ),
                    30.5.w.pw,
                    HomeBottomAppBarIcon(
                      text: 'Discussion\nForum',
                      icon: IconlyBold.chat,
                      onPressed: () async {
                        homeScreenController.onItemTapped(3);
                        if (homeScreenController.snapShot == null) {
                          // myToast(
                          //     msg:
                          //         "Something went wrong ,We're having issues loading this page.");
                        } else if (homeScreenController.snapShot.status == 0) {
                          myToast(
                              msg:
                                  'Try Again later !. You are under verification Process.');
                        } else if (homeScreenController.snapShot.status ==
                            null) {
                          myToast(
                              msg:
                                  "Something went wrong ,We're having issues loading this page.");
                        } else {
                          DiscussionRoomModel discussionRoomModel =
                              await homeScreenController.createChatRoomApi(
                                  token: homeScreenController.user.bearerToken!,
                                  subadminid:
                                      homeScreenController.snapShot.subadminid);
                          Get.offNamed(discussion_form, arguments: [
                            homeScreenController.user,
                            homeScreenController.snapShot,
                            discussionRoomModel
                          ]);
                        }
                      },
                      color: homeScreenController.selectedIndex == 3
                          ? primaryColor
                          : Colors.grey,
                    ),
                    20.w.pw,
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ));
        });
  }
}

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.h.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: 400.w,
                height: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.grey,
                ),
              ),
            ),
            16.h.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: FirstCard(),
            ),
            16.h.ph,
            Center(
              child: Container(
                width: 100.w,
                height: 10.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey,
                ),
              ),
            ),
            16.h.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Container(
                height: 47.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28.r),
                    color: Colors.grey),
              ),
            ),
            16.h.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: 100.w,
                height: 10.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.r)),
              ),
            ),
            16.h.ph,
            Padding(
              padding: EdgeInsets.fromLTRB(28.w, 0, 0, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: 145.63.w,
                    height: 117.w,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                  28.w.pw,
                  SizedBox(
                    width: 145.63.w,
                    height: 117.w,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                ],
              ),
            ),
            16.h.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: 100.w,
                height: 10.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.r)),
              ),
            ),
            16.h.ph,
            Padding(
              padding: EdgeInsets.fromLTRB(28.w, 0, 0, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: 145.63.w,
                    height: 117.w,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                  28.w.pw,
                  SizedBox(
                    width: 145.63.w,
                    height: 117.w,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                HexColor('#FB7712'),
                HexColor('#FF9900'),
              ])),
              child: Stack(
                children: [
                  Text(
                    "Resident App",
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                        fontSize: 15),
                  ),
                ],
              )),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: primaryColor,
            ),
            title: Text("Logout"),
            onTap: () async {
              await FirebaseMessaging.instance.deleteToken();
              final HomeScreenController _homeScreenController = Get.find();
              _homeScreenController.logoutApi(
                  token: _homeScreenController.user.bearerToken!);
            },
          ),
        ],
      ),
    );
  }
}

// class HomeAppBar extends StatelessWidget {
//   final HomeScreenController? homeScreenController;
//   const HomeAppBar({this.homeScreenController});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(24.w, 0, 26.w, 0),
//       child: SizedBox(
//         width: 375.w,
//         height: 72.w,
//         child: IntrinsicHeight(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Text(
//                     "Welcome Home, ${homeScreenController?.user.firstName} ${homeScreenController?.user.lastName} ",
//                     maxLines: 2,
//                     style: GoogleFonts.ubuntu(
//                         fontSize: 22.sp,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff130F26))),
//               ),
//               20.w.pw,
//               GestureDetector(
//                 onTap: () {
//                   _scaffoldKey.currentState!.openEndDrawer();
//                 },
//                 child: Stack(children: [
//                   Container(
//                     width: 54.w,
//                     height: 54.w,
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                             image: AssetImage(
//                           'assets/user.png',
//                         ))),
//                   ),
//                   Positioned(
//                     left: 40.w,
//                     top: 2.h,
//                     child: Container(
//                       height: 12.w,
//                       width: 12.w,
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   )
//                 ]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class HomeVerificationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/verification.svg',
            width: 300,
          ),
          Text(
            "Please Be Patient !",
            style: GoogleFonts.ubuntu(
                color: HexColor('#A5AAB7'),
                fontSize: 38.sp,
                fontWeight: FontWeight.w600),
          ),
          10.h.ph,
          Text(
            "We are verifying your details.",
            style: GoogleFonts.ubuntu(
                color: HexColor('#A5AAB7'),
                fontSize: 20.sp,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// class CheckInternetConnectionWidget extends StatelessWidget {
//   final AsyncSnapshot<ConnectivityResult> snapshot;
//   final Widget widget;
//   const CheckInternetConnectionWidget(
//       {Key? key, required this.snapshot, required this.widget})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     switch (snapshot.connectionState) {
//       case ConnectionState.active:
//         final state = snapshot.data!;
//         switch (state) {
//           case ConnectivityResult.none:
//             return Center(child: const Text('Not connected'));
//           default:
//             return widget;
//         }
//       default:
//         return const Text('');
//     }
//   }
// }
