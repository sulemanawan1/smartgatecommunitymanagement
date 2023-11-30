import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

import '../../Login/Model/User.dart';
import '../Model/MarketPlace.dart' as marketplace;

class MarketPlaceProductDetailsController extends GetxController {
  var carouselIndex = 0.obs;
  var data = Get.arguments;

  Uri? uri;

  late User user;
  var resident;
  late marketplace.Data snapShot;
  final carouselController = CarouselController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    user = data[0];
    resident = data[1];
    snapShot = data[2];

    print(snapShot.images!.length);
  }

  setCarouselIndex({required index}) {
    carouselIndex.value = index;
  }
}
