import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/constants.dart';

class Loader extends GetView {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          )),
        ],
      ),
    );
    ;
  }
}
