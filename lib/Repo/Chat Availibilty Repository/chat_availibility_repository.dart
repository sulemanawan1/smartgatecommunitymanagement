import '../../Constants/api_routes.dart';
import '../../Module/Chat Availbility/Model/ChatNeighbours.dart';
import '../../Module/Chat Availbility/Model/ChatRoomModel.dart';
import '../../Services/Network Services/network_services.dart';

class ChatAvailibilityRepository {
  final networkServices = NetworkServices();

  Future<ChatNeighbours> viewChatNeighboursApi(
      {required bearerToken, required subadminid}) async {
    final response = await networkServices.getReq(
        Api.chatNeighbours + "/" + subadminid.toString(),
        bearerToken: bearerToken);

    return ChatNeighbours.fromJson(response);
  }

  Future<ChatRoomModel> createChatRoomApi(
      {required bearerToken, required data}) async {
    final response = await networkServices.postFormReq(Api.createChatRoom, data,
        bearerToken: bearerToken);

    return ChatRoomModel.fromJson(response);
  }
}
