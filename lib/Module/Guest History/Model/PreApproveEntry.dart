import 'dart:convert';
/// success : true
/// data : [{"id":1,"gatekeeperid":4,"userid":3,"visitortype":"Delivery","name":"ijaz khan","description":"khana le kr aah rha","cnic":"","mobileno":"090202","vechileno":"rwp","arrivaldate":"2022-11-26","arrivaltime":"12:24:00","status":3,"statusdescription":"checkout","created_at":"2022-11-26T07:24:05.000000Z","updated_at":"2022-11-26T12:25:39.000000Z"},{"id":2,"gatekeeperid":4,"userid":3,"visitortype":"Visiting Help","name":"mumtaz","description":"light set krny","cnic":"","mobileno":"0345666","vechileno":"rwp 077","arrivaldate":"2022-11-26","arrivaltime":"17:47:00","status":3,"statusdescription":"checkout","created_at":"2022-11-26T07:48:03.000000Z","updated_at":"2022-11-26T12:50:05.000000Z"},{"id":3,"gatekeeperid":4,"userid":3,"visitortype":"Guest","name":"fujvjv","description":"gggh","cnic":"643","mobileno":"086","vechileno":"hgg","arrivaldate":"2022-11-26","arrivaltime":"18:05:00","status":3,"statusdescription":"checkout","created_at":"2022-11-26T08:05:34.000000Z","updated_at":"2022-11-27T16:07:34.000000Z"},{"id":4,"gatekeeperid":4,"userid":3,"visitortype":"Cab","name":"fuzail rajput","description":"saman laa rha hai","cnic":"47905","mobileno":"03215550979","vechileno":"rwp 680","arrivaldate":"2022-11-27","arrivaltime":"16:44:00","status":3,"statusdescription":"checkout","created_at":"2022-11-27T11:44:49.000000Z","updated_at":"2022-11-27T17:11:30.000000Z"}]

PreApproveEntry preApproveEntryFromJson(String str) => PreApproveEntry.fromJson(json.decode(str));
String preApproveEntryToJson(PreApproveEntry data) => json.encode(data.toJson());
class PreApproveEntry {
  PreApproveEntry({
      bool? success, 
      List<Data>? data,}){
    _success = success;
    _data = data;
}

  PreApproveEntry.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Data>? _data;
PreApproveEntry copyWith({  bool? success,
  List<Data>? data,
}) => PreApproveEntry(  success: success ?? _success,
  data: data ?? _data,
);
  bool? get success => _success;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// gatekeeperid : 4
/// userid : 3
/// visitortype : "Delivery"
/// name : "ijaz khan"
/// description : "khana le kr aah rha"
/// cnic : ""
/// mobileno : "090202"
/// vechileno : "rwp"
/// arrivaldate : "2022-11-26"
/// arrivaltime : "12:24:00"
/// status : 3
/// statusdescription : "checkout"
/// created_at : "2022-11-26T07:24:05.000000Z"
/// updated_at : "2022-11-26T12:25:39.000000Z"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? id, 
      int? gatekeeperid, 
      int? userid, 
      String? visitortype, 
      String? name, 
      String? description, 
      String? cnic, 
      String? mobileno, 
      String? vechileno, 
      String? arrivaldate, 
      String? arrivaltime, 
      int? status, 
      String? statusdescription, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _gatekeeperid = gatekeeperid;
    _userid = userid;
    _visitortype = visitortype;
    _name = name;
    _description = description;
    _cnic = cnic;
    _mobileno = mobileno;
    _vechileno = vechileno;
    _arrivaldate = arrivaldate;
    _arrivaltime = arrivaltime;
    _status = status;
    _statusdescription = statusdescription;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _gatekeeperid = json['gatekeeperid'];
    _userid = json['userid'];
    _visitortype = json['visitortype'];
    _name = json['name'];
    _description = json['description'];
    _cnic = json['cnic'];
    _mobileno = json['mobileno'];
    _vechileno = json['vechileno'];
    _arrivaldate = json['arrivaldate'];
    _arrivaltime = json['arrivaltime'];
    _status = json['status'];
    _statusdescription = json['statusdescription'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _gatekeeperid;
  int? _userid;
  String? _visitortype;
  String? _name;
  String? _description;
  String? _cnic;
  String? _mobileno;
  String? _vechileno;
  String? _arrivaldate;
  String? _arrivaltime;
  int? _status;
  String? _statusdescription;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  int? id,
  int? gatekeeperid,
  int? userid,
  String? visitortype,
  String? name,
  String? description,
  String? cnic,
  String? mobileno,
  String? vechileno,
  String? arrivaldate,
  String? arrivaltime,
  int? status,
  String? statusdescription,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  gatekeeperid: gatekeeperid ?? _gatekeeperid,
  userid: userid ?? _userid,
  visitortype: visitortype ?? _visitortype,
  name: name ?? _name,
  description: description ?? _description,
  cnic: cnic ?? _cnic,
  mobileno: mobileno ?? _mobileno,
  vechileno: vechileno ?? _vechileno,
  arrivaldate: arrivaldate ?? _arrivaldate,
  arrivaltime: arrivaltime ?? _arrivaltime,
  status: status ?? _status,
  statusdescription: statusdescription ?? _statusdescription,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  int? get gatekeeperid => _gatekeeperid;
  int? get userid => _userid;
  String? get visitortype => _visitortype;
  String? get name => _name;
  String? get description => _description;
  String? get cnic => _cnic;
  String? get mobileno => _mobileno;
  String? get vechileno => _vechileno;
  String? get arrivaldate => _arrivaldate;
  String? get arrivaltime => _arrivaltime;
  int? get status => _status;
  String? get statusdescription => _statusdescription;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['gatekeeperid'] = _gatekeeperid;
    map['userid'] = _userid;
    map['visitortype'] = _visitortype;
    map['name'] = _name;
    map['description'] = _description;
    map['cnic'] = _cnic;
    map['mobileno'] = _mobileno;
    map['vechileno'] = _vechileno;
    map['arrivaldate'] = _arrivaldate;
    map['arrivaltime'] = _arrivaltime;
    map['status'] = _status;
    map['statusdescription'] = _statusdescription;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}