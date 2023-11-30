/// success : true
/// data : [{"id":7,"residentid":5,"societyid":1,"subadminid":2,"productname":"Car","description":"2014 model","productprice":"1 lac","contact":"","category":"","condition":"","status":"forsale","created_at":"2023-07-08T06:42:37.000000Z","updated_at":"2023-07-08T06:42:37.000000Z","users":{"id":5,"firstname":"Haadi","lastname":"Abrar","cnic":"3","address":"Rawat Enclave,block#1,street#1,house#1","mobileno":"03231","roleid":3,"rolename":"resident","image":"images/user.png","fcmtoken":"cyXbEeZaQ_uSZjL_CMvdns:APA91bFKUg8QoLGZI0KB2dEJdd-aYpUa0Kt5oRtqb31l0LjBlP7cvmvQCx9fFx0knc_lrhW2JKLmcg7wpc1oE0pkglp-uTnsRY_kv5p2znHwDI4o52Ziv9cRxoUrQeY4FhWFoSSQEgN1","created_at":"2023-07-07T17:03:31.000000Z","updated_at":"2023-07-07T17:05:22.000000Z"},"residents":{"id":1,"residentid":5,"subadminid":2,"country":"🇵🇰    Pakistan","state":"null","city":"null","houseaddress":"Rawat Enclave,block#1,street#1,house#1","vechileno":"","residenttype":"Owner","propertytype":"house","committeemember":0,"status":1,"created_at":"2023-07-07T17:04:03.000000Z","updated_at":"2023-07-07T17:05:22.000000Z"},"images":[{"id":6,"marketplaceid":7,"images":"1688798557.jpg","created_at":"2023-07-08T06:42:37.000000Z","updated_at":"2023-07-08T06:42:37.000000Z"}]}]

class MarketPlace {
  MarketPlace({
    this.success,
    this.data,
  });

  MarketPlace.fromJson(dynamic json) {
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
  MarketPlace copyWith({
    bool? success,
    List<Data>? data,
  }) =>
      MarketPlace(
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

/// id : 7
/// residentid : 5
/// societyid : 1
/// subadminid : 2
/// productname : "Car"
/// description : "2014 model"
/// productprice : "1 lac"
/// contact : ""
/// category : ""
/// condition : ""
/// status : "forsale"
/// created_at : "2023-07-08T06:42:37.000000Z"
/// updated_at : "2023-07-08T06:42:37.000000Z"
/// users : {"id":5,"firstname":"Haadi","lastname":"Abrar","cnic":"3","address":"Rawat Enclave,block#1,street#1,house#1","mobileno":"03231","roleid":3,"rolename":"resident","image":"images/user.png","fcmtoken":"cyXbEeZaQ_uSZjL_CMvdns:APA91bFKUg8QoLGZI0KB2dEJdd-aYpUa0Kt5oRtqb31l0LjBlP7cvmvQCx9fFx0knc_lrhW2JKLmcg7wpc1oE0pkglp-uTnsRY_kv5p2znHwDI4o52Ziv9cRxoUrQeY4FhWFoSSQEgN1","created_at":"2023-07-07T17:03:31.000000Z","updated_at":"2023-07-07T17:05:22.000000Z"}
/// residents : {"id":1,"residentid":5,"subadminid":2,"country":"🇵🇰    Pakistan","state":"null","city":"null","houseaddress":"Rawat Enclave,block#1,street#1,house#1","vechileno":"","residenttype":"Owner","propertytype":"house","committeemember":0,"status":1,"created_at":"2023-07-07T17:04:03.000000Z","updated_at":"2023-07-07T17:05:22.000000Z"}
/// images : [{"id":6,"marketplaceid":7,"images":"1688798557.jpg","created_at":"2023-07-08T06:42:37.000000Z","updated_at":"2023-07-08T06:42:37.000000Z"}]

class Data {
  Data({
    this.id,
    this.residentid,
    this.societyid,
    this.subadminid,
    this.productname,
    this.description,
    this.productprice,
    this.contact,
    this.category,
    this.condition,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.users,
    this.residents,
    this.images,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    residentid = json['residentid'];
    societyid = json['societyid'];
    subadminid = json['subadminid'];
    productname = json['productname'];
    description = json['description'];
    productprice = json['productprice'];
    contact = json['contact'];
    category = json['category'];
    condition = json['condition'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
    residents = json['residents'] != null
        ? Residents.fromJson(json['residents'])
        : null;
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }
  int? id;
  int? residentid;
  int? societyid;
  int? subadminid;
  String? productname;
  String? description;
  String? productprice;
  String? contact;
  String? category;
  String? condition;
  String? status;
  String? createdAt;
  String? updatedAt;
  Users? users;
  Residents? residents;
  List<Images>? images;
  Data copyWith({
    int? id,
    int? residentid,
    int? societyid,
    int? subadminid,
    String? productname,
    String? description,
    String? productprice,
    String? contact,
    String? category,
    String? condition,
    String? status,
    String? createdAt,
    String? updatedAt,
    Users? users,
    Residents? residents,
    List<Images>? images,
  }) =>
      Data(
        id: id ?? this.id,
        residentid: residentid ?? this.residentid,
        societyid: societyid ?? this.societyid,
        subadminid: subadminid ?? this.subadminid,
        productname: productname ?? this.productname,
        description: description ?? this.description,
        productprice: productprice ?? this.productprice,
        contact: contact ?? this.contact,
        category: category ?? this.category,
        condition: condition ?? this.condition,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        users: users ?? this.users,
        residents: residents ?? this.residents,
        images: images ?? this.images,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['residentid'] = residentid;
    map['societyid'] = societyid;
    map['subadminid'] = subadminid;
    map['productname'] = productname;
    map['description'] = description;
    map['productprice'] = productprice;
    map['contact'] = contact;
    map['category'] = category;
    map['condition'] = condition;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (users != null) {
      map['users'] = users?.toJson();
    }
    if (residents != null) {
      map['residents'] = residents?.toJson();
    }
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 6
/// marketplaceid : 7
/// images : "1688798557.jpg"
/// created_at : "2023-07-08T06:42:37.000000Z"
/// updated_at : "2023-07-08T06:42:37.000000Z"

class Images {
  Images({
    this.id,
    this.marketplaceid,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  Images.fromJson(dynamic json) {
    id = json['id'];
    marketplaceid = json['marketplaceid'];
    images = json['images'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? marketplaceid;
  String? images;
  String? createdAt;
  String? updatedAt;
  Images copyWith({
    int? id,
    int? marketplaceid,
    String? images,
    String? createdAt,
    String? updatedAt,
  }) =>
      Images(
        id: id ?? this.id,
        marketplaceid: marketplaceid ?? this.marketplaceid,
        images: images ?? this.images,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['marketplaceid'] = marketplaceid;
    map['images'] = images;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

/// id : 1
/// residentid : 5
/// subadminid : 2
/// country : "🇵🇰    Pakistan"
/// state : "null"
/// city : "null"
/// houseaddress : "Rawat Enclave,block#1,street#1,house#1"
/// vechileno : ""
/// residenttype : "Owner"
/// propertytype : "house"
/// committeemember : 0
/// status : 1
/// created_at : "2023-07-07T17:04:03.000000Z"
/// updated_at : "2023-07-07T17:05:22.000000Z"

class Residents {
  Residents({
    this.id,
    this.residentid,
    this.subadminid,
    this.country,
    this.state,
    this.city,
    this.houseaddress,
    this.vechileno,
    this.residenttype,
    this.propertytype,
    this.committeemember,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Residents.fromJson(dynamic json) {
    id = json['id'];
    residentid = json['residentid'];
    subadminid = json['subadminid'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    houseaddress = json['houseaddress'];
    vechileno = json['vechileno'];
    residenttype = json['residenttype'];
    propertytype = json['propertytype'];
    committeemember = json['committeemember'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? residentid;
  int? subadminid;
  String? country;
  String? state;
  String? city;
  String? houseaddress;
  String? vechileno;
  String? residenttype;
  String? propertytype;
  int? committeemember;
  int? status;
  String? createdAt;
  String? updatedAt;
  Residents copyWith({
    int? id,
    int? residentid,
    int? subadminid,
    String? country,
    String? state,
    String? city,
    String? houseaddress,
    String? vechileno,
    String? residenttype,
    String? propertytype,
    int? committeemember,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      Residents(
        id: id ?? this.id,
        residentid: residentid ?? this.residentid,
        subadminid: subadminid ?? this.subadminid,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        houseaddress: houseaddress ?? this.houseaddress,
        vechileno: vechileno ?? this.vechileno,
        residenttype: residenttype ?? this.residenttype,
        propertytype: propertytype ?? this.propertytype,
        committeemember: committeemember ?? this.committeemember,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['residentid'] = residentid;
    map['subadminid'] = subadminid;
    map['country'] = country;
    map['state'] = state;
    map['city'] = city;
    map['houseaddress'] = houseaddress;
    map['vechileno'] = vechileno;
    map['residenttype'] = residenttype;
    map['propertytype'] = propertytype;
    map['committeemember'] = committeemember;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

/// id : 5
/// firstname : "Haadi"
/// lastname : "Abrar"
/// cnic : "3"
/// address : "Rawat Enclave,block#1,street#1,house#1"
/// mobileno : "03231"
/// roleid : 3
/// rolename : "resident"
/// image : "images/user.png"
/// fcmtoken : "cyXbEeZaQ_uSZjL_CMvdns:APA91bFKUg8QoLGZI0KB2dEJdd-aYpUa0Kt5oRtqb31l0LjBlP7cvmvQCx9fFx0knc_lrhW2JKLmcg7wpc1oE0pkglp-uTnsRY_kv5p2znHwDI4o52Ziv9cRxoUrQeY4FhWFoSSQEgN1"
/// created_at : "2023-07-07T17:03:31.000000Z"
/// updated_at : "2023-07-07T17:05:22.000000Z"

class Users {
  Users({
    this.id,
    this.firstname,
    this.lastname,
    this.cnic,
    this.address,
    this.mobileno,
    this.roleid,
    this.rolename,
    this.image,
    this.fcmtoken,
    this.createdAt,
    this.updatedAt,
  });

  Users.fromJson(dynamic json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    cnic = json['cnic'];
    address = json['address'];
    mobileno = json['mobileno'];
    roleid = json['roleid'];
    rolename = json['rolename'];
    image = json['image'];
    fcmtoken = json['fcmtoken'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? firstname;
  String? lastname;
  String? cnic;
  String? address;
  String? mobileno;
  int? roleid;
  String? rolename;
  String? image;
  String? fcmtoken;
  String? createdAt;
  String? updatedAt;
  Users copyWith({
    int? id,
    String? firstname,
    String? lastname,
    String? cnic,
    String? address,
    String? mobileno,
    int? roleid,
    String? rolename,
    String? image,
    String? fcmtoken,
    String? createdAt,
    String? updatedAt,
  }) =>
      Users(
        id: id ?? this.id,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        cnic: cnic ?? this.cnic,
        address: address ?? this.address,
        mobileno: mobileno ?? this.mobileno,
        roleid: roleid ?? this.roleid,
        rolename: rolename ?? this.rolename,
        image: image ?? this.image,
        fcmtoken: fcmtoken ?? this.fcmtoken,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['cnic'] = cnic;
    map['address'] = address;
    map['mobileno'] = mobileno;
    map['roleid'] = roleid;
    map['rolename'] = rolename;
    map['image'] = image;
    map['fcmtoken'] = fcmtoken;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
