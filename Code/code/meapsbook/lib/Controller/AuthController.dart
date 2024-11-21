import 'package:meapsbook/Config/Messages.dart';
import 'package:meapsbook/Pages/Homepage/HomePage.dart';
import 'package:meapsbook/Pages/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meapsbook/Pages/navbar_roots.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final auth = FirebaseAuth.instance;


  void loginWithEmail() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await auth.signInWithCredential(credential);
      successMessage('Login Success');
      Get.offAll(NavBarRoots());
    } catch (ex) {
      print(ex);
      errorMessage("Error ! Try Agin");
    }
    isLoading.value = false;
  }

  void signout() async {
    await auth.signOut();
    successMessage('Logout');
    Get.offAll(LoginPage());
  }

  void loginWithEmailPassword(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      successMessage('Login Success');
      Get.offAll(NavBarRoots());
    } catch (e) {
      print(e);
      errorMessage("Error ! Try Again");
    } finally {
      isLoading.value = false;
    }
  }

  void signUpWithEmailPassword(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      successMessage('Sign Up Success');
      Get.offAll(NavBarRoots());
    } catch (e) {
      print(e);
      errorMessage("Error ! Try Again");
    } finally {
      isLoading.value = false;
    }
  }

}
