import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Repo/Report%20Repository/report_repository.dart';

import '../../../HomeScreen/Model/residents.dart';
import '../../../Login/Model/User.dart';
import '../../Model/Reports.dart';

class AdminReportsController extends GetxController {
  ReportRepository reportRepository = ReportRepository();

  static const pageSize = 6;
  final PagingController<int, Reports> pagingController =
      PagingController(firstPageKey: 1);
  List<Reports> reportsLi = [];
  List<Reports> dataList = [];

  var data = Get.arguments;
  Residents? resident;
  late final User user;
  bool isLoading = false;
  bool isSolved = false;

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();

    user = data[0];
    resident = data[1];
  }

  Future<List<Reports>> adminReportsApi(
      {required int userid, required String token, required pageKey}) async {
    await reportRepository
        .adminReportsApi(userid: userid, token: token, pageKey: pageKey)
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

  ProblemSolvedButtonApi(
      {required int id,
      required int userId,
      required String token,
      required int index}) async {
    isLoading = true;
    update();

    Map<String, String> data = {
      "id": id.toString(),
      "userid": userId.toString(),
      "status": 4.toString(),
      "statusdescription": 'completed',
    };

    await reportRepository.ProblemSolvedButtonApi(data: data, token: token)
        .then((val) {
      final newList = pagingController.itemList!.removeAt(index);

      myToast(msg: 'Operation Successful');

      Get.back();
      isLoading = false;
      update();
    }).onError((e, stackTrace) {
      isLoading = false;
      update();
      myToast(msg: e.toString(), isNegative: true);
      Get.back();
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    dataList = await adminReportsApi(
        userid: user.userId!, token: user.bearerToken!, pageKey: pageKey);

    final isLastPage = dataList!.length < pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(dataList);
    } else {
      final nextPageKey = pageKey + 1;
      pagingController.appendPage(dataList, nextPageKey);
    }
  }
}
