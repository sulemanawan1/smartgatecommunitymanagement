/// success : true
/// data : [{"id":3,"residentid":3,"subadminid":2,"username":"66","country":"🇵🇰    Pakistan","state":"null","city":"null","houseaddress":"Rawat Enclave,Block#1,Street#1,House#1","vechileno":"","residenttype":"Owner","propertytype":"house","visibility":"none","committeemember":0,"status":1,"created_at":"2023-11-09T17:28:59.000000Z","updated_at":"2023-11-09T17:29:47.000000Z","firstname":"Suleman","lastname":"Awan","cnic":null,"address":"Rawat Enclave,Block#1,Street#1,House#1","mobileno":"+923333333333","password":"$2y$10$HQxbqFYk0wA5SILsAwSoR.3iY6cO7LaxtevdweajsmM9ANUswhhIW","roleid":3,"rolename":"resident","image":"images/user.png","fcmtoken":"e_2UwxiZReqfevTEbqc0M0:APA91bEu27jKAlEcygHFcK_ns2tOpthUEe5pYdZReaf0mMlN9QVH4eVdSn3pay65RSKjz5YK3F9YevcUnTYN-6V53lSTq2MybAzmboVx7mj0x7w1LtVYUvC6fxSRsfYHgvp8glLMZdMe"},{"id":4,"residentid":4,"subadminid":2,"username":"sking","country":"🇵🇰    Pakistan","state":"null","city":"null","houseaddress":"Rawat Enclave,Block#1,Street#1,House#2","vechileno":"","residenttype":"Owner","propertytype":"house","visibility":"anonymous","committeemember":0,"status":1,"created_at":"2023-11-09T17:34:39.000000Z","updated_at":"2023-11-09T17:35:22.000000Z","firstname":"noman","lastname":"khan","cnic":null,"address":"Rawat Enclave,Block#1,Street#1,House#2","mobileno":"+922222222222","password":"$2y$10$LOs0FYLHNGFEQk.YJzptTu6b6OC6/DGesUzIzbcnWgqgLzOjthGUK","roleid":3,"rolename":"resident","image":"images/user.png","fcmtoken":"e_2UwxiZReqfevTEbqc0M0:APA91bF-I3JVttOA9tz73WOfwcMilBsEc7eLM5In0iqqOaGuO_w3GfNQzpPCsoPCxfiU24jJHOfKgqg1_sjvPfygiLAypBgyopaEoz04LHARyHmGPtb9yd9KYRfij6kweScEgCmWWggI"},{"id":5,"residentid":5,"subadminid":2,"username":"farri","country":"🇵🇰    Pakistan","state":"null","city":"null","houseaddress":"Rawat Enclave,Block#1,Street#1,House#3","vechileno":"","residenttype":"Owner","propertytype":"house","visibility":"none","committeemember":0,"status":1,"created_at":"2023-11-09T17:38:06.000000Z","updated_at":"2023-11-09T17:38:57.000000Z","firstname":"Farrah","lastname":"Bashir","cnic":null,"address":"Rawat Enclave,Block#1,Street#1,House#3","mobileno":"+924444444444","password":"$2y$10$srKe7kbcTtMeKyabJ7dWSuKALAwZPv1iqq2Dv6DKzHNJl5kATQQaK","roleid":3,"rolename":"resident","image":"images/user.png","fcmtoken":"e_2UwxiZReqfevTEbqc0M0:APA91bH2xjCKKjRgGckpWtYs5F7M_iySiXh74Gt_Kd6dFm6ZAi_HFADlvb5_qzuX475TfySWhoWDZv2okYLUWzYr1Z2leglKo_VV2aK9p6FKWi5q0T8hQgcft2s2Q-F9WjvjGq5Bqyx5"}]

class ChatNeighbours {
  ChatNeighbours({
    this.success,
    this.data,
  });

  ChatNeighbours.fromJson(dynamic json) {
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
  ChatNeighbours copyWith({
    bool? success,
    List<Data>? data,
  }) =>
      ChatNeighbours(
        success: success ?? this.success,
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

/// id : 3
/// residentid : 3
/// subadminid : 2
/// username : "66"
/// country : "🇵🇰    Pakistan"
/// state : "null"
/// city : "null"
/// houseaddress : "Rawat Enclave,Block#1,Street#1,House#1"
/// vechileno : ""
/// residenttype : "Owner"
/// propertytype : "house"
/// visibility : "none"
/// committeemember : 0
/// status : 1
/// created_at : "2023-11-09T17:28:59.000000Z"
/// updated_at : "2023-11-09T17:29:47.000000Z"
/// firstname : "Suleman"
/// lastname : "Awan"
/// cnic : null
/// address : "Rawat Enclave,Block#1,Street#1,House#1"
/// mobileno : "+923333333333"
/// password : "$2y$10$HQxbqFYk0wA5SILsAwSoR.3iY6cO7LaxtevdweajsmM9ANUswhhIW"
/// roleid : 3
/// rolename : "resident"
/// image : "images/user.png"
/// fcmtoken : "e_2UwxiZReqfevTEbqc0M0:APA91bEu27jKAlEcygHFcK_ns2tOpthUEe5pYdZReaf0mMlN9QVH4eVdSn3pay65RSKjz5YK3F9YevcUnTYN-6V53lSTq2MybAzmboVx7mj0x7w1LtVYUvC6fxSRsfYHgvp8glLMZdMe"

class Data {
  Data({
    this.id,
    this.residentid,
    this.subadminid,
    this.username,
    this.country,
    this.state,
    this.city,
    this.houseaddress,
    this.vechileno,
    this.residenttype,
    this.propertytype,
    this.visibility,
    this.committeemember,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.firstname,
    this.lastname,
    this.cnic,
    this.address,
    this.mobileno,
    this.password,
    this.roleid,
    this.rolename,
    this.image,
    this.fcmtoken,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    residentid = json['residentid'];
    subadminid = json['subadminid'];
    username = json['username'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    houseaddress = json['houseaddress'];
    vechileno = json['vechileno'];
    residenttype = json['residenttype'];
    propertytype = json['propertytype'];
    visibility = json['visibility'];
    committeemember = json['committeemember'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    cnic = json['cnic'];
    address = json['address'];
    mobileno = json['mobileno'];
    password = json['password'];
    roleid = json['roleid'];
    rolename = json['rolename'];
    image = json['image'];
    fcmtoken = json['fcmtoken'];
  }
  int? id;
  int? residentid;
  int? subadminid;
  String? username;
  String? country;
  String? state;
  String? city;
  String? houseaddress;
  String? vechileno;
  String? residenttype;
  String? propertytype;
  String? visibility;
  int? committeemember;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? firstname;
  String? lastname;
  dynamic cnic;
  String? address;
  String? mobileno;
  String? password;
  int? roleid;
  String? rolename;
  String? image;
  String? fcmtoken;
  Data copyWith({
    int? id,
    int? residentid,
    int? subadminid,
    String? username,
    String? country,
    String? state,
    String? city,
    String? houseaddress,
    String? vechileno,
    String? residenttype,
    String? propertytype,
    String? visibility,
    int? committeemember,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? firstname,
    String? lastname,
    dynamic cnic,
    String? address,
    String? mobileno,
    String? password,
    int? roleid,
    String? rolename,
    String? image,
    String? fcmtoken,
  }) =>
      Data(
        id: id ?? this.id,
        residentid: residentid ?? this.residentid,
        subadminid: subadminid ?? this.subadminid,
        username: username ?? this.username,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        houseaddress: houseaddress ?? this.houseaddress,
        vechileno: vechileno ?? this.vechileno,
        residenttype: residenttype ?? this.residenttype,
        propertytype: propertytype ?? this.propertytype,
        visibility: visibility ?? this.visibility,
        committeemember: committeemember ?? this.committeemember,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        cnic: cnic ?? this.cnic,
        address: address ?? this.address,
        mobileno: mobileno ?? this.mobileno,
        password: password ?? this.password,
        roleid: roleid ?? this.roleid,
        rolename: rolename ?? this.rolename,
        image: image ?? this.image,
        fcmtoken: fcmtoken ?? this.fcmtoken,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['residentid'] = residentid;
    map['subadminid'] = subadminid;
    map['username'] = username;
    map['country'] = country;
    map['state'] = state;
    map['city'] = city;
    map['houseaddress'] = houseaddress;
    map['vechileno'] = vechileno;
    map['residenttype'] = residenttype;
    map['propertytype'] = propertytype;
    map['visibility'] = visibility;
    map['committeemember'] = committeemember;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['cnic'] = cnic;
    map['address'] = address;
    map['mobileno'] = mobileno;
    map['password'] = password;
    map['roleid'] = roleid;
    map['rolename'] = rolename;
    map['image'] = image;
    map['fcmtoken'] = fcmtoken;
    return map;
  }
}
