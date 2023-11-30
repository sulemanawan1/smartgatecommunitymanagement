import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Module/Signup/Resident%20Personal%20Detail/Model/resident.dart';

import '../../../../Constants/api_routes.dart';
import '../../../../Constants/constants.dart';
import '../../../../Routes/set_routes.dart';

class ResidentPersonalDetailController extends GetxController {
  var isHidden = false;
  var isLoading = false;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController vehiclenoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ownernameController = TextEditingController();
  TextEditingController owneraddressController = TextEditingController();
  TextEditingController ownerphonenumController = TextEditingController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  var imageFile;
  var imagePath;

  Resident? resident;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("init");
    //print(user);
  }

  getFromGallery(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
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

  Future signUpApi(
      {required String firstName,
      required String lastName,
      required String cnic,
      required String address,
      required String mobileno,
      required String password,
      required File? file}) async {
    isLoading = true;
    update();
    var request = Http.MultipartRequest('POST', Uri.parse(Api.signup));
    if (file != null) {
      request.files.add(await Http.MultipartFile.fromPath('image', file.path));
    }
    request.fields['firstname'] = firstName;
    request.fields['lastname'] = lastName;
    request.fields['cnic'] = cnic;
    request.fields['address'] = 'NA';
    request.fields['mobileno'] = mobileno;
    request.fields['roleid'] = 3.toString();
    request.fields['rolename'] = 'resident';
    request.fields['password'] = password;
    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);
    print(response.statusCode);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      print(response.body);
      resident = Resident(
          id: data['data']['id'],
          firstname: data['data']['firstname'],
          lastname: data['data']['lastname'],
          cnic: data['data']['cnic'],
          address: data['data']['address'],
          mobileno: data['data']['mobileno'],
          roleid: data['data']['roleid'],
          rolename: data['data']['rolename'],
          image: data['data']['image'],
          token: data['token']);

      Get.offAllNamed(loginscreen);

      myToast(msg: 'Registration successfully');

      isLoading = false;
      update();
    } else if (response.statusCode == 403) {
      var data = jsonDecode(response.body.toString());

      (data['errors'] as List)
          .map((e) => myToast(msg: e.toString(), isNegative: true))
          .toList();
      isLoading = false;
      update();
    } else {
      myToast(msg: 'Failed to Register', isNegative: true);
      isLoading = false;
      update();
    }
  }
}
