import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Constants/constants.dart';

class HomeBottomAppBarIcon extends StatelessWidget {
  final String? text;
  final IconData icon;
  void Function()? onPressed;
  final Color? color;

  HomeBottomAppBarIcon(
      {required this.text, required this.icon, this.onPressed, this.color});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            icon!,
            color: color,
            size: 24.w,
          ),
          onPressed: onPressed,
        ),
        4.5.h.ph,
        Text(
          textAlign: TextAlign.center,
          text!,
          style: GoogleFonts.ubuntu(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: HexColor('#130F26')),
        ),
      ],
    );
  }
}
