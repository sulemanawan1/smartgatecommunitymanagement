import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';

import '../../../Constants/api_routes.dart';
import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';
import '../Model/Event.dart';

class EventScreenController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();
  var user = Get.arguments;
  late final User userdata;
  late final Residents resident;
  var snapShot;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userdata = user[0];
    resident = user[1];
  }

  Future<Event> viewEventsApi(
      {required int userid, required String token}) async {
    print("${userid.toString()}");
    print(token);

    final response = await Http.get(
      Uri.parse(Api.viewEvents + "/" + userid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());

    ;

    if (response.statusCode == 200) {
      return Event.fromJson(data);
    }

    return Event.fromJson(data);
  }
}
