/// data : [{"id":157,"sender":4,"receiver":5,"status":"default","created_at":"2023-07-28T12:19:12.000000Z","updated_at":"2023-07-29T07:05:55.000000Z"}]

class ChatRoomModel {
  ChatRoomModel({
    this.data,
  });

  ChatRoomModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;
  ChatRoomModel copyWith({
    List<Data>? data,
  }) =>
      ChatRoomModel(
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 157
/// sender : 4
/// receiver : 5
/// status : "default"
/// created_at : "2023-07-28T12:19:12.000000Z"
/// updated_at : "2023-07-29T07:05:55.000000Z"

class Data {
  Data({
    this.id,
    this.sender,
    this.receiver,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    sender = json['sender'];
    receiver = json['receiver'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? sender;
  int? receiver;
  String? status;
  String? createdAt;
  String? updatedAt;
  Data copyWith({
    int? id,
    int? sender,
    int? receiver,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['sender'] = sender;
    map['receiver'] = receiver;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
