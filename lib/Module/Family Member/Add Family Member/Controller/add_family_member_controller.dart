import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Routes/set_routes.dart';

import '../../../../Constants/api_routes.dart';
import '../../../HomeScreen/Model/residents.dart';
import '../../../Login/Model/User.dart';

class AddFamilyMemberController extends GetxController {
  var isHidden = false;
  var isLoading = false;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController vehiclenoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var imageFile;
  var data = Get.arguments;
  late final User userdata;
  late final Residents resident;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userdata = data[0];
    resident = data[1];
  }

  getFromGallery(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      print('file picked: $pickedFile');

      print('Assigning Image file');
      imageFile = File(pickedFile.path);
      update();
    } else {}
  }

  getFromCamera(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      print('file picked: $pickedFile');
      // img = pickedFile as Image?;

      print('Assigning Image file');
      imageFile = File(pickedFile.path);
      update();
    } else {}
  }

  void togglePasswordView() {
    isHidden = !isHidden;
    update();
  }

  Future addFamilyMemberApi(
      {required String firstName,
      required String bearerToken,
      required String lastName,
      required String cnic,
      required String address,
      required String mobileno,
      required String password,
      required int subadminid,
      required int residentid,
      required File? file}) async {
    print('Add Family Member  Api  Function Call');
    print("----Data----");
    print(firstName);
    print(lastName);
    print(cnic);
    print(address);
    print(mobileno);
    print(password);
    print(residentid);
    print(subadminid);
    print(file);
    print(bearerToken);
    print("---------------------------");
    Map<String, String> headers = {"Authorization": "Bearer $bearerToken"};

    var request = Http.MultipartRequest('POST', Uri.parse(Api.addFamilyMember));
    request.headers.addAll(headers);
    if (file != null) {
      request.files.add(await Http.MultipartFile.fromPath('image', file.path));
    }
    request.fields['firstname'] = firstName;
    request.fields['lastname'] = lastName;
    request.fields['cnic'] = cnic;
    request.fields['address'] = address;
    request.fields['mobileno'] = mobileno;
    request.fields['password'] = password;
    request.fields['residentid'] = residentid.toString();
    request.fields['subadminid'] = subadminid.toString();
    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);
    print(response.statusCode);

    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      print(response.body);

      Get.offAllNamed(viewfamilymember, arguments: [userdata, resident]);
    } else if (response.statusCode == 403) {
      var data = jsonDecode(response.body.toString());

      myToast(msg: data.toString(), isNegative: true);
    } else {
      myToast(msg: 'Failed to Add Family Member', isNegative: true);
    }
  }
}
