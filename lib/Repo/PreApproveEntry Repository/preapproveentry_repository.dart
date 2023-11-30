import '../../Constants/api_routes.dart';
import '../../Services/Network Services/network_services.dart';

class PreApproveEntryRepository {
  final networkServices = NetworkServices();

  Future<dynamic> viewPreApproveEntryReportsApi(
      {required int userid, required String token, required pageKey}) async {
    final response = await networkServices.getReq(
        Api.viewPreApproveEntryReports +
            "/" +
            userid.toString() +
            "?page=" +
            pageKey.toString(),
        bearerToken: token);

    return response;
  }

  Future<dynamic> preapproveEntryHistoriesApi(
      {required int userid, required String token, required pageKey}) async {
    final response = await networkServices.getReq(
        Api.preApproveEntryHistories +
            "/" +
            userid.toString() +
            "?page=" +
            pageKey.toString(),
        bearerToken: token);

    return response;
  }
}
