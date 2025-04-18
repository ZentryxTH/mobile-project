import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intrn/pages/authentication_page/login_page.dart';

class OnboardingController extends GetxController{
  static OnboardingController get Instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if(currentPageIndex.value == 2){
      Get.to(LoginPage());
    } else{
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    Get.to(LoginPage());
  }
  
}