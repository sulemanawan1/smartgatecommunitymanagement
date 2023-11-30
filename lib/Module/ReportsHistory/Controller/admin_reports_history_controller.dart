import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Constants/constants.dart';

import '../../../Repo/Report Repository/report_repository.dart';
import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';
import '../../Report to Sub Admin/Model/Reports.dart';

class ReportHistoryController extends GetxController {
  static const pageSize = 6;
  final PagingController pagingController = PagingController(firstPageKey: 1);
  List<Reports> reportsLi = [];
  List<Reports> dataList = [];

  var arguments = Get.arguments;
  late final User user;
  late final Residents resident;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    user = arguments[0];
    resident = arguments[1];
  }

  ViewAdminReportsHistoryApi(
      {required int subAdminId,
      required int userId,
      required String token,
      required int pageKey}) async {
    ReportRepository reportRepository = ReportRepository();

    await reportRepository.ViewAdminReportsHistoryApi(
            userId: userId,
            token: token,
            pageKey: pageKey,
            subAdminId: subAdminId)
        .then((val) {
      reportsLi = (val['data']['data'] as List)
          .map((e) => Reports(
              title: e['title'],
              id: e['id'],
              userid: e['userid'],
              description: e['description'],
              status: e['status'],
              statusdescription: e['statusdescription'],
              createdAt: e['created_at'],
              updatedAt: e['updated_at'],
              subadminid: e['subadminid']))
          .toList();
    }).onError((error, stackTrace) {
      myToast(msg: error.toString(), isNegative: true);
      throw Exception(error);
    });

    return reportsLi;
  }

  Future<void> _fetchPage(int pageKey) async {
    dataList = await ViewAdminReportsHistoryApi(
        userId: user.userId!,
        token: user.bearerToken!,
        pageKey: pageKey,
        subAdminId: resident.subadminid!);

    final isLastPage = dataList!.length < pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(dataList);
    } else {
      final nextPageKey = pageKey + 1;
      pagingController.appendPage(dataList, nextPageKey);
    }
  }
}
