import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Constants/constants.dart';

class MyBackButton extends StatelessWidget {
  final String? text;
  final Widget? widget;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  const MyBackButton({this.text, this.widget, this.onTap, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        primaryColor,
        Color(0xffD83030),
      ])),
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Row(
          children: [
            15.w.pw,
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
              ),
              color: Colors.white,
              onPressed: onTap ??
                  () {
                    Get.back();
                  },
            ),
            15.w.pw,
            Text(
              text ?? "",
              style: GoogleFonts.ubuntu(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: Colors.white),
            ),
            Container(
              child: widget,
            )
          ],
        ),
      ),
    );
  }
}
