import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Constants/constants.dart';

class ServiceCards extends StatelessWidget {
  final String? heading;
  final String? description;
  final String? iconPath;

  final void Function()? onTap;

  const ServiceCards(
      {super.key,
      required this.description,
      required this.heading,
      required this.iconPath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 145.63.w,
        height: 117.w,
        child: Card(
          child: Column(
            children: [
              12.h.ph,
              Container(
                height: 50.w,
                width: 50.w,
                margin: EdgeInsets.only(
                  left: 48.w,
                  right: 47.63.w,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath!.trim().toString()!,
                    width: 36.w,
                    // height: 33.67.w,
                  ),
                ),
                // decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     gradient: LinearGradient(
                //         colors: [
                //           Color(0xffFFFFFF).withOpacity(0.2),
                //           Color(0xffFF9900).withOpacity(0.7),
                //         ],
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter)),
              ),
              10.h.ph,
              Text(
                heading!,
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: HexColor('#222741')),
              ),
              2.h.ph,
              Text(
                description!,
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 8.sp,
                    color: HexColor('#8A8A8A')),
              ),
            ],
          ),
          //elevation: 1.6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ),
    );
  }
}
