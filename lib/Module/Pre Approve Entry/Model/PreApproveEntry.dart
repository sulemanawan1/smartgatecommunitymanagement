class PreApproveEntry {
  final int? id;
  final int? gatekeeperid;
  final int? userid;
  final String? visitortype;
  final String? name;
  final String? description;
  final String? cnic;
  final String? mobileno;
  final String? vechileno;
  final String? arrivaldate;
  final String? arrivaltime;
  final int? status;
  final String? statusdescription;
  final String? createdAt;
  final String? updatedAt;
  final String? checkInTime;
  final String? checkOutTime;

  PreApproveEntry(
      {required this.id,
      required this.gatekeeperid,
      required this.userid,
      required this.visitortype,
      required this.name,
      required this.description,
      required this.cnic,
      required this.mobileno,
      required this.vechileno,
      required this.arrivaldate,
      required this.arrivaltime,
      required this.status,
      required this.statusdescription,
      required this.createdAt,
      required this.updatedAt,
      required this.checkInTime,
      required this.checkOutTime});
}
