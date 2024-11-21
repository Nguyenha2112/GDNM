import 'package:meapsbook/Pages/Homepage/HomePage.dart';
import 'package:meapsbook/Pages/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:meapsbook/Pages/navbar_roots.dart';

class SplaceController extends GetxController {
  final auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    splaceController();
  }

  void splaceController() {
    Future.delayed(Duration(seconds: 4), () {
      if (auth.currentUser != null) {
        Get.offAll(NavBarRoots());
      } else {
        Get.offAll(LoginPage());
      }
    });
  }
}
