class User {
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? cnic;
  final String? address;
  final int? roleId;
  final int? subadminid;
  final int? familyMemberId;
  final int? residentid;
  final String? roleName;
  final String? bearerToken;

  User({
    this.userId,
    this.subadminid,
    this.firstName,
    this.lastName,
    this.familyMemberId,
    this.residentid,
    this.cnic,
    this.roleId,
    this.roleName,
    this.bearerToken,
    this.address,
  });
}
