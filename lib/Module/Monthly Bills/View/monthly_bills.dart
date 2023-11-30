import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Module/Monthly%20Bills/Controller/monthly_bills_controller.dart';
import 'package:userapp/Module/Monthly%20Bills/Model/BillModel.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/Empty%20List/empty_list.dart';
import 'package:userapp/Widgets/My%20Back%20Button/my_back_button.dart';
import 'package:userapp/Widgets/My%20Button/my_button.dart';

import '../../../Widgets/Loader/loader.dart';

class MonthlyBills extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MonthlyBillsController>(
        init: MonthlyBillsController(),
        builder: (controller) {
          return SafeArea(
              child: WillPopScope(
            onWillPop: () async {
              Get.offNamed(homescreen, arguments: controller.userdata);

              return true;
            },
            child: Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    MyBackButton(
                      text: 'Monthly Bill',
                      onTap: () {
                        Get.offNamed(homescreen,
                            arguments: controller.userdata);
                      },
                    ),
                    Expanded(
                      child: FutureBuilder<BillModel>(
                          future: controller.futureData,
                          builder: (BuildContext context,
                              AsyncSnapshot<BillModel> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.data != null) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              10.h.ph,
                                              CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'assets/user.png'),
                                              ),
                                              10.h.ph,
                                              Text(
                                                'Smart Gate - Monthly Bill',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                snapshot.data!.data!.duedate
                                                    .toString(),
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey),
                                              ),
                                              30.h.ph,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'Amount Due',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20),
                                                  ),
                                                  Text(
                                                    'PKR ${snapshot.data!.data!.payableamount.toString()}',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                ],
                                              ),
                                              20.h.ph,
                                              MyBillWidget(
                                                  name: 'Charges',
                                                  description:
                                                      'PKR ${snapshot.data!.data!.charges.toString()}'),
                                              MyBillWidget(
                                                  name: 'App Charges',
                                                  description:
                                                      'PKR ${snapshot.data!.data!.appcharges!.toString()}'),
                                              MyBillWidget(
                                                  name: 'Tax',
                                                  description:
                                                      'PKR ${snapshot.data!.data!.tax.toString()}'),
                                              MyBillWidget(
                                                  name: 'No of App Users',
                                                  description: snapshot
                                                      .data!.data!.noofappusers
                                                      .toString()),
                                              20.h.ph,
                                              MyBillDivider(),
                                              20.h.ph,
                                              MyBillWidget(
                                                  name: 'Balance',
                                                  description:
                                                      'PKR ${snapshot.data!.data!.balance.toString()}'),
                                              20.h.ph,
                                              MyBillDivider(),
                                              MyBillWidget(
                                                  name: 'Billing Month',
                                                  description: snapshot
                                                      .data!.data!.month
                                                      .toString()),
                                              MyBillWidget(
                                                  name: 'Due Date',
                                                  description:
                                                      '${snapshot.data!.data!.duedate.toString()}'),
                                              MyBillDivider(),
                                              20.h.ph,
                                              MyButton(
                                                name: 'Pay',
                                                loading: controller.isLoading,
                                                color: Colors.green,
                                                onPressed: () {
                                                  if (!controller.isLoading) {
                                                    controller.payBillApi(
                                                        id: snapshot
                                                            .data!.data!.id!,
                                                        token: controller
                                                            .userdata
                                                            .bearerToken!,
                                                        totalPaidAmount: snapshot
                                                            .data!
                                                            .data!
                                                            .payableamount!);
                                                  }
                                                },
                                              ),
                                              20.h.ph,
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return EmptyList(
                                  name: 'You have no bill to paid.',
                                );
                              }
                            } else if (snapshot.hasError) {
                              return Icon(Icons.error);
                            } else {
                              return Loader();
                            }
                          }),
                    )
                  ],
                )),
          ));
        });
  }
}

class MyBillDivider extends StatelessWidget {
  const MyBillDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Divider(
        thickness: 1,
      ),
    );
  }
}

class MyBillWidget extends StatelessWidget {
  final String name;
  final String description;

  const MyBillWidget({required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    name,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600, color: Colors.grey),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    description,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
