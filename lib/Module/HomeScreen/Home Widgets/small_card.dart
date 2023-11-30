import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallCard extends StatelessWidget {
  final String? text;
  final String? iconPath;
  final double? iconWidth;
  final void Function()? onTap;

  const SmallCard(
      {super.key,
      required this.text,
      required this.iconPath,
      this.iconWidth,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 47.w,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0, 3),
              blurRadius: 4.r,
              spreadRadius: 0.3)
        ], color: Colors.white, borderRadius: BorderRadius.circular(28.r)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(13.w, 12.h, 0, 13.h),
              child: Text(
                text!,
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: Color(0xff9A9B9E)),
              ),
            ),
            SizedBox(width: 17.w),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15.h, 13.w, 16.h),
              child: SvgPicture.asset(
                iconPath!,
                width: 24.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
