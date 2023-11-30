import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';
import 'package:userapp/App%20Exceptions/app_exception.dart';
import 'package:userapp/Constants/api_routes.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Repo/Home%20Repository/home_repository.dart';

import '../../../Routes/set_routes.dart';
import '../../../Services/Notification Services/notification_services.dart';
import '../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../../Login/Model/User.dart';
import '../Model/DiscussionRoomModel.dart';
import '../Model/residents.dart';

class HomeScreenController extends GetxController {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameController.dispose();
    pageController.dispose();
  }

  late Future<Residents> future;

  final _repository = HomeRepository();
  var imageFile;
  var data = Get.arguments;
  late final User user;
  final pageController = PageController();
  var snapShot;
  int selectedIndex = 0;
  var isLoading = false;

  final userNameController = TextEditingController();
  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }

  List<QuickActions> quickActions = [];

  List<HomeScreenCardModel> lifeStyleSolutionsLi = [
    HomeScreenCardModel(
      heading: 'Family Members',
      description:
          'Inclusive communities. Easy family additions. Strengthening bonds',
      iconPath: 'assets/icons/familymember.svg',
      type: 'FamilyMembers',
    ),
    HomeScreenCardModel(
      heading: 'Market Place',
      description: 'Buy and Sell',
      iconPath: 'assets/icons/marketplace.svg',
      type: 'MarketPlace',
    ),
  ];
  List<HomeScreenCardModel> servicesLi = [
    HomeScreenCardModel(
      heading: 'Complaint',
      description:
          'Resolve issues. Empower residents. Strengthen community bonds',
      iconPath: 'assets/icons/complain.svg',
      type: 'Complaints',
    ),
    HomeScreenCardModel(
      heading: 'Pre Approve Entry',
      description:
          'Seamless access. Secure entry. Hassle-free resident approvals.',
      iconPath: 'assets/icons/preapproveentry.svg',
      type: 'PreApproveEntry',
    ),
  ];
  List<HomeScreenCardModel> eventsLi = [
    HomeScreenCardModel(
      heading: 'Society Events',
      description: 'Unforgettable gatherings. Engaging community events.',
      iconPath: 'assets/icons/societyevent.svg',
      type: 'Events',
    ),
    HomeScreenCardModel(
      heading: 'Notice Board',
      description:
          'Stay informed. Important updates. Community notices at fingertips',
      iconPath: 'assets/icons/noticeboard.svg',
      type: 'NoticeBoard',
    ),
  ];
  List<HomeScreenCardModel> conversationLi = [
    HomeScreenCardModel(
      heading: 'Community Members',
      description: 'Connect with neighbors. Instant community communication',
      iconPath: 'assets/icons/neighbourchat.svg',
      type: 'NeighboursChats',
    ),
    HomeScreenCardModel(
      heading: 'Discussion Forum',
      description: 'Engage. Discuss. Share. Community forum platform',
      iconPath: 'assets/icons/discussion_forum.svg',
      type: 'DiscussionForum',
    ),
  ];

  List<HomeScreenCardModel> historyLi = [
    HomeScreenCardModel(
      heading: 'Complaint History',
      description: 'Track. Resolve. Improve. Complaint history tracker',
      iconPath: 'assets/icons/complain_history.svg',
      type: 'ComplaintHistory',
    ),
    HomeScreenCardModel(
      heading: 'Guest History',
      description: 'Guest visits. History. Enhanced security.',
      iconPath: 'assets/icons/guest_history.svg',
      type: 'GuestHistory',
    ),
  ];

  List<HomeScreenCardModel> billsLi = [
    HomeScreenCardModel(
      heading: 'Monthly Bills',
      description: 'Easy pay your Monthly Bills',
      iconPath: 'assets/icons/monthly.svg',
      type: 'MonthlyBills',
    ),
  ];

  List<HomeScreenCardModel> safetyAssistanceLi = [
    HomeScreenCardModel(
      heading: 'Emergency',
      description: 'Rapid distress alerts for resident safety',
      iconPath: 'assets/icons/emergency.svg',
      type: 'SafetyAssistance',
    ),
  ];

  getFromCamera(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      print('file picked: $pickedFile');

      print('Assigning Image file');
      imageFile = File(pickedFile.path);
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement

    super.onInit();

    quickActions.add(QuickActions(
        text: 'Cab', iconPath: 'assets/icons/cab_icon.svg', width: 110.w));
    quickActions.add(QuickActions(
        text: 'Delivery',
        iconPath: 'assets/icons/delivery_icon.svg',
        width: 129.w));
    quickActions.add(QuickActions(
        text: 'Guest', iconPath: 'assets/icons/guest_icon.svg', width: 110.w));
    quickActions.add(QuickActions(
        text: 'Visiting Help',
        iconPath: 'assets/icons/visiting_help_icon.svg',
        width: 110.w));
    NotificationServices notificationServices = NotificationServices();
    notificationServices.requestNotification();
    notificationServices.fireBaseInit();
    notificationServices.setupInteractMessage();
    notificationServices.getDeviceToken();

    this.user = data;
    print(user.userId);
    print(user.bearerToken);

    future = user.roleId == 5
        ? loginResidentDetails(
            userid: user.residentid!, token: user.bearerToken!)
        : // Login user Resident
        loginResidentDetails(userid: user.userId!, token: user.bearerToken!);
  }

  Future<Residents> loginResidentDetails(
      {required int userid, required String token}) async {
    try {
      final response = await Http.get(
        Uri.parse(Api.loginResidentDetails + "/" + userid.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());
      print(data);
      var e = data['data'];
      var societyData = data['data']['societydata'];
      var societyId = societyData[0]['societyid'];
      var superAdminId = societyData[0]['superadminid'];
      final Residents residents = Residents(
          id: e['id'],
          residentid: e['residentid'],
          subadminid: e['subadminid'],
          superadminid: superAdminId,
          societyid: societyId,
          country: e["country"],
          state: e["state"],
          city: e["city"],
          houseaddress: e["houseaddress"],
          vechileno: e["vechileno"],
          residenttype: e["residenttype"],
          propertytype: e["propertytype"],
          committeemember: e["committeemember"],
          status: e["status"],
          username: e["username"],
          createdAt: e["createdAt"],
          updatedAt: e["updatedAt"]);

      if (response.statusCode == 200) {
        return residents;
      } else {
        throw UnKnownException();
      }
    } on SocketException catch (e) {
      myToast(msg: throw InternetException(e));
    }
  }

  logoutApi({required String token}) async {
    print(token);

    final response = await Http.post(
      Uri.parse(Api.logout),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print("logout successfully");

      MySharedPreferences.deleteUserData();

      Get.offAllNamed(loginscreen);
    } else {
      print(data);
    }
  }

  Future<DiscussionRoomModel> createChatRoomApi({
    required String token,
    required int subadminid,
  }) async {
    final response = await Http.post(
      Uri.parse(Api.createDiscussionRoom),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "subadminid": subadminid,
      }),
    );
    print(response.body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      return DiscussionRoomModel.fromJson(data);
    } else {
      return DiscussionRoomModel.fromJson(data);
    }
  }

  Future<void> refreshScreen() async {
    Future.delayed(Duration(seconds: 1));
    future = await user.roleId == 5
        ? loginResidentDetails(
            userid: user.residentid!, token: user.bearerToken!)
        : // Login user Resident
        loginResidentDetails(userid: user.userId!, token: user.bearerToken!);

    update();
  }

  updateUserNameApi() async {
    isLoading = true;
    update();

    Map<String, String> data = <String, String>{
      'residentid': user.userId.toString(),
      'username': userNameController.text.toString()
    };
    _repository.updateUserNameApi(data, user.bearerToken).then((value) async {
      myToast(msg: 'User Name Updated Successfully');
      future = await user.roleId == 5
          ? loginResidentDetails(
              userid: user.residentid!, token: user.bearerToken!)
          : // Login user Resident
          loginResidentDetails(userid: user.userId!, token: user.bearerToken!);
      update();
      userNameController.clear();

      isLoading = false;
    }).onError((error, stackTrace) {
      isLoading = false;

      update();
      print(stackTrace);
      print(error);
      if (error.toString() == '403UnAuthorized') {
        myToast(msg: 'User Name Already Taken.', isNegative: true);
        userNameController.clear();
      } else {
        myToast(msg: error.toString(), isNegative: true);
      }
    });
  }
}

class QuickActions {
  final String? text;
  final String? iconPath;
  final double? width;

  QuickActions(
      {required this.text, required this.iconPath, required this.width});
}

class HomeScreenCardModel {
  final String? heading;
  final String? description;
  final String? iconPath;
  final String? type;

  const HomeScreenCardModel({
    required this.heading,
    required this.description,
    required this.iconPath,
    required this.type,
  });
}
