import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/Module/Add%20PreApprove%20Entry/Model/GateKeeper.dart'
    as gatekeeper;
import 'package:userapp/Routes/set_routes.dart';

import '../../../Constants/api_routes.dart';
import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';

class AddPreApproveEntryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formKey = new GlobalKey<FormState>();
  late TabController tabController;
  gatekeeper.GateKeeper? gateKeepers;
  var gateKeeperLi = <gatekeeper.GateKeeper>[];

  final List<Tab> tabs = [
    Tab(
      text: 'Guest',
      icon: SvgPicture.asset('assets/icons/guest_icon.svg'),
    ),
    Tab(
      text: 'Delivery',
      icon: SvgPicture.asset('assets/icons/delivery_icon.svg'),
    ),
    Tab(
      text: 'Cab',
      icon: SvgPicture.asset('assets/icons/cab_icon.svg'),
    ),
    Tab(
      text: 'Visiting Help',
      icon: SvgPicture.asset('assets/icons/visiting_help_icon.svg'),
    ),
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController arrivaldate = TextEditingController();
  TextEditingController guestVehicleNo = TextEditingController();
  TextEditingController arrivaltime = TextEditingController();
  String? arrivalTime;

  var data = Get.arguments;
  late final User userdata;
  late final Residents resident;
  int visitorType = 0;
  String? visitorTypeValue;
  bool isData = false;
  bool isVisitorType = false;
  bool isLoading = false;

  bool checkBoxValue = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    visitorType = data[2];
    tabController =
        TabController(length: 4, vsync: this, initialIndex: visitorType);
    userdata = data[0];
    resident = data[1];
    if (visitorType == 0) {
      visitorTypeValue = 'Guest';
    } else if (visitorType == 1) {
      visitorTypeValue = 'Delivery';
    } else if (visitorType == 2) {
      visitorTypeValue = 'Cab';
    } else if (visitorType == 3) {
      visitorTypeValue = 'Visiting Help';
    }
  }

  setVisitorTypeDropDownValue(val) {
    visitorTypeValue = val;
    update();
  }

  Future StartDate(context) async {
    DateTime? picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030),
        context: context);
    if (picked != null) {
      picked.toString();
      arrivaldate.text = picked.toString().split(' ')[0];

      update();
    } else {
      arrivaldate.text = DateTime.now().toString().split(' ')[0];
      update();
    }
  }

  Future GuestTime(context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    print('time.$picked');
    var currentTime =
        '${picked!.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

    currentTime.toString();

    arrivalTime = currentTime.toString().split(' ')[0].trim();
    arrivaltime.text = DateHelper.formatTimeToAMPM(
        currentTime.toString().split(' ')[0].trim());

    update();
  }

  setVisitorTypeDropDown(newValue) {
    visitorTypeValue = newValue;

    update();
  }

  Future<List<gatekeeper.GateKeeper>> getGateKeepersApi(
      {required int subadminid, required String token}) async {
    List<gatekeeper.GateKeeper> li = [];
    print('getGateKeepersApi hit');

    final response = await Http.get(
      Uri.parse(Api.getGatekeepers + "/" + subadminid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );

    var data = jsonDecode(response.body.toString());


    if (response.statusCode == 200) {
      li = (data['data'] as List)
          .map((e) => gatekeeper.GateKeeper(
              e["gatekeeperid"],
              e["subadminid"],
              e["gateno"],
              e["firstname"],
              e["lastname"],
              e["cnic"],
              e["address"],
              e["mobileno"],
              e["roleid"],
              e["rolename"],
              e["image"]))
          .toList();

      print(li);

      return li;
    }

    return li;
  }

  Future addPreApproveEntryApi({
    required String token,
    required int gatekeeperid,
    required int userid,
    required String visitortype,
    required String name,
    required String description,
    required String cnic,
    required String mobileno,
    required String vechileno,
    required String arrivaldate,
    required String arrivaltime,
  }) async {
    isLoading = true;
    update();
    final response = await Http.post(
      Uri.parse(Api.addPreApproveEntry),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "gatekeeperid": gatekeeperid,
        "userid": userid,
        "visitortype": visitortype,
        "name": name,
        "description": description,
        "cnic": cnic,
        "mobileno": mobileno,
        "vechileno": vechileno,
        "arrivaldate": arrivaldate,
        "arrivaltime": arrivaltime,
        "status": 1,
        "statusdescription": "Approved",
      }),
    );

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      var data = jsonDecode(response.body);
      print(data);
      print(response.statusCode);

      Get.offAndToNamed(preapproveentryscreen, arguments: [userdata, resident]);

      myToast(msg: 'Operation Successful');
    }
    else {
      isLoading = false;
      update();
      myToast(msg: 'Operation Failed', isNegative: true);
    }
  }

  SelectedGatekeeper(val) async {
    gateKeepers = val;

    update();
  }

  setCheckBox(val) async {
    checkBoxValue = val;
    update();
  }
}
