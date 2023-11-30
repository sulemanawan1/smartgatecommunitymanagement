import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Constants/constants.dart';

class HomeHeading extends StatelessWidget {
  final String? text;

  const HomeHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w),
      child: Column(
        children: [
          15.h.ph,
          Text(
            text!,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: HexColor('#3A3A3A')),
          ),
          15.h.ph,
        ],
      ),
    );
  }
}
