/// success : true
/// data : {"id":26,"charges":"5000.00","latecharges":"150.00","appcharges":"50.00","tax":"0.00","balance":"5050.00","payableamount":"5050.00","totalpaidamount":"0.00","subadminid":2,"residentid":13,"propertyid":3,"measurementid":1,"duedate":"2023-07-15","billstartdate":"2023-06-01","billenddate":"2023-06-30","month":"June 2023","billtype":"house","paymenttype":"NA","status":"unpaid","isbilllate":0,"noofappusers":1,"created_at":"2023-06-15T11:40:43.000000Z","updated_at":"2023-06-15T11:40:43.000000Z"}

class BillModel {
  BillModel({
    this.success,
    this.data,
  });

  BillModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;
  BillModel copyWith({
    bool? success,
    Data? data,
  }) =>
      BillModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// id : 26
/// charges : "5000.00"
/// latecharges : "150.00"
/// appcharges : "50.00"
/// tax : "0.00"
/// balance : "5050.00"
/// payableamount : "5050.00"
/// totalpaidamount : "0.00"
/// subadminid : 2
/// residentid : 13
/// propertyid : 3
/// measurementid : 1
/// duedate : "2023-07-15"
/// billstartdate : "2023-06-01"
/// billenddate : "2023-06-30"
/// month : "June 2023"
/// billtype : "house"
/// paymenttype : "NA"
/// status : "unpaid"
/// isbilllate : 0
/// noofappusers : 1
/// created_at : "2023-06-15T11:40:43.000000Z"
/// updated_at : "2023-06-15T11:40:43.000000Z"

class Data {
  Data({
    this.id,
    this.charges,
    this.latecharges,
    this.appcharges,
    this.tax,
    this.balance,
    this.payableamount,
    this.totalpaidamount,
    this.subadminid,
    this.residentid,
    this.propertyid,
    this.measurementid,
    this.duedate,
    this.billstartdate,
    this.billenddate,
    this.month,
    this.billtype,
    this.paymenttype,
    this.status,
    this.isbilllate,
    this.noofappusers,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    charges = json['charges'];
    latecharges = json['latecharges'];
    appcharges = json['appcharges'];
    tax = json['tax'];
    balance = json['balance'];
    payableamount = json['payableamount'];
    totalpaidamount = json['totalpaidamount'];
    subadminid = json['subadminid'];
    residentid = json['residentid'];
    propertyid = json['propertyid'];
    measurementid = json['measurementid'];
    duedate = json['duedate'];
    billstartdate = json['billstartdate'];
    billenddate = json['billenddate'];
    month = json['month'];
    billtype = json['billtype'];
    paymenttype = json['paymenttype'];
    status = json['status'];
    isbilllate = json['isbilllate'];
    noofappusers = json['noofappusers'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? charges;
  String? latecharges;
  String? appcharges;
  String? tax;
  String? balance;
  String? payableamount;
  String? totalpaidamount;
  int? subadminid;
  int? residentid;
  int? propertyid;
  int? measurementid;
  String? duedate;
  String? billstartdate;
  String? billenddate;
  String? month;
  String? billtype;
  String? paymenttype;
  String? status;
  int? isbilllate;
  int? noofappusers;
  String? createdAt;
  String? updatedAt;
  Data copyWith({
    int? id,
    String? charges,
    String? latecharges,
    String? appcharges,
    String? tax,
    String? balance,
    String? payableamount,
    String? totalpaidamount,
    int? subadminid,
    int? residentid,
    int? propertyid,
    int? measurementid,
    String? duedate,
    String? billstartdate,
    String? billenddate,
    String? month,
    String? billtype,
    String? paymenttype,
    String? status,
    int? isbilllate,
    int? noofappusers,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        charges: charges ?? this.charges,
        latecharges: latecharges ?? this.latecharges,
        appcharges: appcharges ?? this.appcharges,
        tax: tax ?? this.tax,
        balance: balance ?? this.balance,
        payableamount: payableamount ?? this.payableamount,
        totalpaidamount: totalpaidamount ?? this.totalpaidamount,
        subadminid: subadminid ?? this.subadminid,
        residentid: residentid ?? this.residentid,
        propertyid: propertyid ?? this.propertyid,
        measurementid: measurementid ?? this.measurementid,
        duedate: duedate ?? this.duedate,
        billstartdate: billstartdate ?? this.billstartdate,
        billenddate: billenddate ?? this.billenddate,
        month: month ?? this.month,
        billtype: billtype ?? this.billtype,
        paymenttype: paymenttype ?? this.paymenttype,
        status: status ?? this.status,
        isbilllate: isbilllate ?? this.isbilllate,
        noofappusers: noofappusers ?? this.noofappusers,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['charges'] = charges;
    map['latecharges'] = latecharges;
    map['appcharges'] = appcharges;
    map['tax'] = tax;
    map['balance'] = balance;
    map['payableamount'] = payableamount;
    map['totalpaidamount'] = totalpaidamount;
    map['subadminid'] = subadminid;
    map['residentid'] = residentid;
    map['propertyid'] = propertyid;
    map['measurementid'] = measurementid;
    map['duedate'] = duedate;
    map['billstartdate'] = billstartdate;
    map['billenddate'] = billenddate;
    map['month'] = month;
    map['billtype'] = billtype;
    map['paymenttype'] = paymenttype;
    map['status'] = status;
    map['isbilllate'] = isbilllate;
    map['noofappusers'] = noofappusers;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
