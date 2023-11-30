import 'dart:convert';
/// success : true
/// data : [{"id":11,"residentid":7,"familymemberid":11,"subadminid":3,"created_at":"2022-12-28T09:53:45.000000Z","updated_at":"2022-12-28T11:16:14.000000Z","firstname":"hadi","lastname":"abrar","cnic":"0000","address":"djjdjd","mobileno":"123","password":"$2y$10$Xh6LCrVAgdJrIZ5.Lwv12uJMClDJ9z2RC61iwhHcL9ofhRoHI5EeW","roleid":5,"rolename":"familymember","image":"1672221225.png","fcmtoken":"fD9zugIVTVaYyxHOxJYENY:APA91bH3X-nr1GQ__jUUkqW4h-TYq45jRShoLedLWUNcY6j9kxPGkiPxzSs4mB0fJz5UzrWHZRLn8AkOKF-RjdkJPt1IuDVlo4goQma8CsPZWA4NBflB9om31lRmLkVgdU5349w-svXP"}]

Familymember familymemberFromJson(String str) => Familymember.fromJson(json.decode(str));
String familymemberToJson(Familymember data) => json.encode(data.toJson());
class Familymember {
  Familymember({
      bool? success, 
      List<Data>? data,}){
    _success = success;
    _data = data;
}

  Familymember.fromJson(dynamic json) {
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
Familymember copyWith({  bool? success,
  List<Data>? data,
}) => Familymember(  success: success ?? _success,
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

/// id : 11
/// residentid : 7
/// familymemberid : 11
/// subadminid : 3
/// created_at : "2022-12-28T09:53:45.000000Z"
/// updated_at : "2022-12-28T11:16:14.000000Z"
/// firstname : "hadi"
/// lastname : "abrar"
/// cnic : "0000"
/// address : "djjdjd"
/// mobileno : "123"
/// password : "$2y$10$Xh6LCrVAgdJrIZ5.Lwv12uJMClDJ9z2RC61iwhHcL9ofhRoHI5EeW"
/// roleid : 5
/// rolename : "familymember"
/// image : "1672221225.png"
/// fcmtoken : "fD9zugIVTVaYyxHOxJYENY:APA91bH3X-nr1GQ__jUUkqW4h-TYq45jRShoLedLWUNcY6j9kxPGkiPxzSs4mB0fJz5UzrWHZRLn8AkOKF-RjdkJPt1IuDVlo4goQma8CsPZWA4NBflB9om31lRmLkVgdU5349w-svXP"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? id, 
      int? residentid, 
      int? familymemberid, 
      int? subadminid, 
      String? createdAt, 
      String? updatedAt, 
      String? firstname, 
      String? lastname, 
      String? cnic, 
      String? address, 
      String? mobileno, 
      String? password, 
      int? roleid, 
      String? rolename, 
      String? image, 
      String? fcmtoken,}){
    _id = id;
    _residentid = residentid;
    _familymemberid = familymemberid;
    _subadminid = subadminid;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _firstname = firstname;
    _lastname = lastname;
    _cnic = cnic;
    _address = address;
    _mobileno = mobileno;
    _password = password;
    _roleid = roleid;
    _rolename = rolename;
    _image = image;
    _fcmtoken = fcmtoken;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _residentid = json['residentid'];
    _familymemberid = json['familymemberid'];
    _subadminid = json['subadminid'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _cnic = json['cnic'];
    _address = json['address'];
    _mobileno = json['mobileno'];
    _password = json['password'];
    _roleid = json['roleid'];
    _rolename = json['rolename'];
    _image = json['image'];
    _fcmtoken = json['fcmtoken'];
  }
  int? _id;
  int? _residentid;
  int? _familymemberid;
  int? _subadminid;
  String? _createdAt;
  String? _updatedAt;
  String? _firstname;
  String? _lastname;
  String? _cnic;
  String? _address;
  String? _mobileno;
  String? _password;
  int? _roleid;
  String? _rolename;
  String? _image;
  String? _fcmtoken;
Data copyWith({  int? id,
  int? residentid,
  int? familymemberid,
  int? subadminid,
  String? createdAt,
  String? updatedAt,
  String? firstname,
  String? lastname,
  String? cnic,
  String? address,
  String? mobileno,
  String? password,
  int? roleid,
  String? rolename,
  String? image,
  String? fcmtoken,
}) => Data(  id: id ?? _id,
  residentid: residentid ?? _residentid,
  familymemberid: familymemberid ?? _familymemberid,
  subadminid: subadminid ?? _subadminid,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  firstname: firstname ?? _firstname,
  lastname: lastname ?? _lastname,
  cnic: cnic ?? _cnic,
  address: address ?? _address,
  mobileno: mobileno ?? _mobileno,
  password: password ?? _password,
  roleid: roleid ?? _roleid,
  rolename: rolename ?? _rolename,
  image: image ?? _image,
  fcmtoken: fcmtoken ?? _fcmtoken,
);
  int? get id => _id;
  int? get residentid => _residentid;
  int? get familymemberid => _familymemberid;
  int? get subadminid => _subadminid;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get cnic => _cnic;
  String? get address => _address;
  String? get mobileno => _mobileno;
  String? get password => _password;
  int? get roleid => _roleid;
  String? get rolename => _rolename;
  String? get image => _image;
  String? get fcmtoken => _fcmtoken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['residentid'] = _residentid;
    map['familymemberid'] = _familymemberid;
    map['subadminid'] = _subadminid;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['cnic'] = _cnic;
    map['address'] = _address;
    map['mobileno'] = _mobileno;
    map['password'] = _password;
    map['roleid'] = _roleid;
    map['rolename'] = _rolename;
    map['image'] = _image;
    map['fcmtoken'] = _fcmtoken;
    return map;
  }

}