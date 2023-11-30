import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/shared_preferences_constants.dart';
import '../../Module/Login/Model/User.dart';

class MySharedPreferences {
  static setUserData({required User user}) async {
    await SharedPreferences.getInstance().then((value) {
      value.setInt(userIdSPKey, user.userId ?? 0);
      value.setInt(subAminIdSPKey, user.subadminid ?? 0);
      value.setInt(familyMemberIdSPKey, user.familyMemberId ?? 0);
      value.setInt(residentIdSPKey, user.residentid ?? 0);
      value.setString(firstNameSPKey, user.firstName ?? '');
      value.setString(lastNameSPKey, user.lastName ?? '');
      value.setString(bearerTokenSPKey, user.bearerToken ?? '');
      value.setString(cnicSPKey, user.cnic ?? '');
      value.setString(roleNameSPKey, user.roleName ?? '');
      value.setInt(roleIdSPKey, user.roleId ?? 0);
      value.setString(addressSPKey, user.address ?? '');
    });
  }

  static Future<User> getUserData() async {
    User _user = User();
    await SharedPreferences.getInstance().then((value) {
      value.getInt(userIdSPKey) ?? value.setInt(userIdSPKey, 0);
      value.getInt(subAminIdSPKey) ?? value.setInt(subAminIdSPKey, 0);
      value.getInt(familyMemberIdSPKey) ?? value.setInt(familyMemberIdSPKey, 0);
      value.getInt(residentIdSPKey) ?? value.setInt(residentIdSPKey, 0);
      value.getString(firstNameSPKey) ?? value.setString(firstNameSPKey, '');
      value.getString(lastNameSPKey) ?? value.setString(lastNameSPKey, '');
      value.getString(bearerTokenSPKey) ??
          value.setString(bearerTokenSPKey, '');
      value.getString(cnicSPKey) ?? value.setString(cnicSPKey, '');

      value.getString(roleNameSPKey) ?? value.setString(roleNameSPKey, '');

      value.getInt(roleIdSPKey) ?? value.setInt(roleIdSPKey, 0);
      value.getString(addressSPKey) ?? value.setString(addressSPKey, '');

      _user = User(
        userId: value.getInt(userIdSPKey),
        subadminid: value.getInt(subAminIdSPKey),
        familyMemberId: value.getInt(familyMemberIdSPKey),
        residentid: value.getInt(residentIdSPKey),
        firstName: value.getString(firstNameSPKey),
        lastName: value.getString(lastNameSPKey),
        bearerToken: value.getString(bearerTokenSPKey),
        cnic: value.getString(cnicSPKey),
        roleId: value.getInt(roleIdSPKey),
        roleName: value.getString(roleNameSPKey),
        address: value.getString(addressSPKey),
      );
    });

    return _user;
  }

  static deleteUserData() async {
    await SharedPreferences.getInstance().then((value) {
      value.remove(userIdSPKey);
      value.remove(firstNameSPKey);
      value.remove(lastNameSPKey);
      value.remove(bearerTokenSPKey);
      value.remove(cnicSPKey);
      value.remove(roleNameSPKey);
      value.remove(roleIdSPKey);
      value.remove(addressSPKey);
      value.remove(residentIdSPKey);
      value.remove(familyMemberIdSPKey);
      value.remove(subAminIdSPKey);
    });
  }
}
