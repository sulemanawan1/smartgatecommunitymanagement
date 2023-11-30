/// message : "success"
/// data : [{"id":12,"subadminid":2,"type":"house","unit":"marla","charges":1000,"area":1,"bedrooms":2,"status":0,"created_at":"2023-02-16T11:22:49.000000Z","updated_at":"2023-02-16T11:22:49.000000Z"},{"id":13,"subadminid":2,"type":"house","unit":"marla","charges":3000,"area":3,"bedrooms":3,"status":0,"created_at":"2023-02-16T11:23:34.000000Z","updated_at":"2023-02-16T11:23:34.000000Z"},{"id":15,"subadminid":2,"type":"house","unit":"marla","charges":200,"area":5,"bedrooms":5,"status":0,"created_at":"2023-02-16T11:26:33.000000Z","updated_at":"2023-02-16T11:26:33.000000Z"},{"id":16,"subadminid":2,"type":"house","unit":"marla","charges":2000,"area":3,"bedrooms":5,"status":0,"created_at":"2023-02-16T11:37:11.000000Z","updated_at":"2023-02-16T11:37:11.000000Z"}]

class HousesApartmentsModel {


  final int? id;
  final int? subadminid;
  final int? charges;
  final int? area;
  final int? bedrooms;
  final int? status;
  final String? type;
  final String? unit;

  HousesApartmentsModel({required this.id,required this.subadminid,required this.charges,required this.area,required this.bedrooms,required this.status,required this.type,required this.unit});




}