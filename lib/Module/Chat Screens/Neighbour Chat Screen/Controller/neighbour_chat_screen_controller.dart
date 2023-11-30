import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/Module/Chat%20Screens/Neighbour%20Chat%20Screen/Model/BlockedUser.dart';

import '../../../../Constants/api_routes.dart';
import '../../../../Constants/constants.dart';
import '../../../Chat Availbility/Model/ChatNeighbours.dart' as ChatNeighbours;
import '../../../Chat Availbility/Model/ChatRoomModel.dart';
import '../../../HomeScreen/Model/residents.dart';
import '../../../Login/Model/User.dart';

class NeighbourChatScreenController extends GetxController {
  var data = Get.arguments;
  late final User user;
  late int chatRoomId;
  late final Residents resident;
  late BlockedUser blockedUser;
  late final ChatNeighbours.Data chatNeighbours;
  bool isLoading = false;

  String? chatType;

  final TextEditingController msg = TextEditingController();

  //
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit

    user = data[0];
    resident = data[1];
    chatNeighbours = data[2];
    chatRoomId = data[3];
    chatType = data[4];
    check();

    super.onInit();
  }

  check() async {
    await checkBlockUserApi(token: user.bearerToken!, chatRoomId: chatRoomId)!;
  }

  Future<ChatRoomModel> createChatRoomApi({
    required String token,
    required int userid,
    required int chatuserid,
  }) async {
    final response = await Http.post(
      Uri.parse(Api.createChatRoom),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "loginuserid": userid,
        "chatuserid": chatuserid,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return ChatRoomModel.fromJson(data);
    } else {
      return ChatRoomModel.fromJson(data);
    }
  }

  Future<void> sendNotification(
      {required chatType,
      required fcmToken,
      required name,
      required message,
      required chatRoomId,
      required Map myData}) async {
    print("----chat room id------");
    print(chatRoomId);
    print("----chat room id------");
    const String serverKey =
        'AAAA_LNU7n0:APA91bFIkH1lvp3eEUWJWg6ptFpvt5dz7XWVQVbnt9rgYVDfDPdSbwbyapKkVu7NyVWpSpfOVfFaGg1sr7QxXaZFlMav4kyVPi1tk7Rs6ejybJEYTOOnTbYufjHw7aZUYUx_xaZ2fGbr'; // Replace with your FCM server key
    final String fcmEndpoint = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, dynamic> notification = {
      'title': chatType,
      'body': '$name : $message',
    };
    // var li = [];
    // li.add(myData);

    final Map<String, dynamic> data = {
      'notification': notification,
      'priority': 'high',
      'to': fcmToken.toString(),
      'data': {'type': chatType, 'data': myData, 'chatroomid': chatRoomId},
    };

    final response = await Http.post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print("success");
    } else {
      print("failed");
    }
  }

  Future<BlockedUser?> checkBlockUserApi({
    required String token,
    required chatRoomId,
  }) async {
    isLoading = true;
    update();

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    var request = Http.MultipartRequest('POST', Uri.parse(Api.checkBlockUser));
    request.headers.addAll(headers);

    request.fields['chatroomid'] = chatRoomId.toString();

    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        blockedUser = BlockedUser(data: null, success: null, message: null);
        blockedUser = BlockedUser.fromJson(data);
        isLoading = false;
        update();
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
    } on SocketException catch (e) {
      myToast(
          msg: "Something went wrong ${e.message.toString()}",
          isNegative: true);
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
        check();
        isLoading = false;
        update();
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
    } on SocketException catch (e) {
      myToast(
          msg: "Something went wrong ${e.message.toString()}",
          isNegative: true);
    } catch (e) {
      myToast(msg: "Something went wrong ${e.toString()}", isNegative: true);
    }
  }
}

enum ChatTypes { NeighbourChat, MarketPlaceChat, MarketPlaceProductDetails }
