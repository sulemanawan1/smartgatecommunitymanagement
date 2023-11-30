import 'package:userapp/Constants/api_routes.dart';
import 'package:userapp/Services/Network%20Services/network_services.dart';

class HomeRepository {
  final networkServices = NetworkServices();

  Future<dynamic> updateUserNameApi(data, bearerToken) async {
    final response = await networkServices.postFormReq(Api.updateUserName, data,
        bearerToken: bearerToken);
    return response;
  }
}
