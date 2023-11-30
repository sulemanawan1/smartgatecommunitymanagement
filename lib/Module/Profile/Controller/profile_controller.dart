import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/Module/HomeScreen/Model/residents.dart';

import '../../../Constants/api_routes.dart';
import '../../../Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../Chat Availbility/Model/ChatNeighbours.dart';
import '../../Chat Availbility/Model/ChatRoomModel.dart' as ch;
import '../../Chat Screens/Neighbour Chat Screen/Controller/neighbour_chat_screen_controller.dart';
import '../../Chat Screens/Neighbour Chat Screen/Model/BlockedUser.dart'
    as blockuser;
import '../../Login/Model/User.dart';

class ProfileController extends GetxController {
  var data = Get.arguments;
  late final User userdata;
  late final chatRoomId;
  late Data chatNeighbours;
  late Residents resident;
  late Future<ch.ChatRoomModel> futureChatRoomData;
  bool isLoading = false;
  String? chatType;
  late final blockuser.BlockedUser blockedUser;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userdata = data[0];
    resident = data[1];
    chatNeighbours = data[2];
    chatRoomId = data[3];
    chatType = data[4];
    check();
    futureChatRoomData = createChatRoomApi(
        token: userdata.bearerToken!,
        userid: userdata.userId!,
        chatUserId: chatNeighbours.residentid!);

    print(userdata.userId);
    print(resident.residentid);
    print(chatNeighbours.lastname);
    print(chatRoomId);
  }

  check() async {
    await checkBlockUserApi(
        token: userdata.bearerToken!, chatRoomId: chatRoomId)!;
  }

  sendCatRequestStatusApi({
    required String token,
    required int id,
    required String status,
    required int userId,
    required int chatUserId,
  }) async {
    isLoading = true;
    update();
    final response = await Http.post(
      Uri.parse(Api.sendChatRequest),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "status": status,
        "sender": userId,
        "receiver": chatUserId,
      }),
    );

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      futureChatRoomData = createChatRoomApi(
          token: userdata.bearerToken!,
          userid: userdata.userId!,
          chatUserId: chatNeighbours.residentid!);
    } else {
      isLoading = false;
      update();

      throw Exception();
    }
  }

  Future<ch.ChatRoomModel> createChatRoomApi({
    required String token,
    required int userid,
    required int chatUserId,
  }) async {
    final response = await Http.post(
      Uri.parse(Api.createChatRoom),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "sender": userid,
        "receiver": chatUserId,
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return ch.ChatRoomModel.fromJson(data);
    } else {
      return ch.ChatRoomModel.fromJson(data);
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

        myToast(msg: 'User Block Successfully');

        Get.offNamed(neighbourchatscreen, arguments: [
          userdata,
          //Login User
          resident,
          // Resident Details
          chatNeighbours,
          chatRoomId,
          ChatTypes.NeighbourChat.toString().split('.').last,
          // Chat User
        ]);
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

        Get.offNamed(neighbourchatscreen, arguments: [
          userdata,
          //Login User
          resident,
          // Resident Details
          chatNeighbours,
          chatRoomId,
          ChatTypes.NeighbourChat.toString().split('.').last,
          // Chat User
        ]);
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

  Future<blockuser.BlockedUser?> checkBlockUserApi({
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
        blockedUser = blockuser.BlockedUser.fromJson(data);
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
    } catch (e) {
      myToast(msg: "Something went wrong ${e.toString()}", isNegative: true);
    }
  }
}
