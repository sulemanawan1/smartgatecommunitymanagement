/// data : [{"id":5,"creator":2,"created_at":"2023-03-28T18:44:45.000000Z","updated_at":"2023-03-28T18:44:45.000000Z"}]

class DiscussionRoomModel {
  DiscussionRoomModel({
      List<Data>? data,}){
    _data = data;
}

  DiscussionRoomModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? _data;
DiscussionRoomModel copyWith({  List<Data>? data,
}) => DiscussionRoomModel(  data: data ?? _data,
);
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 5
/// creator : 2
/// created_at : "2023-03-28T18:44:45.000000Z"
/// updated_at : "2023-03-28T18:44:45.000000Z"

class Data {
  Data({
      int? id, 
      int? creator, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _creator = creator;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _creator = json['creator'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _creator;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  int? id,
  int? creator,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  creator: creator ?? _creator,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  int? get creator => _creator;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['creator'] = _creator;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}