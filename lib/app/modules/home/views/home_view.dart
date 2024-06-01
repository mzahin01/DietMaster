import 'package:diet_master/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        floatingActionButton: controller.user.value != null
            ? FloatingActionButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Icon(Icons.logout),
              )
            : null,
        appBar: AppBar(
          title: const Text('Hello'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller.geminiTextController,
                  maxLines: null,
                  textAlign: TextAlign.center,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  controller.getRes();
                },
                color: Colors.amberAccent,
                child: const Text('Generate'),
              ),
              if (controller.user.value == null) ...[
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOG_IN);
                  },
                  child: const Text('Log in'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.REGISTRATION);
                  },
                  child: const Text('Register Now'),
                ),
              ] else
                Text(
                  'Salam,\n ${controller.username.value ?? 'No name found'}',
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
