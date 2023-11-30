/// success : true
/// data : [{"id":2,"noticetitle":"water issue","noticedetail":"kal society mse oani ni hoga","startdate":"2023-06-27","enddate":"2023-06-30","starttime":"09:25:00","endtime":"16:25:00","status":0,"subadminid":2,"created_at":"2023-06-27T16:25:33.000000Z","updated_at":"2023-06-27T16:25:33.000000Z"},{"id":3,"noticetitle":"Mny kya bola apko mny kch bola bss sae ha ap ny mzak kia mny bardasht krlia baat khtm","noticedetail":"Mny kya bola apko mny kch bola bss sae ha ap ny mzak kia mny bardasht krlia baat khtm","startdate":"2023-06-27","enddate":"2023-06-30","starttime":"01:34:00","endtime":"17:34:00","status":0,"subadminid":2,"created_at":"2023-06-27T16:34:30.000000Z","updated_at":"2023-06-27T16:34:30.000000Z"}]

class NoticeBoardModel {
  NoticeBoardModel({
      this.success, 
      this.data,});

  NoticeBoardModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  List<Data>? data;
NoticeBoardModel copyWith({  bool? success,
  List<Data>? data,
}) => NoticeBoardModel(  success: success ?? this.success,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// noticetitle : "water issue"
/// noticedetail : "kal society mse oani ni hoga"
/// startdate : "2023-06-27"
/// enddate : "2023-06-30"
/// starttime : "09:25:00"
/// endtime : "16:25:00"
/// status : 0
/// subadminid : 2
/// created_at : "2023-06-27T16:25:33.000000Z"
/// updated_at : "2023-06-27T16:25:33.000000Z"

class Data {
  Data({
      this.id, 
      this.noticetitle, 
      this.noticedetail, 
      this.startdate, 
      this.enddate, 
      this.starttime, 
      this.endtime, 
      this.status, 
      this.subadminid, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    noticetitle = json['noticetitle'];
    noticedetail = json['noticedetail'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    status = json['status'];
    subadminid = json['subadminid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? noticetitle;
  String? noticedetail;
  String? startdate;
  String? enddate;
  String? starttime;
  String? endtime;
  int? status;
  int? subadminid;
  String? createdAt;
  String? updatedAt;
Data copyWith({  int? id,
  String? noticetitle,
  String? noticedetail,
  String? startdate,
  String? enddate,
  String? starttime,
  String? endtime,
  int? status,
  int? subadminid,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? this.id,
  noticetitle: noticetitle ?? this.noticetitle,
  noticedetail: noticedetail ?? this.noticedetail,
  startdate: startdate ?? this.startdate,
  enddate: enddate ?? this.enddate,
  starttime: starttime ?? this.starttime,
  endtime: endtime ?? this.endtime,
  status: status ?? this.status,
  subadminid: subadminid ?? this.subadminid,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['noticetitle'] = noticetitle;
    map['noticedetail'] = noticedetail;
    map['startdate'] = startdate;
    map['enddate'] = enddate;
    map['starttime'] = starttime;
    map['endtime'] = endtime;
    map['status'] = status;
    map['subadminid'] = subadminid;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}