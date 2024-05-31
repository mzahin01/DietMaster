import 'package:diet_master/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LogInPageController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      Get.offAllNamed(Routes.HOME);
      Get.snackbar('Contugralations!', 'Wellcome');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('WEAK!', 'Password Provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('REPEAT!', 'Email Provided already Exists');
      } else if (e.code == 'invalid-credential') {
        Get.snackbar('WRONG!', 'Email and Password does not match');
      }
    } catch (e) {
      Get.snackbar('WEAK!', e.toString());
    }
  }
}
