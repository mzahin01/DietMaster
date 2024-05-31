import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_master/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FirestoreServices {
  static saveUser(String name, email, uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'email': email, 'name': name});
  }
}

class RegistrationPageController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController username = TextEditingController();

  void register() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passController.text,
    )
        .then(
      (UserCredential cred) {
        FirestoreServices.saveUser(
          username.text,
          emailController.text,
          cred.user?.uid,
        );
        Get.offAllNamed(Routes.HOME);
      },
    );
  }
}
