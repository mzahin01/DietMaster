import 'package:diet_master/app/modules/registration/controllers/registration_controller.dart';
import 'package:diet_master/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationPageView extends GetView<RegistrationPageController> {
  const RegistrationPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('RegistrationPageView'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: controller.username,
                  decoration: const InputDecoration(
                      hintText: "Name", contentPadding: EdgeInsets.all(10)),
                ),
                TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                      hintText: "Email", contentPadding: EdgeInsets.all(10)),
                ),
                TextField(
                  controller: controller.passController,
                  decoration: const InputDecoration(
                      hintText: "Password", contentPadding: EdgeInsets.all(10)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(200, 20, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.register();
                    },
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOG_IN);
                  },
                  child: const Text('Log in instead'),
                ),
              ],
            ),
          ),
        ));
  }
}
