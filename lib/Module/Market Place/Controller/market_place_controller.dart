import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/Constants/api_routes.dart';

import '../../Chat Availbility/Model/ChatNeighbours.dart';
import '../../Chat Availbility/Model/ChatRoomModel.dart';
import '../../Login/Model/User.dart';
import '../Model/MarketPlace.dart' as marketplace;

class MarketPlaceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var data = Get.arguments;
  late final User userdata;
  var resident;
  var selectedIndex = 0.obs;
  int? index;

  RxString status = ''.obs;
  RxString selectedCategory = 'All'.obs;
  late Future sellProductFutureData;
  late Future viewProductFutureData;
  RxString categoryTypeDropDownValue = ''.obs;
  RxList<Categories> categoryList = [
    Categories(name: 'All', selected: false),
    Categories(name: 'Antiques', selected: false),
    Categories(name: 'Appliances', selected: false),
    Categories(name: 'Arts & Crafts', selected: false),
    Categories(name: 'Vechile', selected: false),
    Categories(name: 'Auto Parts', selected: false),
    Categories(name: 'Baby & Kids', selected: false),
    Categories(name: 'Beauty & Personal Care', selected: false),
    Categories(name: 'Bicycles', selected: false),
    Categories(name: 'Books', selected: false),
    Categories(name: 'Cell Phones', selected: false),
    Categories(name: 'Clothing & Accessories', selected: false),
    Categories(name: 'Collectibles', selected: false),
    Categories(name: 'Computers & Accessories', selected: false),
    Categories(name: 'Electronics', selected: false),
    Categories(name: 'Furniture', selected: false),
    Categories(name: 'Games & Toys', selected: false),
    Categories(name: 'Home & Garden', selected: false),
    Categories(name: 'Jewelry & Watches', selected: false),
    Categories(name: 'Musical Instruments', selected: false),
    Categories(name: 'Outdoor & Camping', selected: false),
    Categories(name: 'Pet Supplies', selected: false),
    Categories(name: 'Sporting Goods', selected: false),
    Categories(name: 'Tickets', selected: false),
    Categories(name: 'Tools & Machinery', selected: false),
    Categories(name: 'Video Games & Consoles', selected: false),
    Categories(name: 'Other', selected: false),
  ].obs;

  RxList<marketplace.Data> list = <marketplace.Data>[].obs;
  RxList<marketplace.Data> list2 = <marketplace.Data>[].obs;

  late TabController tabController;
  Uri? uri;
  List<MarketPlaceGridModel> marketPlaceList = [
    MarketPlaceGridModel(
        icon: "assets/market_place_buy_icon.svg",
        heading: 'Buy',
        color: '#FF9900',
        textColor: '#FFFFFF'),
    MarketPlaceGridModel(
        icon: 'assets/market_place_sell_icon.svg',
        heading: 'Sell',
        color: "#FFFFFF",
        textColor: '#0D0B0C'),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        selectedIndex.value = tabController.index;
      });

    userdata = data[0];
    resident = data[1];

    viewProductFutureData = viewProducts(
        societyid: resident.societyid!,
        token: userdata.bearerToken!,
        category: 'All');

    sellProductFutureData = viewSellProductsResidnet(
        residentid: resident.residentid!, token: userdata.bearerToken!);
  }

  viewProducts(
      {required int societyid,
      required String token,
      required String category}) async {
    list.value.clear();
    final response = await Http.get(
      Uri.parse(Api.viewProducts + "/" + societyid.toString() + "/" + category),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );

    var data = jsonDecode(response.body.toString());

    print(response.body);

    if (response.statusCode == 200) {
      final marketplace.MarketPlace marketPlace =
          marketplace.MarketPlace.fromJson(data);

      list.value = marketPlace.data!;
      list.refresh();

      return list;
    }
    final marketplace.MarketPlace marketPlace =
        marketplace.MarketPlace.fromJson(data);

    list.value = marketPlace.data!;

    list.refresh();

    return list;
  }

  viewSellProductsResidnet(
      {required int residentid, required String token}) async {
    print(token);

    list2.value.clear();
    final response = await Http.get(
      Uri.parse(Api.viewSellProductsResidnet + "/" + residentid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    print('data');
    print(response.body);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      final marketplace.MarketPlace marketPlace =
          marketplace.MarketPlace.fromJson(data);

      list2.value = marketPlace.data!;
      list2.refresh();
      return list2;
    }

    final marketplace.MarketPlace marketPlace =
        marketplace.MarketPlace.fromJson(data);

    list2.value = marketPlace.data!;
    list2.refresh();
    return list2;
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
        "sender": userid,
        "receiver": chatuserid,
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return ChatRoomModel.fromJson(data);
    } else {
      return ChatRoomModel.fromJson(data);
    }
  }

  Future<ChatNeighbours> productSellerInfoApi(
      {required int residentid, required String token}) async {
    print(token);

    final response = await Http.get(
      Uri.parse(Api.productSellerInfo + "/" + residentid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());

    ;

    if (response.statusCode == 200) {
      return ChatNeighbours.fromJson(data);
    }

    return ChatNeighbours.fromJson(data);
  }

  void onSelected({required index}) {
    selectedIndex.value = index;
  }

  productStatus({
    required String token,
    required int id,
    required String status,
  }) async {
    final response = await Http.post(
      Uri.parse(Api.productStatus),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "status": status,
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      list.clear();
      list2.clear();
      viewProductFutureData = viewProducts(
          societyid: resident.societyid!,
          token: userdata.bearerToken!,
          category: 'All');

      sellProductFutureData = viewSellProductsResidnet(
          residentid: resident.residentid!, token: userdata.bearerToken!);
    } else {}
  }
}

class Categories {
  String? name;
  bool? selected;

  Categories({required this.name, required this.selected});
}

class MarketPlaceGridModel {
  final String? icon;
  final String? heading;
  final String? color;
  final String? textColor;

  MarketPlaceGridModel(
      {required this.icon,
      required this.heading,
      required this.color,
      this.textColor});
}
