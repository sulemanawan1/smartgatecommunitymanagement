import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/Constants/constants.dart';

import '../../../Constants/api_routes.dart';
import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';
import '../Model/BillModel.dart';

class MonthlyBillsController extends GetxController {
  late DateTime dueDate;
  bool isLoading = false;

  var data = Get.arguments;
  late final User userdata;
  late final Residents resident;
  late Future<BillModel> futureData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userdata = data[0];
    resident = data[1];

    futureData = monthlyBillsApi(
        userid: resident.residentid!, token: userdata.bearerToken!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<BillModel> monthlyBillsApi(
      {required int userid, required String token}) async {
    final response = await Http.get(
      Uri.parse(Api.monthlyBills + "/" + userid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return BillModel.fromJson(data);
    } else {
      throw Exception("Failed to load Bill");
    }
  }

  payBillApi(
      {required int id,
      required String token,
      required totalPaidAmount}) async {
    isLoading = true;
    update();
    final response = await Http.post(
      Uri.parse(Api.payBill),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "paymenttype": 'Through App',
        "totalpaidamount": totalPaidAmount
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      futureData = monthlyBillsApi(
          userid: resident.residentid!, token: userdata.bearerToken!);
      isLoading = false;
      update();
      myToast(msg: "Bill Paid Successfully");
    } else {
      isLoading = false;
      update();
      myToast(msg: "Failed to Pay bill", isNegative: true);
    }
  }
}
