/// success : true
/// data : {"id":18,"userid":12,"blockeduserid":17,"chatroomid":12,"created_at":"2023-10-10T10:25:15.000000Z","updated_at":"2023-10-10T10:25:15.000000Z"}
/// message : "chatroom-found"

class BlockedUser {
  BlockedUser({
    this.success,
    this.data,
    this.message,
  });

  BlockedUser.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
  bool? success;
  Data? data;
  String? message;
  BlockedUser copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      BlockedUser(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    return map;
  }
}

/// id : 18
/// userid : 12
/// blockeduserid : 17
/// chatroomid : 12
/// created_at : "2023-10-10T10:25:15.000000Z"
/// updated_at : "2023-10-10T10:25:15.000000Z"

class Data {
  Data({
    this.id,
    this.userid,
    this.blockeduserid,
    this.chatroomid,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    userid = json['userid'];
    blockeduserid = json['blockeduserid'];
    chatroomid = json['chatroomid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userid;
  int? blockeduserid;
  int? chatroomid;
  String? createdAt;
  String? updatedAt;
  Data copyWith({
    int? id,
    int? userid,
    int? blockeduserid,
    int? chatroomid,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        userid: userid ?? this.userid,
        blockeduserid: blockeduserid ?? this.blockeduserid,
        chatroomid: chatroomid ?? this.chatroomid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userid'] = userid;
    map['blockeduserid'] = blockeduserid;
    map['chatroomid'] = chatroomid;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
