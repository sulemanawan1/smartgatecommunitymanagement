import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Constants/constants.dart';

import '../My Elipse/my_elipse.dart';

class DialogBoxElipseHeading extends StatelessWidget {
  final String? text;

  const DialogBoxElipseHeading({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyElipse(),
        11.w.pw,
        Text(
          text ?? "",
          style: GoogleFonts.ubuntu(
            color: HexColor('#4D4D4D'),
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
          ),
        )
      ],
    );
  }
}
