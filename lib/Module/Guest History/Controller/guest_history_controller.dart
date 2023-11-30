import 'dart:ui';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../Constants/constants.dart';
import '../../../Repo/PreApproveEntry Repository/preapproveentry_repository.dart';
import '../../Login/Model/User.dart';
import '../../Pre Approve Entry/Model/PreApproveEntry.dart';

class GuestHistoryController extends GetxController {
  static const pageSize = 6;
  final PagingController pagingController = PagingController(firstPageKey: 1);
  List<PreApproveEntry> preApproveEntryLi = [];
  List<PreApproveEntry> dataList = [];

  List<Color> pinkcard = [
    HexColor('#FF6188'),
    HexColor('#FFB199'),
  ];

  List<Color> bluecard = [
    HexColor('#4481EB'),
    HexColor('#04BEFE'),
  ];

  List<Color> greencard = [
    HexColor('#D6FF94'),
    HexColor('#3DC24B'),
  ];

  var user = Get.arguments;
  late final User userdata;
  var snapShot;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    userdata = user;
    print(userdata);
  }

  Future<List<PreApproveEntry>> preapproveEntryHistoriesApi(
      {required int userid, required String token, required pageKey}) async {
    PreApproveEntryRepository preApproveEntryRepository =
        PreApproveEntryRepository();
    await preApproveEntryRepository
        .preapproveEntryHistoriesApi(
            userid: userid, token: token, pageKey: pageKey)
        .then((val) {
      preApproveEntryLi = (val['data']['data'] as List)
          .map((e) => PreApproveEntry(
                id: e['id'],
                gatekeeperid: e['gatekeeperid'],
                userid: e['userid'],
                visitortype: e['visitortype'],
                name: e['name'],
                description: e['description'],
                cnic: e['cnic'],
                mobileno: e['mobileno'],
                vechileno: e['vechileno'],
                arrivaldate: e['arrivaldate'],
                arrivaltime: e['arrivaltime'],
                status: e['status'],
                statusdescription: e['statusdescription'],
                createdAt: e['created_at'],
                updatedAt: e['updated_at'],
                checkInTime: e['checkintime'],
                checkOutTime: e['checkouttime'],
              ))
          .toList();
    }).onError((error, stackTrace) {
      myToast(msg: error.toString(), isNegative: true);

      print(stackTrace);

      throw Exception(error);
    });
    return preApproveEntryLi;
  }

  Future<void> _fetchPage(int pageKey) async {
    dataList = await preapproveEntryHistoriesApi(
        userid: userdata.userId!,
        token: userdata.bearerToken!,
        pageKey: pageKey);

    final isLastPage = dataList!.length < pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(dataList);
    } else {
      final nextPageKey = pageKey + 1;
      pagingController.appendPage(dataList, nextPageKey);
    }
  }
}

enum CardColors { pinkcard, bluecard, greencard }
