import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:intl/intl.dart';
import 'package:userapp/Module/HomeScreen/Model/DiscussionRoomModel.dart' as D;

import '../../../Constants/api_routes.dart';
import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart' as U;
import '../Model/DiscussionChatModel.dart';

class DiscussionFormController extends GetxController {
  late final U.User user;
  late final Residents resident;
  late final D.DiscussionRoomModel discussionRoomModel;
  var data = Get.arguments;
  List<DiscussionChatModel> myList = [];
  final TextEditingController msg = TextEditingController();

  StreamController<List<DiscussionChatModel>> discussionChatStreamController =
      StreamController<List<DiscussionChatModel>>.broadcast();

  // Future<void> _initiatePusherSocketForMessaging() async {
  //   pusher = PusherClient(
  //       YOUR_APP_KEY,
  //       PusherOptions(
  //         host: 'http://192.168.100.7:8000',
  //         cluster: 'ap2',
  //         auth: PusherAuth(
  //           'http://192.168.100.7:8000',
  //           headers: {
  //             'Authorization': 'Bearer ${user.bearerToken}',
  //             'Content-Type': 'application/json'
  //           },
  //         ),
  //       ),
  //       autoConnect: false);
  //
  //   pusher.connect();
  //
  //   pusher.onConnectionStateChange((state) {
  //     print(
  //         "previousState: ${state!.previousState}, currentState: ${state.currentState}");
  //   });
  //
  //   pusher.onConnectionError((error) {
  //     print("error: ${error!.message}");
  //   });
  //
  //   Channel channel = pusher.subscribe('channel');
  //
  //   channel.bind('event', (PusherEvent? event) {
  //     print('event data: ' + event!.data.toString());
  //
  //     print(event!.data.toString());
  //
  //     var data = jsonDecode(event!.data.toString());
  //
  //     var mydata=data['message']['original'];
  //
  //
  //     myList.add(DiscussionChatModel.fromJson(mydata));
  //
  //     discussionChatStreamController.sink.add(myList);
  //
  //
  //
  //
  //
  //   });
  //
  // }

  @override
  void onInit() async {
    // TODO: implement onInit

    super.onInit();

    user = data[0];
    resident = data[1];
    discussionRoomModel = data[2];

    // _initiatePusherSocketForMessaging();
    // allDiscussionChatsApi(token: user!.bearerToken!,discussionroomid:discussionRoomModel?.data?.first.id );
  }

  String getFormattedDate() {
    var now = DateTime.now();
    var twelveHour = DateFormat('h:mm a');
    return twelveHour.format(now);
  }

  Future discussionchatsApi({
    required String token,
    required int residentid,
    required int? discussionroomid,
    required String message,
  }) async {
    print(residentid);

    msg.text = '';

    final response = await Http.post(
      Uri.parse(Api.discussionChats),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "discussionroomid": discussionroomid,
        "message": message,
        "residentid": residentid,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      print(response.statusCode);
    }
  }

//  allDiscussionChatsApi(
//       {required int? discussionroomid,
//         required String token}) async {
//     print(token);
//     print("hello");
//
//     final response = await Http.get(
//       Uri.parse(Api.alldiscussionchats +
//           "/" +
//           discussionroomid.toString() ),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': "Bearer $token"
//       },
//     );
//     var data = jsonDecode(response.body.toString());
//     if (response.statusCode == 200) {
//
//
//
// myList.add(DiscussionChatModel.fromJson(data));
// discussionChatStreamController.sink.add(myList);
//
//
//
//
//     }
//
//     myList.add(DiscussionChatModel.fromJson(data));
//     discussionChatStreamController.sink.add(myList);
//
//
//
//
//    }
//
}
