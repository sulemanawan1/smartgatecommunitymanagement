import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/Constants/constants.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/Module/Market%20Place/Controller/market_place_product_details_controller.dart';
import 'package:userapp/Widgets/My%20Button/my_button.dart';

import '../../../Constants/api_routes.dart';

class MarketPlaceProductDetails extends StatelessWidget {
  final MarketPlaceProductDetailsController controller =
      Get.put(MarketPlaceProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CarouselSlider(
              carouselController: controller.carouselController,
              items: (controller.snapShot.images as List)
                  .map((e) => Stack(
                        children: [
                          CachedNetworkImage(
                            width: 375.w,
                            height: 370.w,
                            fit: BoxFit.cover,
                            imageUrl: Api.imageBaseUrl + e.images.toString(),
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Obx(() {
                                return AnimatedSmoothIndicator(
                                  onDotClicked: (index) {
                                    controller.carouselController
                                        ?.animateToPage(index);
                                  },
                                  activeIndex: controller.carouselIndex.value,
                                  count: controller.snapShot.images!.length,
                                  effect: WormEffect(
                                      dotColor: Colors.white,
                                      dotWidth: 10.w,
                                      dotHeight: 10.w,
                                      activeDotColor: primaryColor),
                                );
                              }),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.h),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  16.67.w.pw,
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                  122.922.w.pw,
                                  Obx(() {
                                    return Text(
                                      '${controller.carouselIndex.value + 1}/${controller.snapShot.images!.length}',
                                      style: GoogleFonts.quicksand(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 320.w,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  onPageChanged: (int index, CarouselPageChangedReason c) {
                    controller.setCarouselIndex(index: index);
                  }),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    22.h.ph,
                    buildProductPrice(
                      price: "${controller.snapShot.productprice} Rs",
                    ),
                    12.h.ph,
                    buildProductName(
                        text: "${controller.snapShot.productname}"),
                    4.h.ph,
                    buildProductAddress(text: " ${controller.snapShot.status}"),
                    32.h.ph,
                    ProductCardWidget(column: [
                      20.h.ph,
                      ProductCardHeading(text: 'Product Details'),
                      16.h.ph,
                      ProductCardTextWidget(
                        heading: 'Contact',
                        text: "${controller.snapShot.contact}",
                        middleSizedBox: 60,
                      ),
                      ProductCardTextWidget(
                        heading: 'Category',
                        text: "${controller.snapShot.category}",
                        middleSizedBox: 50,
                      ),
                      ProductCardTextWidget(
                        heading: 'Condition',
                        text: "${controller.snapShot.condition}",
                        middleSizedBox: 50,
                      ),
                      ProductCardTextWidget(
                        heading: 'Post At',
                        text:
                            " ${DateHelper.convertLaravelDateFormatToDayMonthYearDateFormat(controller.snapShot.createdAt.toString())}",
                        middleSizedBox: 60,
                      ),
                      ProductCardTextWidget(
                        heading: 'Status',
                        text: " ${controller.snapShot.status}",
                        middleSizedBox: 66,
                      ),
                    ]),
                    32.h.ph,
                    ProductCardWidget(column: [
                      20.h.ph,
                      ProductCardHeading(text: 'Description'),
                      16.h.ph,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Text(
                          "${controller.snapShot.description}",
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              color: HexColor('#6A7380')),
                        ),
                      )
                    ]),
                    32.h.ph,
                    ProductCardWidget(column: [
                      20.h.ph,
                      ProductCardHeading(text: 'Owner Details'),
                      16.h.ph,
                      buildOwnerProfileCard(
                          firstName: controller.snapShot.users!.firstname,
                          lastName: controller.snapShot.users!.lastname,
                          residentType:
                              controller.snapShot.residents!.residenttype,
                          userCreatedAt: controller.snapShot.users!.createdAt,
                          userImage: controller.snapShot.users!.image),
                      16.h.ph,
                      buildOwnerAddress(
                          text: controller.snapShot.residents!.city),
                      Spacer(),
                      Center(
                        child: MyButton(
                          width: 288.w,
                          height: 42.w,
                          border: 12.r,
                          name: 'Contact Owner',
                          onPressed: () async {
                            controller.uri = Uri.parse(
                                "tel://${controller.snapShot.contact}");

                            try {
                              await launchUrl(controller.uri!);
                              controller.uri = null;
                            } catch (e) {
                              myToast(msg: e.toString(), isNegative: true);
                            }
                          },
                        ),
                      ),
                      20.h.ph,
                    ]),
                    50.h.ph,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOwnerAddress({required text}) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Row(
        children: [
          Icon(
            Icons.location_on_sharp,
            color: primaryColor,
          ),
          12.w.pw,
          Text(
            controller.snapShot.residents?.city.toString() ?? "N/A",
            style: GoogleFonts.quicksand(
                color: HexColor('#0D0B0C'),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget buildOwnerProfileCard(
      {required userImage,
      required firstName,
      required lastName,
      required residentType,
      required userCreatedAt}) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: SizedBox(
          width: 268.w,
          height: 74.w,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  10.w.pw,
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Container(
                      width: 64.w,
                      height: 64.w,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: CachedNetworkImage(
                        height: 64.w,
                        fit: BoxFit.fitHeight,
                        imageUrl: Api.imageBaseUrl + userImage,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  12.w.pw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.h.ph,
                        Text(
                          "${firstName} ${lastName}",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                              color: HexColor('#0D0B0C'),
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp),
                        ),
                        3.h.ph,
                        Text("${residentType}",
                            style: GoogleFonts.quicksand(
                                color: HexColor('#6A7380'),
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp)),
                        6.h.ph,
                        Row(
                          children: [
                            Text('Join At | ',
                                style: GoogleFonts.quicksand(
                                    color: HexColor('#6A7380'),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp)),
                            Text(
                                DateHelper
                                    .convertLaravelDateFormatToDayMonthYearDateFormat(
                                        userCreatedAt),
                                style: GoogleFonts.quicksand(
                                    color: HexColor('#6A7380'),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget buildProductAddress({required text}) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Text(
        text ?? '',
        style: GoogleFonts.quicksand(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: HexColor('#6A7380')),
      ),
    );
  }

  Widget buildProductName({required text}) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w),
      child: Text(
        text ?? "",
        style: GoogleFonts.quicksand(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: HexColor('#0D0B0C')),
      ),
    );
  }

  Widget buildProductPrice({required price}) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w),
      child: Row(
        children: [
          Text(
            price ?? "",
            style: GoogleFonts.quicksand(
                color: HexColor('#0D0B0C'),
                fontSize: 16.sp,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class ProductCardWidget extends StatelessWidget {
  final List<Widget> column;
  final double? height;

  const ProductCardWidget({super.key, required this.column, this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w),
      child: Container(
        decoration: BoxDecoration(
            color: HexColor('#F3F4F5'),
            borderRadius: BorderRadius.circular(16.r)),
        width: 328.w,
        height: height ?? 264.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: column,
        ),
      ),
    );
  }
}

class ProductCardHeading extends StatelessWidget {
  final String? text;

  const ProductCardHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Text(
        text ?? "",
        style: GoogleFonts.quicksand(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: HexColor('#0D0B0C')),
      ),
    );
  }
}

class ProductCardTextWidget extends StatelessWidget {
  final String? heading;
  final String? text;
  final double middleSizedBox;

  const ProductCardTextWidget(
      {super.key,
      required this.heading,
      required this.text,
      this.middleSizedBox = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                heading ?? "",
                style: GoogleFonts.quicksand(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: HexColor('#6A7380')),
              ),
              middleSizedBox.w.pw,
              Text(text ?? "",
                  style: GoogleFonts.quicksand(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: HexColor('#0D0B0C'),
                  ),
                  textAlign: TextAlign.start),
            ],
          ),
        ),
        15.h.ph
      ],
    );
  }
}
