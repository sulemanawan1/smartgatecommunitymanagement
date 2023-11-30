import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Constants/constants.dart';

import '../../../Constants/api_routes.dart';
import '../../../Routes/set_routes.dart';
import '../../Login/Model/User.dart';

class SellProductsController extends GetxController {
  final formKey = new GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  bool isLoading = false;
  File? imageFile;
  List<String> conditionTypeList = ['New', 'Like New', 'Good', 'Average'];
  List<String> categoryTypeList = [
    "Antiques",
    "Appliances",
    "Arts & Crafts",
    "Vechile",
    "Auto Parts",
    "Baby & Kids",
    "Beauty & Personal Care",
    "Bicycles",
    "Books",
    "Cell Phones",
    "Clothing & Accessories",
    "Collectibles",
    "Computers & Accessories",
    "Electronics",
    "Furniture",
    "Games & Toys",
    "Home & Garden",
    "Jewelry & Watches",
    "Musical Instruments",
    "Outdoor & Camping",
    "Pet Supplies",
    "Sporting Goods",
    "Tickets",
    "Tools & Machinery",
    "Video Games & Consoles",
    "Other"
  ];
  String? conditionTypeDropDownValue;
  String? categoryTypeDropDownValue;
  var data = Get.arguments;
  late final User userdata;
  var resident;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userdata = data[0];
    resident = data[1];
    print('resident ${resident.residentid}');
  }

  final focus = FocusNode();
  getFromGallery(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      update();
    }
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
    }
  }

  setCategoryTypeDropDownValue(val) {
    categoryTypeDropDownValue = val;
    update();
  }

  setConditionTypeDropDownValue(val) {
    conditionTypeDropDownValue = val;
    update();
  }

  addProductDetailApi({
    required File file,
    required String token,
    required int residentid,
    required int societyid,
    required int subadminid,
    required String productname,
    required String productprice,
    required String description,
    String? contact,
    String? category,
    String? condition,
  }) async {
    isLoading = true;
    update();

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    var request = Http.MultipartRequest('POST', Uri.parse(Api.addProduct));
    request.headers.addAll(headers);

    request.files.add(await Http.MultipartFile.fromPath('images', file.path));

    request.fields['productname'] = productname;
    request.fields['description'] = description;
    request.fields['productprice'] = productprice;
    request.fields['subadminid'] = subadminid.toString();
    request.fields['societyid'] = societyid.toString();
    request.fields['residentid'] = residentid.toString();
    request.fields['contact'] = contact.toString();
    request.fields['category'] = category.toString();
    request.fields['condition'] = condition.toString();

    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    try {
      if (response.statusCode == 200) {
        isLoading = false;
        update();

        Get.offAndToNamed(marketPlaceScreen, arguments: [userdata, resident]);

        myToast(msg: 'Item Uploaded Successfully');
      } else if (response.statusCode == 403) {
        isLoading = false;
        update();
        var data = jsonDecode(response.body.toString());

        myToast(msg: "Error: ${data}", isNegative: true);
      } else if (response.statusCode == 500) {
        isLoading = false;
        update();
        myToast(msg: "Server Error", isNegative: true);
      } else {
        isLoading = false;
        update();
        myToast(msg: "Operation Failed", isNegative: true);
      }
    } catch (e) {
      myToast(msg: "Something went wrong ${e.toString()}", isNegative: true);
    }
  }

  blockUserApi({
    required userId,
    required String token,
    required chatRoomId,
    required blockedUserid,
  }) async {
    isLoading = true;
    update();

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    var request = Http.MultipartRequest('POST', Uri.parse(Api.blockUser));
    request.headers.addAll(headers);

    request.fields['userid'] = userId.toString();
    request.fields['chatroomid'] = chatRoomId.toString();
    request.fields['blockeduserid'] = blockedUserid.toString();

    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    try {
      if (response.statusCode == 200) {
        isLoading = false;
        update();

        Get.offAndToNamed(marketPlaceScreen, arguments: [userdata, resident]);

        myToast(msg: 'Item Uploaded Successfully');
      } else if (response.statusCode == 403) {
        isLoading = false;
        update();
        var data = jsonDecode(response.body.toString());

        myToast(msg: "Error: ${data}", isNegative: true);
      } else if (response.statusCode == 500) {
        isLoading = false;
        update();
        myToast(msg: "Server Error", isNegative: true);
      } else {
        isLoading = false;
        update();
        myToast(msg: "Operation Failed", isNegative: true);
      }
    } catch (e) {
      myToast(msg: "Something went wrong ${e.toString()}", isNegative: true);
    }
  }

  unBlockUserApi({
    required String token,
    required chatRoomId,
    required blockedUserid,
  }) async {
    isLoading = true;
    update();

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    var request = Http.MultipartRequest('POST', Uri.parse(Api.unblockUser));
    request.headers.addAll(headers);

    request.fields['chatroomid'] = chatRoomId.toString();
    request.fields['blockeduserid'] = blockedUserid.toString();

    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    try {
      if (response.statusCode == 200) {
        isLoading = false;
        update();

        Get.offAndToNamed(marketPlaceScreen, arguments: [userdata, resident]);

        myToast(msg: 'Item Uploaded Successfully');
      } else if (response.statusCode == 403) {
        isLoading = false;
        update();
        var data = jsonDecode(response.body.toString());

        myToast(msg: "Error: ${data}", isNegative: true);
      } else if (response.statusCode == 500) {
        isLoading = false;
        update();
        myToast(msg: "Server Error", isNegative: true);
      } else {
        isLoading = false;
        update();
        myToast(msg: "Operation Failed", isNegative: true);
      }
    } catch (e) {
      myToast(msg: "Something went wrong ${e.toString()}", isNegative: true);
    }
  }
}
