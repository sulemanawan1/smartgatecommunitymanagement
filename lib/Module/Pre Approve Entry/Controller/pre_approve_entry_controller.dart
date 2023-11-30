import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Repo/PreApproveEntry%20Repository/preapproveentry_repository.dart';

import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';
import '../Model/PreApproveEntry.dart';

class PreApproveEntryController extends GetxController {
  static const pageSize = 6;
  final PagingController pagingController = PagingController(firstPageKey: 1);
  List<PreApproveEntry> preApproveEntryLi = [];
  List<PreApproveEntry> dataList = [];

  late final User userdata;
  late final Residents resident;
  var data = Get.arguments;

  var snapShot;
  TextEditingController searchController = TextEditingController();
  String? query;
  Timer? debouncer;
  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    debouncer?.cancel();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    userdata = data[0];
    resident = data[1];
  }

  Future<List<PreApproveEntry>> viewPreApproveEntryReportsApi(
      {required int userid, required String token, required pageKey}) async {
    PreApproveEntryRepository preApproveEntryRepository =
        PreApproveEntryRepository();
    await preApproveEntryRepository
        .viewPreApproveEntryReportsApi(
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
                checkInTime: e['checkintime'] ?? "N/A",
                checkOutTime: e['checkouttime'] ?? "N/A",
              ))
          .toList();
    }).onError((error, stackTrace) {
      myToast(msg: error.toString(), isNegative: true);
      throw Exception(error);
    });
    return preApproveEntryLi;
  }

  Future<void> _fetchPage(int pageKey) async {
    dataList = await viewPreApproveEntryReportsApi(
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
