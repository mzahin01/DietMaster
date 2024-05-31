import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  Rx<User?> user = Rx(null);
  RxnString username = RxnString();

  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen((User? u) {
      user.value = u;
      getUserName(u);
    });
    super.onInit();
  }

  Future<void> getUserName(User? user) async {
    if (user == null) {
      return;
    }
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    username.value = data.data()?['name'];
  }
}
