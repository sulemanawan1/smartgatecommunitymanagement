import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Constants/constants.dart';

class FirstCard extends StatefulWidget {
  const FirstCard({
    super.key,
  });

  @override
  State<FirstCard> createState() => _FirstCardState();
}

class _FirstCardState extends State<FirstCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 162.w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffFF9900), Color(0xffD83030)],
          ),
          borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextField(
              //     style: GoogleFonts.ubuntu(
              //         color: Color(0xffF7F8FD),
              //         fontWeight: FontWeight.w500,
              //         fontSize: 14.sp),
              //     decoration: InputDecoration(
              //         contentPadding: EdgeInsets.fromLTRB(0, 4.h, 0, 0),
              //         focusedBorder: UnderlineInputBorder(
              //           borderSide: BorderSide(
              //             color: Color(0xffFFFFFF).withOpacity(0.3),
              //           ),
              //         ),
              //         enabledBorder: UnderlineInputBorder(
              //           borderSide: BorderSide(
              //             color: Color(0xffFFFFFF).withOpacity(0.3),
              //           ),
              //         ),
              //         hintText: 'Search',
              //         hintStyle: TextStyle(
              //             fontFamily: 'ubuntu',
              //             color: Color(0xffF7F8FD),
              //             fontWeight: FontWeight.w500,
              //             fontSize: 14.sp),
              //         suffixIconConstraints: BoxConstraints(maxHeight: 24),
              //         prefixIconConstraints: BoxConstraints(maxHeight: 24),
              //         prefixIcon: Wrap(
              //           children: [
              //             SvgPicture.asset(
              //               'assets/icons/home_screen_search_icon.svg',
              //               height: 24.h,
              //               width: 24.w,
              //               fit: BoxFit.scaleDown,
              //             ),
              //             SizedBox(
              //               width: 12,
              //             )
              //           ],
              //         ),
              //         suffixIcon: SvgPicture.asset(
              //           'assets/icons/home_screen_more_icon.svg',
              //           height: 24.h,
              //           width: 24.w,
              //           fit: BoxFit.scaleDown,
              //         ))),
              11.51.h.ph,
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "For any service support",
                          style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp,
                              color: Color(0xffFFFFFF)),
                        ),
                        Text(
                          "call us on xxx-xxxxxx",
                          style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Color(0xff000000)),
                        ),
                        6.h.ph,
                        Text(
                          "Or",
                          style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Color(0xff433F3F)),
                        ),
                        6.h.ph,
                        Text(
                          "Email us",
                          style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Color(0xffFFFFFF)),
                        ),
                        Text(
                          "smartgate@gmail.com",
                          style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Color(0xff000000)),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      "assets/home_vector.svg",
                      width: 127.73.w,
                      height: 79.w,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
