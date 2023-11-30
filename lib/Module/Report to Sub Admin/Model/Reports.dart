class Reports {
  int? id;
  int? userid;
  int? subadminid;
  String? title;
  String? description;
  int? status;
  String? statusdescription;
  String? createdAt;
  String? updatedAt;

  Reports(
      {required this.id,
      required this.userid,
      required this.subadminid,
      required this.title,
      required this.description,
      required this.status,
      required this.statusdescription,
      required this.createdAt,
      required this.updatedAt});
}
