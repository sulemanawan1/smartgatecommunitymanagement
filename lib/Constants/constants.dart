import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

final Color primaryColor = HexColor("#FF9900");

extension MySizedBox on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}

Future<bool?> myToast(
    {required msg,
    Color? backgroundColor,
    bool isNegative = false,
    ToastGravity? gravity}) async {
  bool? toast = await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: isNegative ? Colors.red : Colors.black,
      textColor: Colors.white,
      fontSize: 16.0.sp);
  return toast;
}
