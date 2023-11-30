/// data : [{"id":17,"userid":2,"title":"basast festival","description":"first event in a sociey... i invite u alll","startdate":"2002-11-02","enddate":"2022-03-03","starttime":"12:00:00","endtime":"12:00:00","active":0,"created_at":"2023-10-23T05:39:14.000000Z","updated_at":"2023-10-23T05:39:14.000000Z"},{"id":6,"userid":2,"title":"basast festival","description":"first event in a sociey... i invite u alll","startdate":"2002-11-02","enddate":"2022-03-03","starttime":null,"endtime":null,"active":0,"created_at":"2023-10-05T08:25:29.000000Z","updated_at":"2023-10-05T08:25:29.000000Z"}]

class Event {
  Event({
    this.data,
  });

  Event.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;
  Event copyWith({
    List<Data>? data,
  }) =>
      Event(
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

/// id : 17
/// userid : 2
/// title : "basast festival"
/// description : "first event in a sociey... i invite u alll"
/// startdate : "2002-11-02"
/// enddate : "2022-03-03"
/// starttime : "12:00:00"
/// endtime : "12:00:00"
/// active : 0
/// created_at : "2023-10-23T05:39:14.000000Z"
/// updated_at : "2023-10-23T05:39:14.000000Z"

class Data {
  Data({
    this.id,
    this.userid,
    this.title,
    this.description,
    this.startdate,
    this.enddate,
    this.starttime,
    this.endtime,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    userid = json['userid'];
    title = json['title'];
    description = json['description'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userid;
  String? title;
  String? description;
  String? startdate;
  String? enddate;
  String? starttime;
  String? endtime;
  int? active;
  String? createdAt;
  String? updatedAt;
  Data copyWith({
    int? id,
    int? userid,
    String? title,
    String? description,
    String? startdate,
    String? enddate,
    String? starttime,
    String? endtime,
    int? active,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        userid: userid ?? this.userid,
        title: title ?? this.title,
        description: description ?? this.description,
        startdate: startdate ?? this.startdate,
        enddate: enddate ?? this.enddate,
        starttime: starttime ?? this.starttime,
        endtime: endtime ?? this.endtime,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userid'] = userid;
    map['title'] = title;
    map['description'] = description;
    map['startdate'] = startdate;
    map['enddate'] = enddate;
    map['starttime'] = starttime;
    map['endtime'] = endtime;
    map['active'] = active;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
