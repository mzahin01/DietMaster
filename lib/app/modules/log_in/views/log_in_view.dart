import 'package:diet_master/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/log_in_controller.dart';

class LogInPageView extends GetView<LogInPageController> {
  const LogInPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('LogInPageView'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                      hintText: "Email", contentPadding: EdgeInsets.all(10)),
                ),
                TextField(
                  controller: controller.passController,
                  decoration: const InputDecoration(
                      hintText: "Password", contentPadding: EdgeInsets.all(10)),
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(200, 20, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.login();
                    },
                    child: const Text('Log in'),
                  ),
                ),
                const SizedBox(
                  height: 300,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.offNamed(Routes.REGISTRATION);
                  },
                  child: const Text('Register Now'),
                ),
              ],
            ),
          ),
        ));
  }
}
